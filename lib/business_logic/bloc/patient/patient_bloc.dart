import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medical_devices/data/Models/User.dart';
import 'package:medical_devices/data/Services/userService.dart';

part 'patient_event.dart';
part 'patient_state.dart';

class PatientBloc extends Bloc<PatientEvent, PatientState> {
  final UserService _patientService;
  PatientBloc(this._patientService) : super(PatientUnloadedState()) {
    on<PatientLoadRequest>((event, emit) async {
      emit(PatientLoadingState());
      final response = await _patientService.getPatientById(event.id);
      if (response != null) {
        emit(PatientLoadedState(response));
      }
    });
  }
}
