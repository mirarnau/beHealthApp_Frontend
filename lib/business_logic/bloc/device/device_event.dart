// ignore_for_file: prefer_const_constructors_in_immutables

part of 'device_bloc.dart';

abstract class DeviceEvent extends Equatable {
  const DeviceEvent();
}

class SelectDeviceEvent extends DeviceEvent {
  final String nameDevice;
  const SelectDeviceEvent(this.nameDevice);
  @override
  List<Object?> get props => [nameDevice];
}

class DeSelectDeviceEvent extends DeviceEvent {
  @override
  List<Object?> get props => [];
}

class DeviceMeasurementsRequestEvent extends DeviceEvent {
  @override
  List<Object?> get props => [];
}

class DeviceDoMeasureEvent extends DeviceEvent {
  final String idFhirUser;
  final num value;
  final num value2;
  final String nameDevice;
  final String observationType;

  DeviceDoMeasureEvent(this.idFhirUser, this.value, this.value2, this.nameDevice, this.observationType);
  @override
  List<Object?> get props => [idFhirUser, value, nameDevice, observationType];
}
