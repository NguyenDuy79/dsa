part of 'history_bloc.dart';

class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object> get props => [];
}

class _LoadHistory extends HistoryEvent {
  const _LoadHistory();
}

class UpdateHistoryTable extends HistoryEvent {
  final String exercise;
  final String restTime;
  final String dateTimeEnd;
  final int id;
  const UpdateHistoryTable(
      this.exercise, this.restTime, this.dateTimeEnd, this.id);
}

class UpdateRepTimeTable extends HistoryEvent {
  final String rep;
  final int id;
  const UpdateRepTimeTable(this.rep, this.id);
}

class UpdateDateTime extends HistoryEvent {
  final String dateTime;
  final int id;
  const UpdateDateTime(this.dateTime, this.id);
}

class UpdateData extends HistoryEvent {}

class InsertHistory extends HistoryEvent {
  final String tableName;
  final Map<String, Object> data;
  const InsertHistory(this.tableName, this.data);
}
