part of 'activity_bloc.dart';

class ActivityEvent extends Equatable {
  const ActivityEvent();

  @override
  List<Object> get props => [];
}

class _LoadActivity extends ActivityEvent {
  const _LoadActivity();
}

class UpdateActivity extends ActivityEvent {
  final String tableName;
  final Map<String, Object> data;
  const UpdateActivity(this.tableName, this.data);
}

class LoadingActivity extends ActivityEvent {}

class UpdateDataInfo extends ActivityEvent {}
