import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medical_devices/data/Models/Group.dart';
import 'package:medical_devices/data/Services/groupService.dart';

part 'requests_event.dart';
part 'requests_state.dart';

class RequestsBloc extends Bloc<RequestsEvent, RequestsState> {
  final GroupService _groupService;
  RequestsBloc(this._groupService) : super(RequestsUnloadedState()) {
    on<GenerateRequestEvent>((event, emit) async {
      for (int i = 0; i < event.listRequests.length; i++) {
        await _groupService.generateGroupRequest(event.listRequests[i].groupId, event.listRequests[i].patientId);
      }
    });
    on<LoadRequestsGroupEvent>((event, emit) async {
      emit(RequestsLoadingState());
      var res = await _groupService.getRequestsByGroup(event.idGroup);
      if (res != null) {
        emit(RequestsLoadedState(res));
      } else {
        emit(NoRequestsState());
      }
    });
    on<LoadRequestsPatientEvent>((event, emit) async {
      emit(RequestsLoadingState());
      var res = await _groupService.getRequestsByPatient(event.idPatient);
      if (res != null) {
        emit(RequestsLoadedState(res));
      } else {
        emit(NoRequestsState());
      }
    });
    on<AcceptRequestEvent>((event, emit) async {
      emit(RequestsLoadingState());
      await _groupService.acceptGroupRequest(event.idGroup, event.idPatient, event.idRequest);
      var res = await _groupService.getRequestsByPatient(event.idPatient);
      if (res != null) {
        emit(RequestsLoadedState(res));
      } else {
        emit(NoRequestsState());
      }
    });
    on<DeclineRequestEvent>((event, emit) async {
      emit(RequestsLoadingState());
      await _groupService.declineGroupRequest(event.idRequest);
      var res = await _groupService.getRequestsByPatient(event.idPatient);
      if (res != null) {
        emit(RequestsLoadedState(res));
      } else {
        emit(NoRequestsState());
      }
    });
    on<GoToUnloadedEvent>((event, emit) async {
      emit(RequestsUnloadedState());
    });
  }
}
