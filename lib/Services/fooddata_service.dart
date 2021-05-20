import 'dart:io';
import 'package:flutter/services.dart';
import 'package:food_app/Models/fooddata.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  DatabaseService();

  static final DatabaseService instance = DatabaseService();

  Database db;
  final dbProvider = DatabaseService.instance;

  Future<Database> get database async {
    if (db != null) {
      return db;
    } else {
      db = await initDatabase();
    }
  }

  initDatabase() async {
    db = await openDatabase('assets/fooddata.db');
    var databasePath = await getDatabasesPath();
    var path = join(databasePath, 'fooddata.db');

    //Check if DB exists
    var exists = await databaseExists(path);

    if (!exists) {
      print('Create a new copy from assets');

      //Check if parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      //Copy from assets
      ByteData data = await rootBundle.load(join("assets", "fooddata.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      //Write and flush the bytes
      await File(path).writeAsBytes(bytes, flush: true);
    }

    //Open the database
    db = await openDatabase(path, readOnly: true);
  }

  Future<List<FooddataSQL>> getFooddata() async {
    await initDatabase();
    List<Map<String, dynamic>> allRows = await db.query('exampledata');
    List<FooddataSQL> fooddatas =
        allRows.map((fooddata) => FooddataSQL.fromMap(fooddata)).toList();
    return fooddatas;
  }

  Future<List<FooddataSQL>> searchContacts(String keyword) async {
    await initDatabase();
    List<Map<String, dynamic>> allRows = await db.query('exampledata',
        where: 'productName LIKE ?', whereArgs: ['%$keyword%']);
    List<FooddataSQL> fooddatas =
        allRows.map((fooddata) => FooddataSQL.fromMap(fooddata)).toList();
    return fooddatas;
  }

  dispose() {
    db.close();
  }
}
