part of 'home_index_bloc.dart';

abstract class HomeIndexEvent extends Equatable {
  const HomeIndexEvent();

  @override
  List<Object> get props => [];
}

class TabIndex extends HomeIndexEvent {
  final int index;
  const TabIndex(this.index);
}
