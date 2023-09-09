import 'dart:async';

import 'repository.dart';

class DbMealsRepository {
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

  void close() {
    _controller.close();
  }
}
