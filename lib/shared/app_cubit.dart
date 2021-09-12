import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

part 'app_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppStateInitial());

  Database database;
  List<Map> queryResult = [];
  List<Map> oneWeekQueryResult = List.generate(7, (index) {
    return {
      'date': DateTime.now().subtract(Duration(days: index)).toIso8601String(),
      'calories': 0.0,
      'co2': 0.0
    };
  });
  List<Map> oneMonthQueryResult = List.generate(30, (index) {
    return {
      'date': DateTime.now().subtract(Duration(days: index)).toIso8601String(),
      'calories': 0.0,
      'co2': 0.0
    };
  });
  List<Map> threeMonthsQueryResult = List.generate(90, (index) {
    return {
      'date': DateTime.now().subtract(Duration(days: index)).toIso8601String(),
      'calories': 0.0,
      'co2': 0.0
    };
  });

  List<double> oneWeekCals = List.generate(7, (index) => 0.0);
  List<double> oneWeekCo2 = List.generate(7, (index) => 0.0);

  List<double> oneMonthCals = List.generate(30, (index) => 0.0);
  List<double> oneMonthCo2 = List.generate(30, (index) => 0.0);

  List<double> threeMonthsCals = List.generate(90, (index) => 0.0);
  List<double> threeMonthsCo2 = List.generate(90, (index) => 0.0);

  void init() {
    queryResult = [];
    oneWeekQueryResult = List.generate(7, (index) {
      return {
        'date':
            DateTime.now().subtract(Duration(days: index)).toIso8601String(),
        'calories': 0.0,
        'co2': 0.0
      };
    });
    oneMonthQueryResult = List.generate(30, (index) {
      return {
        'date':
            DateTime.now().subtract(Duration(days: index)).toIso8601String(),
        'calories': 0.0,
        'co2': 0.0
      };
    });
    threeMonthsQueryResult = List.generate(90, (index) {
      return {
        'date':
            DateTime.now().subtract(Duration(days: index)).toIso8601String(),
        'calories': 0.0,
        'co2': 0.0
      };
    });
    oneWeekCals = List.generate(7, (index) => 0.0);
    oneWeekCo2 = List.generate(7, (index) => 0.0);

    oneMonthCals = List.generate(30, (index) => 0.0);
    oneMonthCo2 = List.generate(30, (index) => 0.0);

    threeMonthsCals = List.generate(90, (index) => 0.0);
    threeMonthsCo2 = List.generate(90, (index) => 0.0);
  }

  static AppCubit instance(BuildContext context) => BlocProvider.of(context);

  Future<void> createDB(String usersTableName, String goalTableName) async {
    //logic to save last user and the corresponding db version
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    if (!_prefs.containsKey('uidList')) {
      //first time in app
      _prefs.setStringList('uidList', [usersTableName]);
      _prefs.setInt('version', 1);
      print('first time:DB version is 1');
    } else {
      List<String> uidList = _prefs.getStringList('uidList');
      int lastVersion = _prefs.getInt('version');
      if (!uidList.contains(usersTableName)) {
        //brand new user
        uidList.add(usersTableName);
        int version = lastVersion + 1;
        _prefs.setStringList('uidList', uidList);
        _prefs.setInt('version', version);
        print('this is new user so we will upgrade DB version to $version');
      } else {
        print(
            'user logged before: no upgrading to db as the table will be found');
        // logged before
        //use the same db version so it will find the table
      }
    }

    openDatabase('food.db', version: _prefs.getInt('version'),
        onCreate: (Database db, int version) async {
      db
          .execute(
              'CREATE TABLE $usersTableName (date TEXT PRIMARY KEY, calories REAL, co2 REAL)')
          .catchError((error) {
        print('Error When Creating Table ${error.toString()}');
      }).then((value) {
        db
            .execute(
                'CREATE TABLE $goalTableName (userId TEXT PRIMARY KEY, co2Goal INTEGER, goalName TEXT, startDate TEXT, image BLOB )')
            .catchError((error) {
          print('Error When Creating Table ${error.toString()}');
        }).then((value) {
          print('Table $goalTableName is created');
          emit(DatabaseTableCreatedState());
          countDBRecords(db, usersTableName);
          // getDataFromDatabase(db, tableName);
          emit(DatabaseOpenedState());
        });
        print('Table $usersTableName is created');
        emit(DatabaseTableCreatedState());
        countDBRecords(db, usersTableName);
        // getDataFromDatabase(db, tableName);
        emit(DatabaseOpenedState());
      });
    }, onUpgrade: (Database db, int version, int i) async {
      print(
          'database upgraded as new user logged with version: $version, with: $i');
      db
          .execute(
              'CREATE TABLE $usersTableName (date TEXT PRIMARY KEY, calories REAL, co2 REAL)')
          .catchError((error) {
        print('Error When Creating Table ${error.toString()}');
      }).then((value) {
        print('Table $usersTableName is created');
        emit(DatabaseTableCreatedState());
        countDBRecords(db, usersTableName);
        // getDataFromDatabase(db, tableName);
        emit(DatabaseOpenedState());
      });
    }, onOpen: (Database db) {
      print('Database opened');
    }).then((value) {
      database = value;
      print('Database is created successfully');
      emit(DatabaseCreatedState());
    });
  }

  Future<void> insertIntoDB(
      String tableName, Map<String, dynamic> recordValues) async {
    database.insert(tableName, recordValues,
        conflictAlgorithm: ConflictAlgorithm.replace);
    print('inserted: $recordValues in table: $tableName');
    // await database.transaction((txn) async {
    //   txn
    //       .rawInsert(
    //     'INSERT INTO $tableName (date, calories, co2) VALUES("$date", "$calories", "$co2")',
    //   )
    //       .then((value) {
    //     print('Database inserted with $value fields updated');
    //     emit(DatabaseInsertedState());
    //     getDataFromDatabase(database, tableName);
    //   }).catchError((error) {
    //     print('Error When Inserting New Record ${error.toString()}');
    //   });
    // }).then((value) {});
    countDBRecords(database, tableName);
  }

  Future<void> updateFieldInDB({
    String tableName,
    String updatedDate,
    String updatedCalories,
    String updatedCo2,
  }) async {
    database.rawUpdate(
        'UPDATE $tableName SET calories = ?, co2 = ? WHERE data = ?',
        [updatedCalories, updatedCo2, updatedDate]).then((value) {
      print('Database updated record: $value');
      emit(DatabaseUpdatedState(updatedRecordID: value));
    });
  }

  Future<void> getDataFromDatabase(String tableName,
      {bool distinct,
      List<String> columns,
      String where,
      List<dynamic> whereArgs,
      String groupBy,
      String having,
      String orderBy,
      int limit,
      int offset}) async {
    emit(DatabaseGetLoadingState());
    database
        .query(tableName,
            distinct: distinct,
            columns: columns,
            where: where,
            whereArgs: whereArgs,
            groupBy: groupBy,
            having: having,
            orderBy: orderBy,
            limit: limit,
            offset: offset)
        .then((value) {
      queryResult = value;
      print('retrived ${value.length}');
      value.forEach((element) {});
      int count = queryResult.length;
      print('Database counted: $count');
      emit(DatabaseGetState());
    });
  }

  Future<List<Map<String, dynamic>>> getDataFromDatabase2(String tableName,
      {bool distinct,
      List<String> columns,
      String where,
      List<dynamic> whereArgs,
      String groupBy,
      String having,
      String orderBy,
      int limit,
      int offset}) async {
    return database.query(tableName,
        distinct: distinct,
        columns: columns,
        where: where,
        whereArgs: whereArgs,
        groupBy: groupBy,
        having: having,
        orderBy: orderBy,
        limit: limit,
        offset: offset);
  }

  Future<void> deleteDataFromDatabase({
    @required String tableName,
    @required String where,
    @required List<dynamic> whereArgs,
  }) async {
    database
        .delete(tableName, where: where, whereArgs: whereArgs)
        .then((value) {
      print('number of row deleted is: $value');
      emit(DatabaseRecordDeletedState());
    });
  }

  Future<void> getOneWeekData(Database database, String tableName,
      {DateTime date, bool forwardDirection = false}) async {
    // emit(DatabaseGetLoadingState());
    DateTime now;
    if (forwardDirection) {
      now = date.add(Duration(days: 7)) ?? DateTime.now();
    } else {
      now = date ?? DateTime.now();
    }
    now = DateTime(now.year, now.month, now.day);
    database.query(tableName,
        limit: 7,
        where: "date > ? and date <= ?",
        orderBy: 'date DESC',
        whereArgs: [
          now.subtract(Duration(days: 7)).toIso8601String(),
          now.toIso8601String()
        ]).then((value) {
      oneWeekQueryResult.setAll(0, value);
      print('retrived ${value.length}');
      // oneWeekCals = [];
      // oneWeekCo2 = [];
      int i = 0;
      value.forEach((element) {
        print(
            '${element['date']}: calories: ${element['calories']}, co2: ${element['co2']}');
        oneWeekCals[i] = element['calories'];
        oneWeekCo2[i] = element['co2'];
        // oneWeekCals.add(element['calories']);
        // oneWeekCo2.add(element['co2']);
        i++;
      });
      emit(DatabaseGetState());
    });
  }

  Future<void> getOneMonthData(Database database, String tableName) async {
    // emit(DatabaseGetLoadingState());
    DateTime now = DateTime.now();
    now = DateTime(now.year, now.month, now.day);
    database.query(tableName,
        limit: 31,
        where: "date > ? and date <= ?",
        whereArgs: [
          now.subtract(Duration(days: 30)).toIso8601String(),
          now.toIso8601String()
        ]).then((value) {
      oneMonthQueryResult.setAll(0, value);
      print('retrived ${value.length}');
      // oneMonthCals = [];
      // oneMonthCo2 = [];
      int i = 0;
      value.forEach((element) {
        print(
            '${element['date']}: calories: ${element['calories']}, co2: ${element['co2']}');
        oneMonthCals[i] = element['calories'];
        oneMonthCo2[i] = element['co2'];
        i++;
      });
      emit(DatabaseGetState());
    });
  }

  Future<void> getThreeMonthData(Database database, String tableName) async {
    // emit(DatabaseGetLoadingState());
    DateTime now = DateTime.now();
    now = DateTime(now.year, now.month, now.day);
    database.query(tableName,
        limit: 90,
        where: "date > ? and date <= ?",
        whereArgs: [
          now.subtract(Duration(days: 90)).toIso8601String(),
          now.toIso8601String()
        ]).then((value) {
      threeMonthsQueryResult.setAll(0, value);

      print('retrived ${value.length}');
      // threeMonthsCals = [];
      // threeMonthsCo2 = [];
      int i = 0;
      value.forEach((element) {
        print(
            '${element['date']}: calories: ${element['calories']}, co2: ${element['co2']}');
        threeMonthsCals[i] = element['calories'];
        threeMonthsCo2[i] = element['co2'];
        // threeMonthsCals.add(element['calories']);
        // threeMonthsCo2.add(element['co2']);
        i++;
      });
      emit(DatabaseGetState());
    });
  }

  void countDBRecords(Database db, String tableName) async {
    List<Map> result = await db.query(
      tableName,
    );
    int count = result.length;
    print('Database counted: $count');
    emit(DatabaseCountedState(count: count));
  }
}
