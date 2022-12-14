part of 'connection_bloc.dart';

abstract class ConnectionEvent extends Equatable {
  const ConnectionEvent();
}

class LinkDeviceEvent extends ConnectionEvent {
  final String patientId;
  final Device device;
  const LinkDeviceEvent(this.patientId, this.device);
  @override
  List<Object?> get props => [patientId, device];
}

class UnlinkDeviceEvent extends ConnectionEvent {
  final String patientId;
  final Device device;
  const UnlinkDeviceEvent(this.patientId, this.device);
  @override
  List<Object?> get props => [patientId, device];
}

class LoadLinkedDevicesEvent extends ConnectionEvent {
  final String idUser;
  const LoadLinkedDevicesEvent(this.idUser);
  @override
  List<Object?> get props => [idUser];
}

class ConnectDeviceEvent extends ConnectionEvent {
  final LinkedDevicesLoadedState previousListState;
  final String nameDeviceToConnect;
  const ConnectDeviceEvent(this.previousListState, this.nameDeviceToConnect);
  @override
  List<Object?> get props => [previousListState, nameDeviceToConnect];
}
