import 'dart:async';

import 'package:fitness_app_bloc/db/database_recipes.dart';
import 'package:fitness_app_bloc/respository/repository.dart';

import '../config/app_string.dart';

class DbRecipesRepository {
  void changeData() {
    _controller.add(Reload.yes);
  }

  final StreamController<Reload> _controller = StreamController<Reload>();
  Stream<Reload> get status async* {
    yield Reload.yes;
    yield* _controller.stream;
  }

  void onDone() {
    _controller.add(Reload.no);
  }

  Future<void> update(
      int id, String protetin, String fats, String carbs) async {
    final sqlDb = await DbRecipes().database();
    await sqlDb.rawUpdate('''UPDATE ${AppString.recipesTable}
        SET  ${AppString.protein} =?, ${AppString.fats} =?, ${AppString.carbs} =?
        WHERE ${AppString.id} =?

      ''', [protetin, fats, carbs, id]);
  }

  Future<int> delete(int id, String table) async {
    final sqlDb = await DbRecipes().database();
    return sqlDb.delete(table, where: '${AppString.id} = ?', whereArgs: [id]);
  }

  void close() {
    _controller.close();
  }
}
