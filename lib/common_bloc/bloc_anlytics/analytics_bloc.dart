import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness_app_bloc/config/config.dart';
import 'package:fitness_app_bloc/db/database_analytics.dart';
import 'package:fitness_app_bloc/respository/db_analytics_repository.dart';
import 'package:fitness_app_bloc/respository/repository.dart';
part 'analytics_event.dart';
part 'analytics_state.dart';

class AnalyticsBloc extends Bloc<AnalyticsEvent, AnalyticsState> {
  final DbAnalyticsRepository _dbAnalyticsRepository;
  StreamSubscription? _fetchAnalyticsRespone;
  AnalyticsBloc({required DbAnalyticsRepository dbAnalyticsRepository})
      : _dbAnalyticsRepository = dbAnalyticsRepository,
        super(const AnalyticsInitial([], {})) {
    _fetchAnalyticsRespone?.cancel();
    _fetchAnalyticsRespone = _dbAnalyticsRepository.status.listen(
      (event) {
        if (event == Reload.yes) {
          add(_LoadAnalytics());
        }
      },
    );
    on<UpdateData>((event, emit) {
      _dbAnalyticsRepository.changeData();
    });
    on<_LoadAnalytics>(
      (event, emit) async {
        emit(const AnalyticsInitial([], {}));

        var list = await DbAnalytics().getData(AppString.workoutSchedule);
        Map<String, Object?> scheduleCurrent = {};
        if (list.isNotEmpty) {
          for (int i = 0; i < list.length; i++) {
            if (list[i][AppString.use] == 0) {
              scheduleCurrent = list[i];
            }
          }
        }
        _dbAnalyticsRepository.onDone();
        emit(AnalyticsLoaded(
          list,
          scheduleCurrent,
        ));
      },
    );

    on<UpdateUse>(_updateUse);
  }

  _updateUse(UpdateUse event, Emitter<AnalyticsState> emit) async {
    if (event.value == 1) {
      await DbAnalytics()
          .update(AppString.workoutSchedule, event.id, event.value);
    } else {
      var list = await DbAnalytics().getData(AppString.workoutSchedule);
      Map<String, Object?> scheduleCurrent = {};
      if (list.isNotEmpty) {
        for (int i = 0; i < list.length; i++) {
          if (list[i][AppString.use] == 0) {
            scheduleCurrent = list[i];
          }
        }
      }
      if (scheduleCurrent.isNotEmpty) {
        await DbAnalytics().update(
            AppString.workoutSchedule, scheduleCurrent[AppString.id] as int, 1);
      }

      await DbAnalytics()
          .update(AppString.workoutSchedule, event.id, event.value);
    }

    _dbAnalyticsRepository.changeData();
  }

  @override
  Future<void> close() {
    _fetchAnalyticsRespone?.cancel();
    _dbAnalyticsRepository.close();
    return super.close();
  }
}
