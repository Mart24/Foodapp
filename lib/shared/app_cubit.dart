import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  List<Map> oneWeekQueryResult = [];
  List<Map> oneMonthQueryResult = [];
  List<Map> threeMonthsQueryResult = [];

  List<double> oneWeekCals = [];
  List<double> oneWeekCo2 = [];

  List<double> oneMonthCals = [];
  List<double> oneMonthCo2 = [];

  List<double> threeMonthsCals = [];
  List<double> threeMonthsCo2 = [];

  static AppCubit instance(BuildContext context) => BlocProvider.of(context);

  Future<void> createDB(String tableName) async {
    //logic to save last user and the corresponding db version
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    if (!_prefs.containsKey('uidList')) {
      //first time in app
      _prefs.setStringList('uidList', [tableName]);
      _prefs.setInt('version', 1);
    } else {
      List<String> uidList = _prefs.getStringList('uidList');
      int lastVersion = _prefs.getInt('version');
      if (!uidList.contains(tableName)) {
        //brand new user
        uidList.add(tableName);
        int version = lastVersion + 1;
        _prefs.setStringList('uidList', uidList);
        _prefs.setInt('version', version);
      } else {
        // logged before
        //use the same db version so it will find the table
      }
    }

    openDatabase('food.db', version: _prefs.getInt('version'),
        onCreate: (Database db, int version) async {
      db
          .execute(
              'CREATE TABLE $tableName (date TEXT PRIMARY KEY, calories REAL, co2 REAL)')
          .catchError((error) {
        print('Error When Creating Table ${error.toString()}');
      }).then((value) {
        print('Table created');
        emit(DatabaseTableCreatedState());
        countDBRecords(db, tableName);
        // getDataFromDatabase(db, tableName);
        emit(DatabaseOpenedState());
      });
    }, onUpgrade: (Database db, int version, int i) async {
      print(
          'database upgraded as new user logged with version: $version, with: $i');
      db
          .execute(
              'CREATE TABLE $tableName (date TEXT PRIMARY KEY, calories REAL, co2 REAL)')
          .catchError((error) {
        print('Error When Creating Table ${error.toString()}');
      }).then((value) {
        print('Table created');
        emit(DatabaseTableCreatedState());
        countDBRecords(db, tableName);
        // getDataFromDatabase(db, tableName);
        emit(DatabaseOpenedState());
      });
    }, onOpen: (Database db) {
      print('Database opened');
    }).then((value) {
      database = value;
      print('Database created');
      emit(DatabaseCreatedState());
    });
  }

  void insertIntoDB(
    String tableName,
    String date,
    num calories,
    num co2,
  ) {
    // print('$tableName: $date, cal:$calories, co2:$co2');

    database.insert(tableName, {'date': date, 'calories': calories, 'co2': co2},
        conflictAlgorithm: ConflictAlgorithm.replace);

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

  // Future<void> getDataFromDatabase(Database database, String tableName,
  //     {bool distinct,
  //     List<String> columns,
  //     String where,
  //     List<dynamic> whereArgs,
  //     String groupBy,
  //     String having,
  //     String orderBy,
  //     int limit,
  //     int offset}) async {
  //   emit(DatabaseGetLoadingState());
  //   database
  //       .query(tableName,
  //           distinct: distinct,
  //           columns: columns,
  //           where: where,
  //           whereArgs: whereArgs,
  //           groupBy: groupBy,
  //           having: having,
  //           orderBy: orderBy,
  //           limit: limit,
  //           offset: offset)
  //       .then((value) {
  //     queryResult = value;
  //     print('retrived ${value.length}');
  //     value.forEach((element) {
  //       print(
  //           '${element['date']}: calories: ${element['calories']}, co2: ${element['co2']}');
  //     });
  //     int count = queryResult.length;
  //     print('Database counted: $count');
  //     emit(DatabaseGetState());
  //   });
  // }

  Future<void> getOneWeekData(Database database, String tableName) async {
    emit(DatabaseGetLoadingState());
    DateTime now = DateTime.now();
    now = DateTime(now.year, now.month, now.day);
    database.query(tableName,
        limit: 7,
        where: "date > ? and date <= ?",
        whereArgs: [
          now.subtract(Duration(days: 7)).toIso8601String(),
          now.toIso8601String()
        ]).then((value) {
      oneWeekQueryResult = value;
      print('retrived ${value.length}');
      oneWeekCals=[];
      oneWeekCo2=[];
      value.forEach((element) {
        print(
            '${element['date']}: calories: ${element['calories']}, co2: ${element['co2']}');
        oneWeekCals.add(element['calories']);
        oneWeekCo2.add(element['co2']);
      });
      emit(DatabaseGetState());
    });
  }

  Future<void> getOneMonthData(Database database, String tableName) async {
    emit(DatabaseGetLoadingState());
    DateTime now = DateTime.now();
    now = DateTime(now.year, now.month, now.day);
    database.query(tableName,
        limit: 31,
        where: "date > ? and date <= ?",
        whereArgs: [
          now.subtract(Duration(days: 30)).toIso8601String(),
          now.toIso8601String()
        ]).then((value) {
      oneMonthQueryResult = value;
      print('retrived ${value.length}');
      oneMonthCals=[];
      oneMonthCo2=[];
      value.forEach((element) {
        print(
            '${element['date']}: calories: ${element['calories']}, co2: ${element['co2']}');
        oneMonthCals.add(element['calories']);
        oneMonthCo2.add(element['co2']);
      });

      emit(DatabaseGetState());
    });
  }

  Future<void> getThreeMonthData(Database database, String tableName) async {
    emit(DatabaseGetLoadingState());
    DateTime now = DateTime.now();
    now = DateTime(now.year, now.month, now.day);
    database.query(tableName,
        limit: 90,
        where: "date > ? and date <= ?",
        whereArgs: [
          now.subtract(Duration(days: 90)).toIso8601String(),
          now.toIso8601String()
        ]).then((value) {
      threeMonthsQueryResult = value;
      print('retrived ${value.length}');
      threeMonthsCals=[];
      threeMonthsCo2=[];
      value.forEach((element) {
        print(
            '${element['date']}: calories: ${element['calories']}, co2: ${element['co2']}');
        threeMonthsCals.add(element['calories']);
        threeMonthsCo2.add(element['co2']);
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
