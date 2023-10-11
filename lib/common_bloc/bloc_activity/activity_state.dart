part of 'activity_bloc.dart';

class ActivityState extends Equatable {
  const ActivityState(this.activityResponse);
  final List<Map<String, Object?>> activityResponse;

  @override
  List<Object> get props => [activityResponse];
}

class ActivityLoading extends ActivityState {
  const ActivityLoading(super.activityResponse);
}

class ActivityLoaded extends ActivityState {
  const ActivityLoaded(super.activityResponse);

  @override
  List<Object> get props => [activityResponse];
}

class ActivityLoadFailure extends ActivityState {
  final String error;
  const ActivityLoadFailure(this.error, super.activityResponse);
}
