part of 'water_bloc.dart';

abstract class WaterEvent extends Equatable {
  const WaterEvent();

  @override
  List<Object> get props => [];
}

class AddEvent extends WaterEvent {}

class RemoveEvent extends WaterEvent {}

class AddWaterEvent extends WaterEvent {
  final String hour;
  const AddWaterEvent(this.hour);
}
