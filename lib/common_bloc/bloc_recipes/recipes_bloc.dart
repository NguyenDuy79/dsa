import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness_app_bloc/config/app_string.dart';
import 'package:fitness_app_bloc/db/database.dart';
import 'package:fitness_app_bloc/respository/repository.dart';

part 'recipes_event.dart';
part 'recipes_state.dart';

class RecipesBloc extends Bloc<RecipesEvent, RecipesState> {
  RecipesBloc({required DbRecipesRepository recipesRepository})
      : _dbRecipesRepository = recipesRepository,
        super(const RecipesInitial({})) {
    _fetchHistoryResponse = _dbRecipesRepository.status.listen((event) {
      if (event == Reload.yes) {
        add(const _LoadRecipes());
      }
    });
    on<_LoadRecipes>(_mapLoadActivityToState);
    on<UpdateData>(_dataUpdate);
  }
  StreamSubscription? _fetchHistoryResponse;
  final DbRecipesRepository _dbRecipesRepository;

  _mapLoadActivityToState(
      _LoadRecipes event, Emitter<RecipesState> emit) async {
    var newList = await DbHelper().getData(AppString.recipesTable);
    _dbRecipesRepository.onDone();
    emit(RecipesLoaded(newList.last));
  }

  _dataUpdate(UpdateData event, Emitter<RecipesState> emit) {
    _dbRecipesRepository.changeData();
  }

  @override
  Future<void> close() {
    _fetchHistoryResponse?.cancel();
    _dbRecipesRepository.close();
    return super.close();
  }
}