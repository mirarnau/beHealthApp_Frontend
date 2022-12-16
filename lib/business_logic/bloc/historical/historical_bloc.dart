// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medical_devices/data/Models/Observation.dart';
import 'package:medical_devices/data/Services/deviceService.dart';

part 'historical_event.dart';
part 'historical_state.dart';

class HistoricalBloc extends Bloc<HistoricalEvent, HistoricalState> {
  final DeviceService _deviceService;
  HistoricalBloc(this._deviceService) : super(HistoricalUnloadedState()) {
    on<LoadHistoricalDataEvent>((event, emit) async {
      emit(HistoricalLoadingState());
      final response = await _deviceService.getAllObservationsByPatient(event.idPatient);
      if (response != null) {
        emit(HistoricalLoadedState(response));
      } else {
        emit(HistoricalLoadedState([]));
      }
    });
    on<SelectHistoricalVisualizationEvent>((event, emit) {
      emit(HistoricalVisualizationState(event.observations, event.associatedDevice));
    });
  }
}
