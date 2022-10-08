import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medical_devices/data/Models/Observation.dart';
import 'package:medical_devices/data/Services/deviceService.dart';

part 'device_event.dart';
part 'device_state.dart';

class DeviceBloc extends Bloc<DeviceEvent, DeviceState> {
  DeviceService _deviceService;
  DeviceBloc(this._deviceService) : super(DeviceIdleState()) {
    on<SelectDeviceEvent>((event, emit) {
      emit(DeviceSelectedState(event.nameDevice));
    });
    on<DeSelectDeviceEvent>((event, emit) {
      emit(DeviceIdleState());
    });
    on<DeviceDoMeasureEvent>((event, emit) async {
      emit(DeviceMeasuringState());
      final response = await _deviceService.getObservationById(event.id);
      if (response != null) {
        emit(DeviceMeasureDoneState(response, event.nameDevice));
      }
    });
  }
}
