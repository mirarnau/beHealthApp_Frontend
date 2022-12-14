part of 'authorization_bloc.dart';

abstract class AuthorizationEvent extends Equatable {
  const AuthorizationEvent();
}

class RegisterEvent extends AuthorizationEvent {
  final User patient;
  final bool isManager;
  const RegisterEvent(this.patient, this.isManager);
  @override
  List<Object?> get props => [patient, isManager];
}

class LoginEvent extends AuthorizationEvent {
  final String email;
  final String password;
  const LoginEvent(this.email, this.password);
  @override
  List<Object?> get props => [email, password];
}

class LogoutEvent extends AuthorizationEvent {
  @override
  List<Object?> get props => [];
}
