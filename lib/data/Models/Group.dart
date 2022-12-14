import 'package:medical_devices/data/Models/User.dart';

class Group {
  late final String id;
  late final String name;
  late final String description;
  late final User manager;
  late final List<User> patients;
  late final List<GroupRequestGenerated> requests;
  late final String creationDate;

  Group();
  factory Group.fromJSON(dynamic json) {
    Group group = Group();
    group.id = json['_id'];
    group.name = json['name'];
    group.description = json['description'];
    group.manager = User.fromJSON(json['manager']);
    final patientsData = json['patients'] as List<dynamic>?;
    final listPatients = patientsData != null ? patientsData.map((patient) => User.fromJSON(patient)).toList() : <User>[];
    group.patients = listPatients;
    final requestsData = json['requests'] as List<dynamic>?;
    final listRequests = requestsData != null ? requestsData.map((request) => GroupRequestGenerated.fromJSON(request)).toList() : <GroupRequestGenerated>[];
    group.requests = listRequests;
    group.creationDate = json['creationDate'];
    return group;
  }

  static Map<String, dynamic> toJson(Group group) {
    List<String> getListIdsPatients() {
      List<String> listIDs = [];
      for (int i = 0; i < group.patients.length; i++) {
        listIDs.add(group.patients[i].apiId);
      }
      return listIDs;
    }

    List<String> getListIdsRequests() {
      List<String> listIDs = [];
      for (int i = 0; i < group.requests.length; i++) {
        listIDs.add(group.requests[i].id);
      }
      return listIDs;
    }

    return {
      'name': group.name,
      'description': group.description,
      'manager': group.manager.apiId,
      'patients': getListIdsPatients(),
      'requests': getListIdsRequests(),
    };
  }
}

class GroupRequestGenerated {
  late final String id;
  late final String groupId;
  late final String patientId;
  late final String creationDate;

  GroupRequestGenerated();
  factory GroupRequestGenerated.fromJSON(dynamic json) {
    GroupRequestGenerated groupRequest = GroupRequestGenerated();
    groupRequest.id = json['_id'];
    groupRequest.groupId = json['group'];
    groupRequest.patientId = json['patient'];
    groupRequest.creationDate = json['creationDate'];
    return groupRequest;
  }
}

class GroupRequestReceived {
  late final String id;
  late final Group group;
  late final User patient;
  late final String creationDate;

  GroupRequestReceived();
  factory GroupRequestReceived.fromJSON(dynamic json) {
    GroupRequestReceived groupRequest = GroupRequestReceived();
    groupRequest.id = json['_id'];
    groupRequest.group = Group.fromJSON(json['group']);
    groupRequest.patient = User.fromJSON(json['patient']);
    groupRequest.creationDate = json['creationDate'];
    return groupRequest;
  }
}
