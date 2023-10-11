part of 'index_common_bloc.dart';

class IndexCommonState extends Equatable {
  const IndexCommonState(this.index, this.validate);
  final int index;
  final bool validate;

  @override
  List<Object> get props => [index];
}

class IndexCommonInitial extends IndexCommonState {
  const IndexCommonInitial(super.index, super.validate);
}
