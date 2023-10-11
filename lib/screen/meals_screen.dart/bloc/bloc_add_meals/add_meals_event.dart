part of 'add_meals_bloc.dart';

sealed class AddMealsEvent extends Equatable {
  const AddMealsEvent();

  @override
  List<Object> get props => [];
}

class AddFood extends AddMealsEvent {}

class SetFood extends AddMealsEvent {
  final String value;
  const SetFood(this.value);
}

class OnChangeWeightMeals extends AddMealsEvent {
  final String value;
  const OnChangeWeightMeals(this.value);
}

class DeleteFoodEvent extends AddMealsEvent {
  final String name;
  const DeleteFoodEvent(this.name);
}

class AddFieldVisilibity extends AddMealsEvent {}

class SubmitDish extends AddMealsEvent {}

class SubmitMeals extends AddMealsEvent {}
