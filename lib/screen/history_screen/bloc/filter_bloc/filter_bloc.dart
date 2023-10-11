import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness_app_bloc/config/config.dart';

part 'filter_event.dart';
part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  String filter = 'All item';
  FilterBloc() : super(const FilterInitial([], 'All time')) {
    on<OnChangeFilter>(_filter);
  }

  void _filter(OnChangeFilter event, Emitter<FilterState> emit) {
    List<Map<String, Object?>> newList = [];
    if (event.value == 'All item') {
      filter = 'All time';
      emit(const FilterInitial([], 'All time'));
    } else {
      filter = event.value;
      for (int i = 0; i < event.listHistory.length; i++) {
        if (event.listHistory[i][AppString.methodExercise] == event.value) {
          newList.add(event.listHistory[i]);
        }
      }
      emit(FilterDone(newList, event.value));
    }
  }
}
