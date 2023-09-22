part of 'analytics_bloc.dart';

class AnalyticsState extends Equatable {
  const AnalyticsState(
    this.data,
    this.currentData,
    //this.status
  );
  final List<Map<String, Object?>> data;
  final Map<String, Object?> currentData;

//  final FormzSubmissionStatus status;

  @override
  List<Object> get props => [data, currentData];
}

final class AnalyticsInitial extends AnalyticsState {
  const AnalyticsInitial(
    super.data,
    super.currentData,
    //  super.status
  );
}

final class AnalyticsLoaded extends AnalyticsState {
  const AnalyticsLoaded(
    super.data,
    super.currentData,
    //  super.status
  );
  @override
  List<Object> get props => [
        data,
        currentData,
      ];
}
