part of 'history_bloc.dart';

class HistoryState extends Equatable {
  const HistoryState(this.dataHistory, this.dataRepAndTime);
  final List<Map<String, Object?>> dataHistory;
  final List<Map<String, Object?>> dataRepAndTime;

  @override
  List<Object> get props => [dataHistory, dataRepAndTime];
}

class HistoryLoading extends HistoryState {
  const HistoryLoading(super.dataHistory, super.dataRepAndTime);
}

class HistoryLoaded extends HistoryState {
  const HistoryLoaded(super.dataHistory, super.dataRepAndTime);
  @override
  List<Object> get props => [dataHistory, dataRepAndTime];
}
