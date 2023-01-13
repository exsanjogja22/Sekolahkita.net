import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class DatabaseInstace {
  final String _databaseName = "my_database.db";
  final int _databaseVersion = 1;
  Database? db;

  final String nameTable = "soal";
  final String id = "id";
  final String path = "path";
  final String createdAt = "create_at";
  final String updatedAt = "update_at";

  Future<Database> database() async {
    if (db != null) {
      return db!;
    } else {
      db = await _initDatabase();
      return db!;
    }
  }

  Future _initDatabase() async {
    Directory documentsdirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsdirectory.path, _databaseName);
    return openDatabase(path,
        version: _databaseVersion, onCreate: _onCreteDatabase);
  }

  Future _onCreteDatabase(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $nameTable ($id INTEGER PRIMARY KEY, $path TEXT, $createdAt TEXT, $updatedAt TEXT)');
  }
}
