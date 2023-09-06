import 'dart:async';

import 'package:fitness_app_bloc/config/app_string.dart';
import 'package:fitness_app_bloc/respository/repository.dart';

import '../db/database_helper.dart';

class DbHistoryRepository {
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
    String table,
    String exercise,
    String restTime,
    String dateTimeEnd,
    int id,
  ) async {
    final sqlDb = await DbHelper().database();
    await sqlDb.rawUpdate('''UPDATE $table
        SET ${AppString.exercise} =?, ${AppString.restTime} = ?, DateTimeEnd =?
        WHERE ${AppString.id} =?

      ''', [exercise, restTime, dateTimeEnd, id]);
  }

  Future<void> updateDateTime(
    String dateTimeEnd,
    int id,
  ) async {
    final sqlDb = await DbHelper().database();
    await sqlDb.rawUpdate('''UPDATE ${AppString.historyTable}
        SET  DateTimeEnd =?
        WHERE ${AppString.id} =?

      ''', [dateTimeEnd, id]);
  }

  Future<void> updateSetAndTime(
    String rep,
    String weight,
    int id,
  ) async {
    final sqlDb = await DbHelper().database();
    await sqlDb.rawUpdate('''UPDATE ${AppString.recipesTable}
        SET ${AppString.rep} =?, ${AppString.weight} =?
        WHERE ${AppString.id} =?
    
      ''', [rep, weight, id]);
  }

  void close() {
    _controller.close();
  }
}
