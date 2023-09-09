part of 'recipes_bloc.dart';

abstract class RecipesState extends Equatable {
  const RecipesState(this.dataRecipes, this.dataMeals);
  final Map<String, Object?> dataRecipes;
  final List<Map<String, Object?>> dataMeals;

  @override
  List<Object> get props => [dataRecipes, dataMeals];
}

class RecipesInitial extends RecipesState {
  const RecipesInitial(super.dataRecipes, super.dataMeals);
  @override
  List<Object> get props => [dataRecipes, dataMeals];
}

class RecipesLoaded extends RecipesState {
  const RecipesLoaded(super.dataRecipes, super.dataMeals);
  @override
  List<Object> get props => [dataRecipes, dataMeals];
}
