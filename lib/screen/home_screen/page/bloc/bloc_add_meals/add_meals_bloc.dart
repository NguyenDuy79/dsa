import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness_app_bloc/data/local/prefs.dart';
import 'package:fitness_app_bloc/db/database_recipes.dart';

import 'package:formz/formz.dart';
import 'package:intl/intl.dart';

import '../../../../../config/config.dart';

part 'add_meals_event.dart';
part 'add_meals_state.dart';

class AddMealsBloc extends Bloc<AddMealsEvent, AddMealsState> {
  String food = '';
  String weight = '';
  bool isSubmit = false;
  String foodError = 'Please enter the food';
  String weightError = 'Please enter the weight';
  double currentCalories = 0;
  double currentProtein = 0;
  double currentFats = 0;
  double currentCarbs = 0;
  double calories = 0;
  double protein = 0;
  double fats = 0;
  double carbs = 0;
  bool isAddVibility = false;

  AddMealsBloc() : super(AddMealsInitial()) {
    on<SetFood>(_setFood);
    on<OnChangeWeightMeals>(_changeWeight);
    on<AddFieldVisilibity>(_visibilityAddField);
    on<SubmitDish>(_submit);
    on<SubmitMeals>(_submitMeals);
  }
  _visibilityAddField(AddFieldVisilibity event, Emitter<AddMealsState> emit) {
    isAddVibility = true;
    emit(state.copyWith(visibility: true));
  }

  _setFood(SetFood event, Emitter<AddMealsState> emit) {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    food = event.value;
    foodError = '';
    if (weight.isNotEmpty &&
        !(weight.contains(' ') ||
            weight.contains('-') ||
            weight.contains(',') ||
            weight.contains('.')) &&
        int.parse(weight) > 0) {
      var index = AppAnother.listFood
          .indexWhere((element) => (element[AppString.name] as String) == food);
      currentCalories = AppAnother.listFood[index][AppString.calories] *
          int.parse(weight) /
          100;
      currentProtein = AppAnother.listFood[index][AppString.protein] *
          int.parse(weight) /
          100;
      currentFats =
          AppAnother.listFood[index][AppString.fats] * int.parse(weight) / 100;
      currentCarbs =
          AppAnother.listFood[index][AppString.carbs] * int.parse(weight) / 100;
    }
    emit(state.copyWith(status: FormzSubmissionStatus.success));
  }

  _changeWeight(OnChangeWeightMeals event, Emitter<AddMealsState> emit) {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    weight = event.value;
    if (event.value.isEmpty) {
      weightError = 'Please enter weight';
    } else if (event.value.contains(',') ||
        event.value.contains(' ') ||
        event.value.contains('-') ||
        event.value.contains('.')) {
      weightError = 'Please enter a positive interger';
    } else {
      if (int.parse(event.value) < 1) {
        weightError = 'Please enter corect weight';
      } else {
        if (food.isNotEmpty) {
          var index = AppAnother.listFood.indexWhere(
              (element) => (element[AppString.name] as String) == food);
          currentCalories = AppAnother.listFood[index][AppString.calories] *
              int.parse(weight) /
              100;
          currentProtein = AppAnother.listFood[index][AppString.protein] *
              int.parse(weight) /
              100;
          currentFats = AppAnother.listFood[index][AppString.fats] *
              int.parse(weight) /
              100;
          currentCarbs = AppAnother.listFood[index][AppString.carbs] *
              int.parse(weight) /
              100;
        } else {
          calories = 0;
        }
        weightError = '';
      }
    }
    emit(state.copyWith(status: FormzSubmissionStatus.success));
  }

  _submit(SubmitDish event, Emitter<AddMealsState> emit) {
    isSubmit = true;
    if (weightError.isEmpty && foodError.isEmpty) {
      protein += currentProtein;
      calories += currentCalories;

      fats += currentFats;
      carbs += currentCarbs;
      isAddVibility = false;
      currentCalories = 0;
      currentCarbs = 0;
      currentFats = 0;
      currentProtein = 0;

      emit(
        state.copyWith(
            visibility: false,
            food: '${state.food}$food,',
            weight: '${state.weight}$weight,',
            calories: calories,
            protein: protein,
            carbs: carbs,
            fats: fats),
      );
    } else {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }

  Future<void> _submitMeals(
      SubmitMeals event, Emitter<AddMealsState> emit) async {
    emit(state.copyWith(statusSubmit: FormzSubmissionStatus.inProgress));
    if (state.food != '' && state.weight != '') {
      try {
        DateTime dateTime = DateTime.now();
        String hour = DateFormat('HH:mm:ss').format(dateTime);
        String day = DateFormat('dd-M-yyyy').format(dateTime);

        LocalPref.setDouble(AppString.calories,
            LocalPref.getDouble(AppString.calories)! + calories);
        LocalPref.setDouble(AppString.protein,
            LocalPref.getDouble(AppString.protein)! + protein);
        LocalPref.setDouble(
            AppString.carbs, LocalPref.getDouble(AppString.carbs)! + carbs);
        LocalPref.setDouble(
            AppString.fats, LocalPref.getDouble(AppString.fats)! + fats);

        await DbRecipes().insert(AppString.listMealsTable, {
          AppString.hour: hour,
          AppString.day: day,
          AppString.foods: state.food,
          AppString.weight: state.weight,
          AppString.calories: state.calories.toString(),
          AppString.protein: state.protein.toString(),
          AppString.fats: state.fats.toString(),
          AppString.carbs: state.carbs.toString()
        });

        emit(state.copyWith(statusSubmit: FormzSubmissionStatus.success));
      } catch (e) {
        emit(state.copyWith(statusSubmit: FormzSubmissionStatus.failure));
      }
    } else {
      emit(state.copyWith(statusSubmit: FormzSubmissionStatus.failure));
    }
  }
}
