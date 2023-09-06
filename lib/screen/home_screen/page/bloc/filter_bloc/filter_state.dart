part of 'filter_bloc.dart';

abstract class FilterState extends Equatable {
  const FilterState(this.result, this.name);
  final List<Map<String, Object?>> result;
  final String name;
  //final String name;
  @override
  List<Object> get props => [
        result,
      ];
}

class FilterInitial extends FilterState {
  const FilterInitial(super.result, super.name);
}

class FilterDone extends FilterState {
  const FilterDone(super.result, super.name);
  @override
  List<Object> get props => [result, name];
}
