part of 'recipes_bloc.dart';

abstract class RecipesState extends Equatable {
  const RecipesState(this.dataRecipes, this.dataMeals, this.dataRecipesPerday,
      this.dataWater, this.status);
  final Map<String, Object?> dataRecipes;
  final List<Map<String, Object?>> dataMeals;
  final List<Map<String, Object?>> dataRecipesPerday;
  final List<Map<String, Object?>> dataWater;
  final FormzSubmissionStatus status;

  @override
  List<Object> get props =>
      [dataRecipes, dataMeals, dataRecipesPerday, dataWater, status];
}

class RecipesInitial extends RecipesState {
  const RecipesInitial(super.dataRecipes, super.dataMeals,
      super.dataRecipesPerday, super.dataWater, super.status);
  @override
  List<Object> get props =>
      [dataRecipes, dataMeals, dataRecipesPerday, dataWater, status];
}

class RecipesLoaded extends RecipesState {
  const RecipesLoaded(super.dataRecipes, super.dataMeals,
      super.dataRecipesPerday, super.dataWater, super.status);
  @override
  List<Object> get props =>
      [dataRecipes, dataMeals, dataRecipesPerday, dataWater, status];
}
