part of 'recipes_bloc.dart';

abstract class RecipesState extends Equatable {
  const RecipesState(this.dataRecipes);
  final Map<String, Object?> dataRecipes;

  @override
  List<Object> get props => [dataRecipes];
}

class RecipesInitial extends RecipesState {
  const RecipesInitial(super.dataRecipes);
}

class RecipesLoaded extends RecipesState {
  const RecipesLoaded(super.dataRecipes);
  @override
  List<Object> get props => [dataRecipes];
}
