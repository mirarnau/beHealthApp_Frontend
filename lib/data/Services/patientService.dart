import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:medical_devices/data/Models/Patient.dart';

class PatientService {
  var baseUrl = "http://localhost:8080/fhir/Patient";

  Future<Patient?> getPatientById(String id) async {
    var res = await http.get(Uri.parse('$baseUrl/$id'), headers: {'accept': 'application/fhir+json'});
    if (res.statusCode == 200) {
      Patient patient = Patient.fromJSON(jsonDecode(res.body));
      return patient;
    }
    return null;
  }
}
