import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medical_devices/data/Models/Group.dart';
import 'package:medical_devices/data/Services/groupService.dart';

part 'groups_event.dart';
part 'groups_state.dart';

class GroupsBloc extends Bloc<GroupsEvent, GroupsState> {
  final GroupService _groupService;
  GroupsBloc(this._groupService) : super(GroupsUnloadedState()) {
    on<LoadGroupsEvent>((event, emit) async {
      emit(GroupsLoadingState());
      final response;
      if (event.isManager) {
        response = await _groupService.getGroupsByManager(event.userId);
      } else {
        response = await _groupService.getGroupsByPatient(event.userId);
      }
      if (response != null) {
        emit(GroupsLoadedState(response));
      } else {
        emit(NoGroupsState());
      }
    });
    on<AddGroupEvent>((event, emit) async {
      emit(GroupsLoadingState());
      final response = await _groupService.addGroup(event.group);
      if (response != null) {
        emit(GroupCreatedState(response));
      } else {
        emit(GroupsUnloadedState());
      }
    });
    on<GoToIdleEvent>((event, emit) async {
      emit(GroupsUnloadedState());
    });
  }
}
