part of 'analytics_bloc.dart';

sealed class AnalyticsEvent extends Equatable {
  const AnalyticsEvent();

  @override
  List<Object> get props => [];
}

class UpdateData extends AnalyticsEvent {}

class _LoadAnalytics extends AnalyticsEvent {}

class UpdateUse extends AnalyticsEvent {
  final int id;
  final int value;
  const UpdateUse(this.id, this.value);
}
