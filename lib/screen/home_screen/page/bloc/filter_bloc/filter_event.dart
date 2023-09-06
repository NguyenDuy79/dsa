part of 'filter_bloc.dart';

abstract class FilterEvent extends Equatable {
  const FilterEvent();

  @override
  List<Object> get props => [];
}

class OnChangeFilter extends FilterEvent {
  final String value;
  final List<Map<String, Object?>> listHistory;
  const OnChangeFilter(this.value, this.listHistory);
}
