part of 'recipes_toggle_bloc.dart';

abstract class RecipesToggleEvent extends Equatable {
  const RecipesToggleEvent();

  @override
  List<Object> get props => [];
}

class ToggleEvent extends RecipesToggleEvent {
  final bool status;
  const ToggleEvent(this.status);
}

class AddEvent extends RecipesToggleEvent {}

class RemoveEvent extends RecipesToggleEvent {}

class AddWaterEvent extends RecipesToggleEvent {
  final String hour;
  const AddWaterEvent(this.hour);
}
