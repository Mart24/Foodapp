import 'dart:io';
import 'package:flutter/services.dart';
import 'package:food_app/Models/fooddata_json.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// This is the class for the SQL database to let users search for food
// I have the fooddata.db file in assets
// This database lists the productid and the productname
// Users can search for the productnames
// When the food is selected, the firebase database queries the productid and show the correpsonding fooddata

class DatabaseService {
  Database _db;

  initDatabase() async {
    _db = await openDatabase('assets/fooddata.db');
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
    _db = await openDatabase(path, readOnly: true);
  }

  Future<List<FooddataSQLJSON>> getFooddata() async {
    await initDatabase();
    List<Map> list = await _db.rawQuery('SELECT * FROM exampledata');
    return list
        .map((foodddata) => FooddataSQLJSON.fromJson(foodddata))
        .toList();
  }

  Future<List<FooddataSQLJSON>> searchFooddata(String keyword) async {
    await initDatabase();
    List<Map> list = await _db
        .rawQuery("SELECT * FROM exampledata WHERE name LIKE '%$keyword%'");
    return list
        .map((foodddata) => FooddataSQLJSON.fromJson(foodddata))
        .toList();
  }
  // Future<List<FooddataSQLJSON>> searchFooddata(String keyword) async {
  //   final db = await initDatabase();
  //   List<Map> list = await _db
  //       .query('exampledata', where: 'name LIKE ?', whereArgs: ['%keyword%']);
  //   return list
  //       .map((foodddata) => FooddataSQLJSON.fromJson(foodddata))
  //       .toList();
  // }

  dispose() {
    _db.close();
  }
}
