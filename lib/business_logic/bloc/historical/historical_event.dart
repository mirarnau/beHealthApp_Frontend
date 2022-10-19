part of 'historical_bloc.dart';

abstract class HistoricalEvent extends Equatable {
  const HistoricalEvent();
}

class LoadHistoricalDataEvent extends HistoricalEvent {
  final String idPatient;
  const LoadHistoricalDataEvent(this.idPatient);
  @override
  List<Object?> get props => throw [idPatient];
}

class SelectHistoricalVisualizationEvent extends HistoricalEvent {
  final List<Observation> observations;
  final String associatedDevice;
  const SelectHistoricalVisualizationEvent(this.observations, this.associatedDevice);
  @override
  List<Object?> get props => throw [observations, associatedDevice];
}
