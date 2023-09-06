import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness_app_bloc/config/app_string.dart';
import 'package:fitness_app_bloc/db/database.dart';

import 'package:fitness_app_bloc/respository/repository.dart';

part 'activity_event.dart';
part 'activity_state.dart';

class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  StreamSubscription? _fetchHomeResponse;
  final DbInformationRespository _dbInformationRespository;

  ActivityBloc({required DbInformationRespository dbRespository})
      : _dbInformationRespository = dbRespository,
        super(const ActivityLoading([])) {
    _fetchHomeResponse?.cancel();
    _fetchHomeResponse = _dbInformationRespository.status.listen(
      (event) {
        if (event == Reload.yes) {
          add(const _LoadActivity());
        }
      },
    );
    on<_LoadActivity>(_mapLoadActivityToState);
    on<UpdateActivity>(_updataActivity);
    on<UpdateDataInfo>(_updateData);
  }

  void _mapLoadActivityToState(
      _LoadActivity event, Emitter<ActivityState> emit) async {
    var list = await DbHelper().getData(AppString.informationTable);
    _dbInformationRespository.onDone();
    emit(ActivityLoaded(list));
  }

  void _updataActivity(UpdateActivity event, Emitter<ActivityState> emit) {
    DbHelper().insert(event.tableName, event.data);
    _dbInformationRespository.changeData();
    emit(const ActivityLoading([]));
  }

  void _updateData(UpdateDataInfo event, Emitter<ActivityState> emit) {
    _dbInformationRespository.changeData();
    emit(const ActivityLoading([]));
  }

  @override
  Future<void> close() {
    _fetchHomeResponse?.cancel();
    _dbInformationRespository.close();
    return super.close();
  }
}
