part of 'action_bloc.dart';

class ActionState extends Equatable {
  const ActionState(
      {this.method = '',
      this.muscleGroup = '',
      this.exercise = '',
      this.restTime = '',
      this.temporaryDropset = '',
      this.temporarySuperset = '',
      this.cardioMethod ='',
      this.hiitMethod ='',
      this.level ='',
      this.set = '', 
      this.countLevel =0,
      this.time ='',
      this.submit =false});
  final String method;
  final String muscleGroup;
  final String exercise;
  final String set;
  final String restTime;
  final String temporarySuperset;
  final String temporaryDropset;
  final String cardioMethod;
  final String hiitMethod;
  final String level;
  final bool submit;
  final int countLevel;
  final String time;
  

  ActionState copyWith(
      {String? method,
      String? muscleGroup,
      String? exercise,
      String? restTime,
      String? temporarySuperset,
      String? temporaryDropset,
      String? cardioMethod,
      String? hiitMethod,
      String? level,
      bool? submit,
      String? time,
      int? countLevel,
      String? set}) {
    return ActionState(
        method: method ?? this.method,
        exercise: exercise ?? this.exercise,
        countLevel: countLevel ?? this.countLevel,
        muscleGroup: muscleGroup ?? this.muscleGroup,
        cardioMethod: cardioMethod?? this.cardioMethod,
        restTime: restTime ?? this.restTime,
        temporaryDropset: temporaryDropset ?? this.temporaryDropset,
        temporarySuperset: temporarySuperset ?? this.temporarySuperset,
        hiitMethod: hiitMethod ?? this.hiitMethod,
        level: level ?? this.level,
        submit: submit ?? this.submit,
        time: time  ?? this.time,
        set: set ?? this.set);
  }

  @override
  List<Object> get props => [
        method,
        muscleGroup,
        exercise,
        restTime,
        set,
        temporaryDropset,
        cardioMethod,
        temporarySuperset,
        level,
        hiitMethod, submit,countLevel, time
      ];
}

class ActionInitial extends ActionState {}
