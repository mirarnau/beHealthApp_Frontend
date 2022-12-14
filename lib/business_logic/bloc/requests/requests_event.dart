part of 'requests_bloc.dart';

abstract class RequestsEvent extends Equatable {
  const RequestsEvent();
}

class LoadRequestsPatientEvent extends RequestsEvent {
  final String idPatient;
  const LoadRequestsPatientEvent(this.idPatient);
  @override
  List<Object?> get props => [idPatient];
}

class LoadRequestsGroupEvent extends RequestsEvent {
  final String idGroup;
  const LoadRequestsGroupEvent(this.idGroup);
  @override
  List<Object?> get props => [idGroup];
}

class GenerateRequestEvent extends RequestsEvent {
  final List<GroupRequestGenerated> listRequests;
  const GenerateRequestEvent(this.listRequests);
  @override
  List<Object?> get props => [listRequests];
}

class AcceptRequestEvent extends RequestsEvent {
  final String idGroup;
  final String idPatient;
  final String idRequest;
  const AcceptRequestEvent(this.idGroup, this.idPatient, this.idRequest);
  @override
  List<Object?> get props => [idGroup, idPatient, idRequest];
}

class DeclineRequestEvent extends RequestsEvent {
  final String idRequest;
  final String idPatient;
  const DeclineRequestEvent(this.idRequest, this.idPatient);
  @override
  List<Object?> get props => [idRequest, idPatient];
}

class GoToUnloadedEvent extends RequestsEvent {
  @override
  List<Object?> get props => [];
}
