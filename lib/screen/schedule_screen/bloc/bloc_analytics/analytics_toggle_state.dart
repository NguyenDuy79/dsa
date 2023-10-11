part of 'analytics_toggle_bloc.dart';

class AnalyticsToggleState extends Equatable {
  const AnalyticsToggleState(
      {this.mon = '',
      this.tue = '',
      this.wed = '',
      this.thu = '',
      this.fri = '',
      this.sat = '',
      this.sun = '',
      this.index = 0,
      this.muscleGroup = '',
      this.countMethod = '',
      this.status = FormzSubmissionStatus.initial,
      this.count = AppString.mon,
      this.allDay =
          '${AppString.mon},${AppString.tue},${AppString.wed},${AppString.thu},${AppString.fri},${AppString.sat},${AppString.sun},',
      this.caridoMethod = '',
      this.hiitMethod = '',
      this.level = '',
      this.chooseExerciseCardio = false,
      this.countLevel = 0});
  final String mon;
  final String tue;
  final String wed;
  final String thu;
  final String fri;
  final String sat;
  final String sun;
  final int index;
  final String countMethod;
  final bool chooseExerciseCardio;
  final String allDay;
  final String muscleGroup;
  final String count;
  final FormzSubmissionStatus status;
  final String caridoMethod;
  final String hiitMethod;
  final String level;
  final int countLevel;
  AnalyticsToggleState copyWith(
      {String? mon,
      String? tue,
      String? wed,
      String? thu,
      String? fri,
      String? sat,
      String? sun,
      String? muscleGroup,
      String? allDay,
      String? countMethod,
      String? count,
      String? caridoMethod,
      String? hiitMethod,
      String? level,
      bool? chooseExerciseCardio,
      FormzSubmissionStatus? status,
      int? countLevel,
      int? index}) {
    return AnalyticsToggleState(
        mon: mon ?? this.mon,
        tue: tue ?? this.tue,
        wed: wed ?? this.wed,
        thu: thu ?? this.thu,
        fri: fri ?? this.fri,
        sat: sat ?? this.sat,
        sun: sun ?? this.sun,
        countMethod: countMethod ?? this.countMethod,
        status: status ?? this.status,
        muscleGroup: muscleGroup ?? this.muscleGroup,
        index: index ?? this.index,
        count: count ?? this.count,
        allDay: allDay ?? this.allDay,
        caridoMethod: caridoMethod ?? this.caridoMethod,
        hiitMethod: hiitMethod ?? this.hiitMethod,
        level: level ?? this.level,
        chooseExerciseCardio: chooseExerciseCardio ?? this.chooseExerciseCardio,
        countLevel: countLevel ?? this.countLevel);
  }

  @override
  List<Object> get props => [
        mon,
        tue,
        fri,
        wed,
        thu,
        sat,
        sun,
        index,
        allDay,
        count,
        muscleGroup,
        status,
        countMethod,
        caridoMethod,
        hiitMethod,
        level,
        chooseExerciseCardio,
        countLevel
      ];
}

final class AnalyticsToggleInitial extends AnalyticsToggleState {}
