import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:medical_devices/data/Models/Device.dart';
import 'package:medical_devices/data/Models/Observation.dart';
import 'package:medical_devices/data/Models/User.dart';
import 'package:localstorage/localstorage.dart';

class UserService {
  var baseUrlFhir = "http://localhost:8080/fhir/Patient";
  var baseUrlApi = "http://localhost:3000/api/patients";
  final LocalStorage storage = LocalStorage('key');

  Future<User?> getPatientById(String id) async {
    var res = await http.get(Uri.parse('$baseUrlFhir/$id'), headers: {'accept': 'application/fhir+json'});
    if (res.statusCode == 200) {
      User patient = User.fromJSON(jsonDecode(res.body));
      return patient;
    }
    return null;
  }

  Future<User?> getPatientFromFhir(String idApi) async {
    var res = await http.get(Uri.parse('$baseUrlApi/fhir/$idApi'), headers: {'accept': 'application/fhir+json'});
    if (res.statusCode == 200) {
      User patient = User.fromJSON(jsonDecode(res.body));
      return patient;
    }
    return null;
  }

  Future<List<User>> filterUser(String text) async {
    var res = await http.get(Uri.parse('$baseUrlApi/filter/$text'), headers: {'accept': 'application/fhir+json'});
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      List<User> listUsers = [];
      for (int i = 0; i < data.length; i++) {
        listUsers.add(User.fromJSON(data[i]));
      }
      print(listUsers.toString());
      return listUsers;
    }
    return [];
  }

  Future<User?> login(String email, String password) async {
    final msg = jsonEncode({"email": email, "password": password});
    var res = await http.post(Uri.parse('$baseUrlApi/login'), headers: {'content-type': 'application/json'}, body: msg);
    if (res.statusCode == 200) {
      var token = JWTtoken.fromJson(await jsonDecode(res.body));
      storage.setItem('token', token.toString());
      User user = User.fromJSON(jsonDecode(res.body)['user']);
      return user;
    }
    return null;
  }

  Future<String?> addUser(User patient, bool isManager) async {
    String url;
    if (isManager) {
      url = "http://localhost:3000/api/managers";
    } else {
      url = "http://localhost:3000/api/patients";
    }
    var res = await http.post(Uri.parse(url), headers: {'content-type': 'application/json'}, body: json.encode(User.toJsonApi(patient)));

    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      return data['_id'];
    }
    return null;
  }

  Future<List<Device>?> addDeviceToPatient(String patientId, Device device) async {
    var jsonBody = {"name": device.nameDevice, "model": device.modelDevice, "assets_image_url": device.photoDevice, "verified": device.verified};
    var res = await http.post(Uri.parse('$baseUrlApi/add_device/$patientId'), headers: {'content-type': 'application/json', 'authorization': LocalStorage('key').getItem('token')}, body: json.encode(jsonBody));

    if (res.statusCode == 201) {
      var data = jsonDecode(res.body);
      List<Device> updatedListDevices = [];
      for (int i = 0; i < data['devices'].length; i++) {
        updatedListDevices.add(Device(data['devices'][i]['name'], data['devices'][i]['assets_image_url'], data['devices'][i]['model'], false, true, data['devices'][i]['verified']));
      }
      return updatedListDevices;
    }
    return null;
  }

  Future<List<Device>?> removeDeviceFromPatient(String patientId, Device device) async {
    var jsonBody = {"name": device.nameDevice, "model": device.modelDevice, "assets_image_url": device.photoDevice, "verified": device.verified};
    var res = await http.post(Uri.parse('$baseUrlApi/remove_device/$patientId'), headers: {'content-type': 'application/json', 'authorization': LocalStorage('key').getItem('token')}, body: json.encode(jsonBody));

    if (res.statusCode == 201) {
      var data = jsonDecode(res.body);
      List<Device> updatedListDevices = [];
      for (int i = 0; i < data['devices'].length; i++) {
        updatedListDevices.add(Device(data['devices'][i]['name'], data['devices'][i]['assets_image_url'], data['devices'][i]['model'], false, true, data['devices'][i]['verified']));
      }
      return updatedListDevices;
    }
    return null;
  }

  Future<List<Device>?> getAllDevicesPatient(String patientId) async {
    var res = await http.get(Uri.parse('$baseUrlApi/devices_patient/$patientId'), headers: {'authorization': LocalStorage('key').getItem('token')});

    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      List<Device> listDevices = [];
      for (int i = 0; i < data['devices'].length; i++) {
        listDevices.add(Device(data['devices'][i]['name'], data['devices'][i]['assets_image_url'], data['devices'][i]['model'], false, true, data['devices'][i]['verified']));
      }
      return listDevices;
    }
    return null;
  }
}

class JWTtoken {
  final String tokenValue;

  JWTtoken({
    required this.tokenValue,
  });

  factory JWTtoken.fromJson(Map<String, dynamic> json) {
    return JWTtoken(
      tokenValue: json['token'] as String,
    );
  }

  String toString() {
    return tokenValue;
  }
}
