// ignore_for_file: prefer_const_constructors_in_immutables

part of 'device_bloc.dart';

abstract class DeviceState extends Equatable {
  const DeviceState();
}

class DeviceIdleState extends DeviceState {
  @override
  List<Object?> get props => [];
}

class DeviceSelectedState extends DeviceState {
  final String nameDevice;

  var observation;

  DeviceSelectedState(this.nameDevice);
  @override
  List<Object?> get props => [nameDevice];
}

class DeviceMeasureDoneState extends DeviceState {
  final Observation observation;
  final String nameDevice;

  DeviceMeasureDoneState(this.observation, this.nameDevice);
  @override
  List<Object?> get props => [observation, nameDevice];
}

class DeviceMeasuringState extends DeviceState {
  @override
  List<Object?> get props => [];
}

class DeviceConnectingState extends DeviceState {
  @override
  List<Object?> get props => [];
}
