import 'package:sqflite/sqflite.dart'; //sqflite package
import 'package:path_provider/path_provider.dart'; //path_provider package
import 'package:path/path.dart'; //used to join paths//import model class
import 'dart:io';
import 'dart:async';

class DBProvider {
  static final DBProvider db = DBProvider._internal();

  factory DBProvider() {
    return db;
  }

  DBProvider._internal();

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, "Testtodo.db");
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute("""CREATE TABLE User (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          username TEXT,
          password TEXT,
          email TEXT
          )""");
      await db.execute("""CREATE TABLE TODOUSER(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          userid INTEGER,
          title TEXT,
          description TEXT,
          date TEXT
          )""");
    });
  }
}
