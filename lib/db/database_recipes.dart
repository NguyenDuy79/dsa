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
      await db.execute('CREATE TABLE ${AppString.recipesPerdayTable}('
          '${AppString.dateTime} TEXT NOT NULL,'
          '${AppString.calories} TEXT NOT NULL,'
          '${AppString.protein} TEXT NOT NULL,'
          '${AppString.fats} TEXT NOT NULL,'
          '${AppString.carbs} TEXT NOT NULL)');
      await db.execute('CREATE TABLE ${AppString.waterTable}('
          '${AppString.dateTime} TEXT NOT NULL,'
          '${AppString.water} INTEGER NOT NULL,'
          'zero INTEGER NOT NULL,'
          'one INTEGER NOT NULL,'
          'two INTEGER NOT NULL,'
          'three INTEGER NOT NULL,'
          'four INTEGER NOT NULL,'
          'five INTEGER NOT NULL,'
          'six INTEGER NOT NULL,'
          'seven INTEGER NOT NULL,'
          'eight INTEGER NOT NULL,'
          'nine INTEGER NOT NULL,'
          'ten INTEGER NOT NULL,'
          'eleven INTEGER NOT NULL,'
          'twelve INTEGER NOT NULL,'
          'thirteen INTEGER NOT NULL,'
          'fourteen INTEGER NOT NULL,'
          'fifteen INTEGER NOT NULL,'
          'sixteen INTEGER NOT NULL,'
          'seventeen INTEGER NOT NULL,'
          'eighteen INTEGER NOT NULL,'
          'nineteen INTEGER NOT NULL,'
          'twenty INTEGER NOT NULL,'
          'twenty_one INTEGER NOT NULL,'
          'twenty_two INTEGER NOT NULL,'
          'twenty_three INTEGER NOT NULL)');
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
