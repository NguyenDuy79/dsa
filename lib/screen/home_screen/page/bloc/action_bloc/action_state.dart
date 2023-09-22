part of 'action_bloc.dart';

class ActionState extends Equatable {
  const ActionState(
      {this.method = '',
      this.muscleGroup = '',
      this.exercise = '',
      this.restTime = '',
      this.temporaryDropset = '',
      this.temporarySuperset = '',
      this.set = ''});
  final String method;
  final String muscleGroup;
  final String exercise;
  final String set;
  final String restTime;
  final String temporarySuperset;
  final String temporaryDropset;
  //  List<int> get validSet {
  //   List<int> value = [];
  //   for (int i = 0; i <= set.split(',').length - 1; i++) {
  //     if (set.split(',')[i] == '') {
  //       value.add(i);
  //     }
  //   }
  //   return value;
  // }

  ActionState copyWith(
      {String? method,
      String? muscleGroup,
      String? exercise,
      String? restTime,
      String? temporarySuperset,
      String? temporaryDropset,
      String? set}) {
    return ActionState(
        method: method ?? this.method,
        exercise: exercise ?? this.exercise,
        muscleGroup: muscleGroup ?? this.muscleGroup,
        restTime: restTime ?? this.restTime,
        temporaryDropset: temporaryDropset ?? this.temporaryDropset,
        temporarySuperset: temporarySuperset ?? this.temporarySuperset,
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
        temporarySuperset
      ];
}

class ActionInitial extends ActionState {}
