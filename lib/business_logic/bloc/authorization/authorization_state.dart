part of 'authorization_bloc.dart';

abstract class AuthorizationState extends Equatable {
  const AuthorizationState();
}

class UnauthorizedState extends AuthorizationState {
  @override
  List<Object?> get props => [];
}

class RegisteringState extends AuthorizationState {
  @override
  List<Object?> get props => [];
}

class AuthorizingState extends AuthorizationState {
  @override
  List<Object?> get props => [];
}

class AuthorizedState extends AuthorizationState {
  final User user;
  final User userFhir;
  const AuthorizedState(this.user, this.userFhir);
  @override
  List<Object?> get props => [user, userFhir];
}
