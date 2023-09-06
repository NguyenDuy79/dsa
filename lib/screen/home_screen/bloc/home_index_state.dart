part of 'home_index_bloc.dart';

class HomeIndexState extends Equatable {
  const HomeIndexState(this.index);
  final int index;

  @override
  List<Object> get props => [index];
}
