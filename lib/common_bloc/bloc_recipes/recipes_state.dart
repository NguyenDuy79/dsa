part of 'recipes_bloc.dart';

abstract class RecipesState extends Equatable {
  const RecipesState(
      this.dataRecipes, this.dataMeals, this.dataRecipesPerday, this.dataWater);
  final Map<String, Object?> dataRecipes;
  final List<Map<String, Object?>> dataMeals;
  final List<Map<String, Object?>> dataRecipesPerday;
  final List<Map<String, Object?>> dataWater;
  @override
  List<Object> get props =>
      [dataRecipes, dataMeals, dataRecipesPerday, dataWater];
}

class RecipesInitial extends RecipesState {
  const RecipesInitial(super.dataRecipes, super.dataMeals,
      super.dataRecipesPerday, super.dataWater);
  @override
  List<Object> get props =>
      [dataRecipes, dataMeals, dataRecipesPerday, dataWater];
}

class RecipesLoaded extends RecipesState {
  const RecipesLoaded(super.dataRecipes, super.dataMeals,
      super.dataRecipesPerday, super.dataWater);
  @override
  List<Object> get props =>
      [dataRecipes, dataMeals, dataRecipesPerday, dataWater];
}
