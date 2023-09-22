part of 'recipes_bloc.dart';

abstract class RecipesEvent extends Equatable {
  const RecipesEvent();

  @override
  List<Object> get props => [];
}

class UpdateData extends RecipesEvent {}

class UpdatePerday extends RecipesEvent {
  final DateTime dateTime;

  const UpdatePerday(
    this.dateTime,
  );
}

class _LoadRecipes extends RecipesEvent {
  const _LoadRecipes();
}

class _LoadPerday extends RecipesEvent {
  const _LoadPerday();
}
