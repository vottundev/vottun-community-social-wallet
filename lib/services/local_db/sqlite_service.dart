
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqliteService {

  final String dbName = "database.db";


  Future<Database> initDB() async {

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);

    bool exists = await databaseExists(path);

    if (!exists) {

      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (exception) {
        print("exception: $exception");
      }

      //copy from asset
      ByteData data = await rootBundle.load(join("assets", "database.db"));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      //write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print("Opening existing database");
    }

    return await openDatabase(path,onCreate: (database, version) async {
      await database.execute(
        "CREATE TABLE Users(id INTEGER PRIMARY KEY AUTOINCREMENT, email TEXT NOT NULL UNIQUE, username TEXT NOT NULL UNIQUE, address TEXT NOT NULL UNIQUE)",
      );
    }, version: 1);
  }

  /*Future<int> createUser(Str) async {
    int result = 0;
    final Database db = await initDB();
    final id = await db.insert('User', values)
  }*/

}