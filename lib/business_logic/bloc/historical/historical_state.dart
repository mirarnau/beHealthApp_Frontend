part of 'historical_bloc.dart';

abstract class HistoricalState extends Equatable {
  const HistoricalState();
}

class HistoricalUnloadedState extends HistoricalState {
  @override
  List<Object?> get props => [];
}

class HistoricalLoadingState extends HistoricalState {
  @override
  List<Object?> get props => [];
}

class HistoricalLoadedState extends HistoricalState {
  final List<Observation> listObservations;
  const HistoricalLoadedState(this.listObservations);
  @override
  List<Object?> get props => [listObservations];
}

class HistoricalVisualizationState extends HistoricalState {
  final List<Observation> visualizedObservations;
  final String associatedDevice;
  const HistoricalVisualizationState(this.visualizedObservations, this.associatedDevice);
  @override
  List<Object?> get props => [visualizedObservations, associatedDevice];
}
