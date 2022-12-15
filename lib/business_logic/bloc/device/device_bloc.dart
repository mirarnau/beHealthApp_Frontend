// ignore_for_file: prefer_const_constructors

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medical_devices/business_logic/bloc/connection/connection_bloc.dart';
import 'package:medical_devices/data/Models/Observation.dart';
import 'package:medical_devices/data/Services/deviceService.dart';

part 'device_event.dart';
part 'device_state.dart';

class DeviceBloc extends Bloc<DeviceEvent, DeviceState> {
  final DeviceService _deviceService;
  DeviceBloc(this._deviceService) : super(DeviceIdleState()) {
    on<SelectDeviceEvent>((event, emit) {
      emit(DeviceSelectedState(event.nameDevice));
    });
    on<DeSelectDeviceEvent>((event, emit) {
      emit(DeviceIdleState());
    });
    on<DeviceDoMeasureEvent>((event, emit) async {
      emit(DeviceMeasuringState());
      await Future.delayed(Duration(seconds: 3));
      final response = await _deviceService.addObservation(event.idFhirUser, event.value, event.value2, event.observationType);
      if (response != null) {
        emit(DeviceMeasureDoneState(response, event.nameDevice));
      }
    });
  }
}
