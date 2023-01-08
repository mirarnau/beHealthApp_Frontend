import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:medical_devices/data/Models/Device.dart';
import 'package:medical_devices/data/Models/Group.dart';
import 'package:medical_devices/data/Models/User.dart';
import 'package:localstorage/localstorage.dart';

class GroupService {
  var baseUrlApi = "http://localhost:3000/api/groups";
  final LocalStorage storage = LocalStorage('key');

  Future<Group?> getGroupById(String id) async {
    var res = await http.get(Uri.parse('$baseUrlApi/$id'), headers: {'accept': 'application/json'});
    if (res.statusCode == 200) {
      Group group = Group.fromJSON(jsonDecode(res.body));
      return group;
    }
    return null;
  }

  Future<List<Group>?> getGroupsByManager(String idManager) async {
    var res = await http.get(Uri.parse('http://localhost:3000/api/groups/manager/$idManager'), headers: {'accept': 'application/json'});
    if (res.statusCode == 200) {
      var decoded = jsonDecode(res.body);
      List<Group> listGroupsManager = [];
      decoded.forEach((group) => listGroupsManager.add(Group.fromJSON(group)));
      return listGroupsManager;
    }
    return null;
  }

  Future<List<Group>?> getGroupsByPatient(String idPatient) async {
    var res = await http.get(Uri.parse('http://localhost:3000/api/groups/patient/$idPatient'), headers: {'accept': 'application/json'});
    if (res.statusCode == 200) {
      var decoded = jsonDecode(res.body);
      List<Group> listGroupsPatient = [];
      decoded.forEach((group) => listGroupsPatient.add(Group.fromJSON(group)));
      return listGroupsPatient;
    }
    return null;
  }

  Future<Group?> addGroup(Group group) async {
    var res = await http.post(Uri.parse(baseUrlApi), headers: {'content-type': 'application/json'}, body: json.encode(Group.toJson(group)));

    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      var group = Group.fromJSON(data);
      return group;
    }
    return null;
  }

  Future<String?> generateGroupRequest(String idGroup, String idPatient) async {
    var bodyJson = {
      'idGroup': idGroup,
      'idPatient': idPatient,
    };
    var res = await http.post(Uri.parse('$baseUrlApi/request/create'), headers: {'content-type': 'application/json'}, body: json.encode(bodyJson));

    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      return data['_id'];
    }
    return null;
  }

  Future<dynamic> getRequestsByGroup(String idGroup) async {
    var res = await http.get(Uri.parse('$baseUrlApi/request/get/group/$idGroup'), headers: {'accept': 'application/json'});
    if (res.statusCode == 200) {
      var decoded = jsonDecode(res.body);
      return decoded;
    }
    return null;
  }

  Future<dynamic> getRequestsByPatient(String idPatient) async {
    var res = await http.get(Uri.parse('$baseUrlApi/request/get/patient/$idPatient'), headers: {'accept': 'application/json'});
    if (res.statusCode == 200) {
      var decoded = jsonDecode(res.body);
      return decoded;
    }
    return null;
  }

  Future<dynamic> acceptGroupRequest(String idGroup, String idPatient, String idRequest) async {
    var bodyJson = {
      'idGroup': idGroup,
      'idPatient': idPatient,
      'idRequest': idRequest,
    };
    var res = await http.post(Uri.parse('$baseUrlApi/request/accept'), headers: {'content-type': 'application/json'}, body: json.encode(bodyJson));

    if (res.statusCode == 200) {
      var decoded = jsonDecode(res.body);
      return decoded;
    }
    return null;
  }

  Future<dynamic> declineGroupRequest(String idRequest) async {
    var res = await http.get(Uri.parse('$baseUrlApi/request/decline/$idRequest'), headers: {'content-type': 'application/json'});

    if (res.statusCode == 200) {
      var decoded = jsonDecode(res.body);
      return decoded;
    }
    return null;
  }

  Future<Group?> storeTotalAverageSteps(String idGroup, DateTime dateTime) async {
    var bodyJson = {
      'id': idGroup,
      'date': dateTime.toString(),
    };
    var res = await http.post(Uri.parse('$baseUrlApi/average'), headers: {'content-type': 'application/json'}, body: json.encode(bodyJson));

    if (res.statusCode == 200) {
      var decoded = jsonDecode(res.body);
      var updatedGroup = Group.fromJSON(decoded);
      return updatedGroup;
    }
    return null;
  }

  Future<dynamic> getAverages(String idGroup) async {
    var res = await http.get(Uri.parse('$baseUrlApi/averages/$idGroup'), headers: {'accept': 'application/json'});
    if (res.statusCode == 200) {
      var decoded = jsonDecode(res.body);
      return decoded;
    }
    return null;
  }
}
