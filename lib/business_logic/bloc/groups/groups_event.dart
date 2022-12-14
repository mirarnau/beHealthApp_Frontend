part of 'groups_bloc.dart';

abstract class GroupsEvent extends Equatable {
  const GroupsEvent();
}

class LoadGroupsEvent extends GroupsEvent {
  final String userId;
  final bool isManager;
  const LoadGroupsEvent(this.userId, this.isManager);
  @override
  List<Object?> get props => [userId, isManager];
}

class AddGroupEvent extends GroupsEvent {
  final Group group;
  const AddGroupEvent(this.group);
  @override
  List<Object?> get props => [group];
}

class GoToIdleEvent extends GroupsEvent {
  @override
  List<Object?> get props => [];
}

class DeleteGroupEvent extends GroupsEvent {
  @override
  List<Object?> get props => [];
}
