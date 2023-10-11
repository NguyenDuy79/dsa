import 'dart:async';
import 'package:fitness_app_bloc/respository/repository.dart';
import '../config/app_string.dart';
import '../db/database_helper.dart';

class DbInformationRespository {
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

  Future<int> delete(int id, String table) async {
    final sqlDb = await DbHelper().database();
    return sqlDb.delete(table, where: '${AppString.id} = ?', whereArgs: [id]);
  }

  void close() {
    _controller.close();
  }
}
