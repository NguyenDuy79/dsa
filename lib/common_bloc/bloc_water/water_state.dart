part of 'water_bloc.dart';

abstract class WaterState extends Equatable {
  const WaterState();

  @override
  List<Object> get props => [];
}

class WaterInitial extends WaterState {}

class AddState extends WaterState {
  final int value;
  const AddState(this.value);
  @override
  List<Object> get props => [value];
}

class RemoveState extends WaterState {
  final int value;
  const RemoveState(this.value);
  @override
  List<Object> get props => [value];
}

class AddValue extends WaterState {
  final int value;
  const AddValue(this.value);
  @override
  List<Object> get props => [value];
}
