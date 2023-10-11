import 'package:fitness_app_bloc/config/config.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbAnalytics {
  Future<Database> database() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(join(dbPath, 'analytics_data.db'),
        onCreate: (db, version) async {
      await db.execute('CREATE TABLE ${AppString.workoutSchedule}('
          '${AppString.id} INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL ,'
          '${AppString.dateTime} TEXT NOT NULL,'
          '${AppString.mon} TEXT NOT NULL,'
          '${AppString.tue} TEXT NOT NULL,'
          '${AppString.wed} TEXT NOT NULL,'
          '${AppString.thu} TEXT NOT NULL,'
          '${AppString.fri} TEXT NOT NULL,'
          '${AppString.sat} TEXT NOT NULL,'
          '${AppString.sun} TEXT NOT NULL,'
          '${AppString.activity} INTEGER NOT NULL,'
          '${AppString.use} INTEGER NOT NULL )');
    }, version: 1);
  }

  Future<List<Map<String, Object?>>> getData(String table) async {
    final sqlDb = await DbAnalytics().database();
    List<Map<String, Object?>> newList = await sqlDb.query(
      table,
    );
    return newList;
  }

  Future<void> insert(String table, Map<String, Object> data) async {
    final sqlDb = await DbAnalytics().database();
    sqlDb.insert(
      table,
      data,
    );
  }

  Future<void> update(String table, int id, int use) async {
    final sqlDb = await DbAnalytics().database();
    sqlDb.rawUpdate('''UPDATE $table
        SET ${AppString.use} =?
        WHERE ${AppString.id} =?

      ''', [use, id]);
  }
}
