import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness_app_bloc/config/app_string.dart';
import 'package:fitness_app_bloc/data/local/prefs.dart';

part 'recipes_toggle_event.dart';
part 'recipes_toggle_state.dart';

class RecipesToggleBloc extends Bloc<RecipesToggleEvent, RecipesToggleState> {
  bool toggle = true;
  int value = 100;
  RecipesToggleBloc() : super(WaterInitial()) {
    on<ToggleEvent>(_toggle);
    on<AddEvent>(_addValue);
    on<RemoveEvent>(_removeValue);
    on<AddWaterEvent>(_addWater);
  }
  _toggle(ToggleEvent event, Emitter<RecipesToggleState> emit) {
    toggle = event.status;
    if (event.status) {
      emit(const ToggleCaloriesState());
    } else {
      emit(const ToggleWaterState());
    }
  }

  _addValue(AddEvent event, Emitter<RecipesToggleState> emit) {
    if (value < 1000) {
      value += 100;
      emit(AddState(value));
    }
  }

  _removeValue(RemoveEvent event, Emitter<RecipesToggleState> emit) {
    if (value > 100) {
      value -= 100;
      emit(RemoveState(value));
    }
  }

  _addWater(AddWaterEvent event, Emitter<RecipesToggleState> emit) async {
    await LocalPref.setInt(
        AppString.water, LocalPref.getInt(AppString.water)! + value);
    await LocalPref.setInt(event.hour, LocalPref.getInt(event.hour)! + value);
    emit(AddValue(LocalPref.getInt(AppString.water)!));
  }
}
