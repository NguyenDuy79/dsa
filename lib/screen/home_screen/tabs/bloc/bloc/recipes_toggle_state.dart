part of 'recipes_toggle_bloc.dart';

abstract class RecipesToggleState extends Equatable {
  const RecipesToggleState();

  @override
  List<Object> get props => [];
}

class WaterInitial extends RecipesToggleState {}

class ToggleCaloriesState extends RecipesToggleState {
  const ToggleCaloriesState();
}

class ToggleWaterState extends RecipesToggleState {
  const ToggleWaterState();
}

class AddState extends RecipesToggleState {
  final int value;
  const AddState(this.value);
  @override
  List<Object> get props => [value];
}

class RemoveState extends RecipesToggleState {
  final int value;
  const RemoveState(this.value);
  @override
  List<Object> get props => [value];
}

class AddValue extends RecipesToggleState {
  final int value;
  const AddValue(this.value);
  @override
  List<Object> get props => [value];
}
