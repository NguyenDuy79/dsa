import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness_app_bloc/config/app_string.dart';
import 'package:fitness_app_bloc/respository/repository.dart';

import '../../db/database_helper.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc({required DbHistoryRepository dbHistoryRepository})
      : _dbHistoryRepository = dbHistoryRepository,
        super(const HistoryLoading([], [])) {
    _fetchHistoryResponse?.cancel();
    _fetchHistoryResponse = _dbHistoryRepository.status.listen((event) {
      if (event == Reload.yes) {
        add(const _LoadHistory());
      }
    });
    on<_LoadHistory>(_mapLoadActivityToState);
    on<UpdateHistoryTable>(_updateHistoryTable);

    on<InsertHistory>(_insertTable);
    on<UpdateDateTime>(_updateDateTime);
    on<UpdateData>(_updateData);
  }
  StreamSubscription? _fetchHistoryResponse;
  final DbHistoryRepository _dbHistoryRepository;

  _mapLoadActivityToState(
      _LoadHistory event, Emitter<HistoryState> emit) async {
    var listHistory = await DbHelper().getData(AppString.historyTable);
    var listRepAndTime = await DbHelper().getData(AppString.repTimeTable);
    _dbHistoryRepository.onDone();
    emit(HistoryLoaded(listHistory, listRepAndTime));
  }

  _updateHistoryTable(UpdateHistoryTable event, Emitter<HistoryState> emit) {
    _dbHistoryRepository.update(AppString.historyTable, event.exercise,
        event.restTime, event.dateTimeEnd, event.id);
    _dbHistoryRepository.changeData();
  }

  _updateDateTime(UpdateDateTime event, Emitter<HistoryState> emit) async {
    await _dbHistoryRepository.updateDateTime(event.dateTime, event.id);
    _dbHistoryRepository.changeData();
  }

  _insertTable(InsertHistory event, Emitter<HistoryState> emit) {
    DbHelper().insert(event.tableName, event.data);
    _dbHistoryRepository.changeData();
  }

  _updateData(UpdateData event, Emitter<HistoryState> emit) {
    _dbHistoryRepository.changeData();
  }

  @override
  Future<void> close() {
    _fetchHistoryResponse?.cancel();
    _dbHistoryRepository.close();
    return super.close();
  }
}
