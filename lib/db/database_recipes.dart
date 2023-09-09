import 'package:fitness_app_bloc/config/config.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbRecipes {
  Future<Database> database() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(join(dbPath, 'recipes.db'),
        onCreate: (db, version) async {
      await db.execute('CREATE TABLE ${AppString.recipesTable}('
          '${AppString.id}  INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'
          '${AppString.calories} TEXT NOT NULL,'
          '${AppString.protein} TEXT NOT NULL,'
          '${AppString.fats} TEXT NOT NULL,'
          '${AppString.carbs} TEXT NOT NULL)');
      await db.execute('CREATE TABLE ${'meals_table'}('
          '${AppString.hour} TEXT NOT NULL ,'
          '${AppString.day} TEXT NOT NULL,'
          '${AppString.foods} TEXT NOT NULL,'
          '${AppString.weight} TEXT NOT NULL,'
          '${AppString.calories} TEXT NOT NULL)');
      await db.execute('CREATE TABLE ${AppString.listMealsTable}('
          '${AppString.id}  INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'
          '${AppString.hour} TEXT NOT NULL ,'
          '${AppString.day} TEXT NOT NULL,'
          '${AppString.foods} TEXT NOT NULL,'
          '${AppString.weight} TEXT NOT NULL,'
          '${AppString.protein} TEXT NOT NULL,'
          '${AppString.fats} TEXT NOT NULL,'
          '${AppString.carbs} TEXT NOT NULL,'
          '${AppString.calories} TEXT NOT NULL)');
    }, version: 1);
  }

  Future<List<Map<String, Object?>>> getData(String table) async {
    final sqlDb = await DbRecipes().database();
    List<Map<String, Object?>> newList = await sqlDb.query(
      table,
    );
    return newList;
  }

  Future<void> insert(String table, Map<String, Object> data) async {
    final sqlDb = await DbRecipes().database();
    sqlDb.insert(
      table,
      data,
    );
  }
}
