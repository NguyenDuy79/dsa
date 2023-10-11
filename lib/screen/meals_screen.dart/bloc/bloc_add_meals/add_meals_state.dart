part of 'add_meals_bloc.dart';

class AddMealsState extends Equatable {
  const AddMealsState(
      {this.food = '',
      this.weight = '',
      this.protein = 0,
      this.carbs = 0,
      this.calories = 0,
      this.status = FormzSubmissionStatus.initial,
      this.statusSubmit = FormzSubmissionStatus.initial,
      this.visibility = false,
      this.fats = 0});
  final String food;
  final String weight;
  final double protein;
  final double fats;
  final double carbs;
  final double calories;
  final FormzSubmissionStatus statusSubmit;
  final FormzSubmissionStatus status;
  final bool visibility;
  AddMealsState copyWith(
      {String? food,
      String? weight,
      double? protein,
      double? fats,
      double? calories,
      FormzSubmissionStatus? status,
      FormzSubmissionStatus? statusSubmit,
      bool? visibility,
      double? carbs}) {
    return AddMealsState(
        food: food ?? this.food,
        weight: weight ?? this.weight,
        protein: protein ?? this.protein,
        fats: fats ?? this.fats,
        calories: calories ?? this.calories,
        status: status ?? this.status,
        visibility: visibility ?? this.visibility,
        statusSubmit: statusSubmit ?? this.statusSubmit,
        carbs: carbs ?? this.carbs);
  }

  @override
  List<Object> get props =>
      [food, weight, protein, fats, carbs, status, visibility, statusSubmit];
}

final class AddMealsInitial extends AddMealsState {}
