// ignore_for_file: prefer_const_constructors_in_immutables

part of 'patient_bloc.dart';

abstract class PatientState extends Equatable {
  const PatientState();
}

class PatientUnloadedState extends PatientState {
  @override
  List<Object?> get props => [];
}

class PatientLoadingState extends PatientState {
  @override
  List<Object?> get props => [];
}

class PatientLoadedState extends PatientState {
  final User loadedPatient;
  PatientLoadedState(this.loadedPatient);

  @override
  List<Object?> get props => [loadedPatient];
}
