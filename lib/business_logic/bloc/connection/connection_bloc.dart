// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medical_devices/data/Models/Device.dart';
import 'package:medical_devices/data/Services/userService.dart';

part 'connection_event.dart';
part 'connection_state.dart';

class ConnectionBloc extends Bloc<ConnectionEvent, ConnectionOwnState> {
  final UserService _patientService;
  ConnectionBloc(this._patientService) : super(ConnectionInitial()) {
    on<LoadLinkedDevicesEvent>((event, emit) async {
      emit(LoadingLinkedDevicesState());
      final response = await _patientService.getAllDevicesPatient(event.idUser);
      if (response != null) {
        emit(LinkedDevicesLoadedState(response));
      } else {
        emit(LinkedDevicesLoadedState([]));
      }
    });
    on<LinkDeviceEvent>((event, emit) async {
      emit(LoadingLinkedDevicesState());
      final response = await _patientService.addDeviceToPatient(event.patientId, event.device);
      emit(LinkedDevicesLoadedState(response!));
    });
    on<UnlinkDeviceEvent>((event, emit) async {
      emit(LoadingLinkedDevicesState());
      final response = await _patientService.removeDeviceFromPatient(event.patientId, event.device);
      emit(LinkedDevicesLoadedState(response!));
    });
    on<ConnectDeviceEvent>((event, emit) async {
      emit(LoadingLinkedDevicesState());
      List<Device> updatedList = [];
      for (int i = 0; i < event.previousListState.linkedDevices.length; i++) {
        late Device device;
        if (event.previousListState.linkedDevices[i].nameDevice == event.nameDeviceToConnect) {
          device = Device(event.previousListState.linkedDevices[i].nameDevice, event.previousListState.linkedDevices[i].photoDevice, event.previousListState.linkedDevices[i].modelDevice, true, event.previousListState.linkedDevices[i].added, event.previousListState.linkedDevices[i].verified);
        } else {
          device = Device(event.previousListState.linkedDevices[i].nameDevice, event.previousListState.linkedDevices[i].photoDevice, event.previousListState.linkedDevices[i].modelDevice, event.previousListState.linkedDevices[i].connected, event.previousListState.linkedDevices[i].added, event.previousListState.linkedDevices[i].verified);
        }
        updatedList.add(device);
      }
      await Future.delayed(const Duration(seconds: 2));
      emit(LinkedDevicesLoadedState(updatedList));
    });
  }
}
