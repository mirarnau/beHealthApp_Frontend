part of 'groups_bloc.dart';

abstract class GroupsState extends Equatable {
  const GroupsState();
}

class GroupsUnloadedState extends GroupsState {
  @override
  List<Object?> get props => [];
}

class GroupsLoadingState extends GroupsState {
  @override
  List<Object?> get props => [];
}

class GroupsLoadedState extends GroupsState {
  final List<Group> listGroups;
  const GroupsLoadedState(this.listGroups);
  @override
  List<Object?> get props => [listGroups];
}

class NoGroupsState extends GroupsState {
  @override
  List<Object?> get props => [];
}

class GroupCreatedState extends GroupsState {
  final Group group;
  const GroupCreatedState(this.group);
  @override
  List<Object?> get props => [group];
}
