import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness_app_bloc/config/app_string.dart';
import 'package:fitness_app_bloc/data/local/prefs.dart';

import 'package:fitness_app_bloc/db/database_recipes.dart';
import 'package:fitness_app_bloc/respository/db_recipes_perday_repository.dart';
import 'package:fitness_app_bloc/respository/repository.dart';
import 'package:intl/intl.dart';

part 'recipes_event.dart';
part 'recipes_state.dart';

class RecipesBloc extends Bloc<RecipesEvent, RecipesState> {
  RecipesBloc(
      {required DbRecipesRepository recipesRepository,
      required DbRecipesPerdayRepository recipesPerdayRepository})
      : _dbRecipesRepository = recipesRepository,
        _dbRecipesPerdayRepository = recipesPerdayRepository,
        super(const RecipesInitial({}, [], [], [])) {
    _fetchHistoryResponse?.cancel();
    _fetchHistoryResponse = _dbRecipesRepository.status.listen((event) {
      if (event == Reload.yes) {
        add(const _LoadRecipes());
      }
    });
    _fetchRecipesPerdayResponse?.cancel();
    _fetchRecipesPerdayResponse = _dbRecipesPerdayRepository.status.listen(
      (event) {
        if (event == Reload.yes) {
          add(const _LoadPerday());
        }
      },
    );
    on<_LoadPerday>(_loadDataPerDay);
    on<_LoadRecipes>(_mapLoadActivityToState);
    on<UpdateData>(_dataUpdate);
    on<UpdatePerday>(_updatePerday);
  }
  StreamSubscription? _fetchHistoryResponse;
  final DbRecipesRepository _dbRecipesRepository;
  StreamSubscription? _fetchRecipesPerdayResponse;
  final DbRecipesPerdayRepository _dbRecipesPerdayRepository;

  _updatePerday(UpdatePerday event, Emitter<RecipesState> emit) async {
    List<Map<String, Object?>> data =
        await DbRecipes().getData(AppString.recipesTable);
    if (LocalPref.getString(AppString.dateTime) == null) {
      LocalPref.setString(AppString.dateTime, event.dateTime.toString());
      LocalPref.setDouble(AppString.calories, 0);
      LocalPref.setDouble(AppString.protein, 0);
      LocalPref.setDouble(AppString.fats, 0);
      LocalPref.setDouble(AppString.carbs, 0);
      LocalPref.setInt(AppString.water, 0);

      for (int i = 0; i < 24; i++) {
        LocalPref.setInt(i.toString(), 0);
      }
    } else if (DateFormat('dd-MM-yyyy')
            .format(DateTime.parse(LocalPref.getString(AppString.dateTime)!)) !=
        DateFormat('dd-MM-yyyy').format(event.dateTime)) {
          if(data.isNotEmpty){
await DbRecipes().insert(AppString.recipesPerdayTable, {
        AppString.dateTime: DateFormat('dd-MM-yyyy')
            .format(DateTime.parse(LocalPref.getString(AppString.dateTime)!)),
        AppString.calories:
            '${LocalPref.getDouble(AppString.calories)}/${data.last[AppString.calories]}',
        AppString.protein:
            '${LocalPref.getDouble(AppString.protein)}/${data.last[AppString.protein]}',
        AppString.carbs:
            '${LocalPref.getDouble(AppString.carbs)}/${data.last[AppString.carbs]}',
        AppString.fats:
            '${LocalPref.getDouble(AppString.fats)}/${data.last[AppString.fats]}',
      });
      await DbRecipes().insert(AppString.waterTable, {
        AppString.dateTime: DateFormat('dd-MM-yyyy')
            .format(DateTime.parse(LocalPref.getString(AppString.dateTime)!)),
        AppString.water: LocalPref.getInt(AppString.water)!,
        'zero': LocalPref.getInt('0')!,
        'one': LocalPref.getInt('1')!,
        'two': LocalPref.getInt('2')!,
        'three': LocalPref.getInt('3')!,
        'four': LocalPref.getInt('4')!,
        'five': LocalPref.getInt('5')!,
        'six': LocalPref.getInt('6')!,
        'seven': LocalPref.getInt('7')!,
        'eight': LocalPref.getInt('8')!,
        'nine': LocalPref.getInt('9')!,
        'ten': LocalPref.getInt('10')!,
        'eleven': LocalPref.getInt('11')!,
        'twelve': LocalPref.getInt('12')!,
        'thirteen': LocalPref.getInt('13')!,
        'fourteen': LocalPref.getInt('14')!,
        'fifteen': LocalPref.getInt('15')!,
        'sixteen': LocalPref.getInt('16')!,
        'seventeen': LocalPref.getInt('17')!,
        'eighteen': LocalPref.getInt('18')!,
        'nineteen': LocalPref.getInt('19')!,
        'twenty': LocalPref.getInt('20')!,
        'twenty_one': LocalPref.getInt('21')!,
        'twenty_two': LocalPref.getInt('22')!,
        'twenty_three': LocalPref.getInt('23')!
      });
          }
      

      LocalPref.setString(AppString.dateTime, event.dateTime.toString());
      LocalPref.setDouble(AppString.calories, 0);
      LocalPref.setDouble(AppString.protein, 0);
      LocalPref.setDouble(AppString.fats, 0);
      LocalPref.setDouble(AppString.carbs, 0);
      LocalPref.setInt(AppString.water, 0);
      for (int i = 0; i < 24; i++) {
        LocalPref.setInt(i.toString(), 0);
      }
    }

    _dbRecipesPerdayRepository.changeData();
  }

  _mapLoadActivityToState(
      _LoadRecipes event, Emitter<RecipesState> emit) async {
    var newList = await DbRecipes().getData(AppString.recipesTable);
    var newListMeals = await DbRecipes().getData(AppString.listMealsTable);

    _dbRecipesRepository.onDone();
    emit(RecipesLoaded(newList.isNotEmpty ? newList.last : {}, newListMeals,
        state.dataRecipesPerday, state.dataWater));
  }

  _loadDataPerDay(_LoadPerday event, Emitter<RecipesState> emit) async {
    var newList = await DbRecipes().getData(AppString.waterTable);
    var newListMeals = await DbRecipes().getData(AppString.recipesPerdayTable);
    _dbRecipesPerdayRepository.onDone();
    emit(RecipesLoaded(
        state.dataRecipes, state.dataMeals, newListMeals, newList));
  }

  _dataUpdate(UpdateData event, Emitter<RecipesState> emit) {
    _dbRecipesRepository.changeData();
  }

  @override
  Future<void> close() {
    _fetchHistoryResponse?.cancel();
    _dbRecipesRepository.close();
    _dbRecipesPerdayRepository.close();
    _fetchRecipesPerdayResponse?.cancel();
    return super.close();
  }
}
