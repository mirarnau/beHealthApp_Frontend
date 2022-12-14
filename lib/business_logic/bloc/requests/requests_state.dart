part of 'requests_bloc.dart';

abstract class RequestsState extends Equatable {
  const RequestsState();
}

class RequestsUnloadedState extends RequestsState {
  @override
  List<Object?> get props => [];
}

class RequestsLoadingState extends RequestsState {
  @override
  List<Object?> get props => [];
}

class NoRequestsState extends RequestsState {
  @override
  List<Object?> get props => [];
}

class RequestsLoadedState extends RequestsState {
  final dynamic jsonRequests;
  const RequestsLoadedState(this.jsonRequests);
  @override
  List<Object?> get props => [jsonRequests];
}
