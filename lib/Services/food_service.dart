import 'dart:io';
import 'package:flutter/services.dart';
import 'package:food_app/Models/food.dart';
//import 'package:food_app/Models/trail.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  Database _db;

  initDatabase() async {
    _db = await openDatabase('assets/fooddb.db');
    var databasePath = await getDatabasesPath();
    var path = join(databasePath, 'fooddb.db');

    //Check if DB exists
    var exists = await databaseExists(path);

    if (!exists) {
      print('Create a new copy from assets');

      //Check if parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      //Copy from assets
      ByteData data = await rootBundle.load(join("assets", "fooddb.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      //Write and flush the bytes
      await File(path).writeAsBytes(bytes, flush: true);
    }

    //Open the database
    _db = await openDatabase(path, readOnly: true);
  }

  Future<List<FoodSQL>> getFoods() async {
    await initDatabase();
    List<Map> list = await _db.rawQuery('SELECT * FROM Foods');
    return list.map((foods) => FoodSQL.fromJson(foods)).toList();
  }

  dispose() {
    _db.close();
  }
}
