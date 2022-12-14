import 'dart:isolate';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medical_devices/data/Models/User.dart';
import 'package:medical_devices/data/Services/userService.dart';

part 'authorization_event.dart';
part 'authorization_state.dart';

class AuthorizationBloc extends Bloc<AuthorizationEvent, AuthorizationState> {
  final UserService _patientService;
  AuthorizationBloc(this._patientService) : super(UnauthorizedState()) {
    on<RegisterEvent>((event, emit) async {
      emit(RegisteringState());
      final response = await _patientService.addUser(event.patient, event.isManager);
      if (response != null) {
        emit(UnauthorizedState());
      }
    });
    on<LoginEvent>((event, emit) async {
      final response = await _patientService.login(event.email, event.password);
      if (response != null) {
        emit(AuthorizedState(response));
      } else {
        emit(UnauthorizedState());
      }
    });
  }
}
