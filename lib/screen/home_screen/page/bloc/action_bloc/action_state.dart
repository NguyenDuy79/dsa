part of 'action_bloc.dart';

class ActionState extends Equatable {
  const ActionState(
      {this.method = '',
      this.muscleGroup = '',
      this.exercise = '',
      this.restTime = '',
      this.set = ''});
  final String method;
  final String muscleGroup;
  final String exercise;
  final String set;
  final String restTime;
  List<int> get validSet {
    List<int> value = [];
    for (int i = 0; i <= set.split(',').length - 1; i++) {
      if (set.split(',')[i] == '') {
        value.add(i);
      }
    }
    return value;
  }

  ActionState copyWith(
      {String? method,
      String? muscleGroup,
      String? exercise,
      String? restTime,
      String? set}) {
    return ActionState(
        method: method ?? this.method,
        exercise: exercise ?? this.exercise,
        muscleGroup: muscleGroup ?? this.muscleGroup,
        restTime: restTime ?? this.restTime,
        set: set ?? this.set);
  }

  @override
  List<Object> get props => [method, muscleGroup, exercise, restTime, set];
}

class ActionInitial extends ActionState {}
