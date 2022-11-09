import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:medical_devices/data/Models/Patient.dart';
import 'package:localstorage/localstorage.dart';

class PatientService {
  var baseUrlFhir = "http://localhost:8080/fhir/Patient";
  var baseUrlApi = "http://localhost:3000/api/patients";
  final LocalStorage storage = LocalStorage('key');

  Future<Patient?> getPatientById(String id) async {
    var res = await http.get(Uri.parse('$baseUrlFhir/$id'), headers: {'accept': 'application/fhir+json'});
    if (res.statusCode == 200) {
      Patient patient = Patient.fromJSON(jsonDecode(res.body));
      return patient;
    }
    return null;
  }

  Future<String?> loginPatient(String email, String password) async {
    final msg = jsonEncode({"email": email, "password": password});
    var res = await http.post(Uri.parse('$baseUrlApi/login'), headers: {'content-type': 'application/json'}, body: msg);
    if (res.statusCode == 200) {
      var token = JWTtoken.fromJson(await jsonDecode(res.body));
      storage.setItem('token', token.toString());
      var idUser = jsonDecode(res.body)['idUser'];
      return idUser;
    }
    return null;
  }

  Future<String?> addUser(Patient patient) async {
    var res = await http.post(Uri.parse(baseUrlApi), headers: {'content-type': 'application/json'}, body: json.encode(Patient.toJsonApi(patient)));

    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      return data['_id'];
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
