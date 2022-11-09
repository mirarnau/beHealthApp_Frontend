import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medical_devices/data/Models/Patient.dart';
import 'package:medical_devices/data/Services/patientService.dart';

part 'authorization_event.dart';
part 'authorization_state.dart';

class AuthorizationBloc extends Bloc<AuthorizationEvent, AuthorizationState> {
  final PatientService _patientService;
  AuthorizationBloc(this._patientService) : super(UnauthorizedState()) {
    on<RegisterEvent>((event, emit) async {
      emit(RegisteringState());
      final response = await _patientService.addUser(event.patient);
      if (response != null) {
        emit(UnauthorizedState());
      }
    });
    on<LoginEvent>((event, emit) async {
      final response = await _patientService.loginPatient(event.email, event.password);
      if (response != null) {
        emit(AuthorizedState(response));
      } else {
        emit(UnauthorizedState());
      }
    });
  }
}
