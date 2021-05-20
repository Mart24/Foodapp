import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseRepository {
  DatabaseRepository._privateConstructor();

  static final DatabaseRepository instance =
      DatabaseRepository._privateConstructor();

  final _databaseName = 'database2';
  final _databaseVersion = 1;

  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _initDatabase();
    }
  }

  _initDatabase() async {
    Directory documents = await getApplicationDocumentsDirectory();
    String path = join(documents.path + _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: await onCreate);
  }

  Future onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE contact (
            contactId INTEGER PRIMARY KEY AUTOINCREMENT,
            contactName STRING NOT NULL,
            contactSurname STRING NOT NULL
          )
          ''');
  }
}
