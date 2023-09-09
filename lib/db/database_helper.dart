import 'dart:async';

import 'package:fitness_app_bloc/config/app_string.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  Future<Database> database() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(join(dbPath, 'information_data.db'),
        onCreate: (db, version) async {
      await db.execute('CREATE TABLE ${AppString.informationTable}('
          '${AppString.id} INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL ,'
          '${AppString.dateTime} TEXT NOT NULL,'
          '${AppString.gender} TEXT NOT NULL,'
          '${AppString.age} TEXT NOT NULL,'
          '${AppString.height} TEXT NOT NULL,'
          '${AppString.weight} TEXT NOT NULL,'
          '${AppString.activity} TEXT NOT NULL,'
          '${AppString.target} TEXT NOT NULL,'
          '${AppString.bodyFat} INTEGER NOT NULL )');
      await db.execute('CREATE TABLE ${AppString.historyTable}('
          '${AppString.id} INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL ,'
          '${AppString.dateTime} TEXT NOT NULL,'
          'DateTimeEnd TEXT NOT NULL,'
          '${AppString.methodExercise} TEXT NOT NULL,'
          '${AppString.exercise} TEXT NOT NULL,'
          '${AppString.restTime} TEXT NOT NULL)');
      await db.execute('CREATE TABLE ${AppString.repTimeTable}('
          '${AppString.id} INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'
          '${AppString.dateTime} TEXT NOT NULL,'
          '${AppString.exercise} TEXT NOT NULL,'
          '${AppString.setNumber} TEXT NOT NULL,'
          '${AppString.weight} TEXT NOT NULL,'
          '${AppString.timeAtSet} TEXT NOT NULL,'
          '${AppString.rep} TEXT NOT NULL)');
    }, version: 1);
  }

  Future<List<Map<String, Object?>>> getData(String table) async {
    final sqlDb = await DbHelper().database();
    List<Map<String, Object?>> newList = await sqlDb.query(
      table,
    );
    return newList;
  }

  Future<void> insert(String table, Map<String, Object> data) async {
    final sqlDb = await DbHelper().database();
    sqlDb.insert(
      table,
      data,
    );
  }
}
