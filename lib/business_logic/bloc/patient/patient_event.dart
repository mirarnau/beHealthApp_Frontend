part of 'patient_bloc.dart';

abstract class PatientEvent extends Equatable {
  const PatientEvent();
}

class PatientLoadRequest extends PatientEvent {
  final String id;
  const PatientLoadRequest(this.id);
  @override
  List<Object?> get props => [id];
}
