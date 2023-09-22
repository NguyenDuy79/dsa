import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness_app_bloc/config/app_string.dart';
import 'package:fitness_app_bloc/data/local/prefs.dart';

part 'water_event.dart';
part 'water_state.dart';

class WaterBloc extends Bloc<WaterEvent, WaterState> {
  int value = 100;
  WaterBloc() : super(WaterInitial()) {
    on<AddEvent>(_addValue);
    on<RemoveEvent>(_removeValue);
    on<AddWaterEvent>(_addWater);
  }

  _addValue(AddEvent event, Emitter<WaterState> emit) {
    if (value < 1000) {
      value += 100;
      emit(AddState(value));
    }
  }

  _removeValue(RemoveEvent event, Emitter<WaterState> emit) {
    if (value > 100) {
      value -= 100;
      emit(RemoveState(value));
    }
  }

  _addWater(AddWaterEvent event, Emitter<WaterState> emit) async {
    await LocalPref.setInt(
        AppString.water, LocalPref.getInt(AppString.water)! + value);
    await LocalPref.setInt(event.hour, LocalPref.getInt(event.hour)! + value);
    emit(AddValue(LocalPref.getInt(AppString.water)!));
  }
}
