import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_index_event.dart';
part 'home_index_state.dart';

class HomeIndexBloc extends Bloc<HomeIndexEvent, HomeIndexState> {
  HomeIndexBloc() : super(const HomeIndexState(0)) {
    on<TabIndex>(_addIndex);
  }
  void _addIndex(TabIndex event, Emitter<HomeIndexState> emit) {
    emit(HomeIndexState(event.index));
  }
}
