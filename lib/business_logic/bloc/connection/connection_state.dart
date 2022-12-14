part of 'connection_bloc.dart';

abstract class ConnectionOwnState extends Equatable {
  const ConnectionOwnState();
}

class ConnectionInitial extends ConnectionOwnState {
  @override
  List<Object?> get props => [];
}

class LoadingLinkedDevicesState extends ConnectionOwnState {
  @override
  List<Object?> get props => [];
}

class LinkedDevicesLoadedState extends ConnectionOwnState {
  final List<Device> linkedDevices;
  const LinkedDevicesLoadedState(this.linkedDevices);
  @override
  List<Object?> get props => [linkedDevices];
}

class NoDevicesFoundState extends ConnectionOwnState {
  @override
  List<Object?> get props => [];
}
