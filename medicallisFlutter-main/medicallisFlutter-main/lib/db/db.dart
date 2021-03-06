import 'package:sqflite/sqflite.dart';
import "package:ffi/ffi.dart";

import '../models/reminder.dart';

class db {
  static Database? _db;

  static final int _version = 32;
  static final String _tableName = "reminders1";

  static Future<void> initDB() async {
    if (_db != null) {
      return;
    }
    try {
      String _path = await getDatabasesPath() + "reminders2.db";

      _db = await openDatabase(
        _path,
        version: _version,
        onCreate: (db, version) async {
          print(" a new database has been created ");
          await db.execute("CREATE TABLE $_tableName ("
              "id INTEGER PRIMARY KEY AUTOINCREMENT,"
              "name STRING, dosage STRING, type STRING, note STRING"
              ", date STRING,  startTime STRING, endTime  STRING ,"
              "remind STRING, repeat STRING, isCompleted INTEGER)");
          await db.execute("CREATE TABLE test ("
              "id INTEGER PRIMARY KEY AUTOINCREMENT,"
              "Weight STRING, Time STRING, BloodSugar STRING, BloodPressure STRING)");
        },
      );
    } catch (e) {
      print(e);
    }
  }

  static Future<int> insert(reminder? reminder) async {
    print('insert function');
    return await _db?.insert(_tableName, reminder!.toJson()) ?? 1;
  }

  static Future<List<Map<String, dynamic>>> query() async {
    print('query function called');
    return await _db!.query(_tableName);
  }

  static delete(reminder rem) async {
    await _db!.delete(_tableName, where: 'id=?', whereArgs: [rem.id]);
  }

  static update(int id) async {
    return await _db!.rawUpdate(''' 
    UPDATE reminders1 
    SET isCompleted= ?
    WHERE id= ?
    ''', [1, id]);
  }

  // trackers
  static Future<int> inserttrc(tracker? trc) async {
    print('insert function for trackers');
    return await _db?.insert('test', trc!.toJson()) ?? 1;
  }

  static Future<List<Map<String, dynamic>>> querytrc() async {
    print('query function called for trackers');
    return await _db!.query('test');
  }
}
