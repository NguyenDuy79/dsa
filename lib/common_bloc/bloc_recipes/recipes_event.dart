part of 'recipes_bloc.dart';

abstract class RecipesEvent extends Equatable {
  const RecipesEvent();

  @override
  List<Object> get props => [];
}

class UpdateData extends RecipesEvent {}

class _LoadRecipes extends RecipesEvent {
  const _LoadRecipes();
}
