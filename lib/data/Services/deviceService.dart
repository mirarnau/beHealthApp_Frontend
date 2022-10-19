import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:medical_devices/data/Models/Observation.dart';
import 'package:medical_devices/data/Models/Patient.dart';

class DeviceService {
  var baseUrl = "http://localhost:8080/fhir/Observation";

  Future<Observation?> getObservationById(String id) async {
    var res = await http.get(Uri.parse('$baseUrl/$id'), headers: {'accept': 'application/fhir+json'});
    if (res.statusCode == 200) {
      var jsonDecoded = jsonDecode(res.body);
      var jsonContainsComponents = false;
      var jsonContainsReferences = false;

      if (jsonDecoded.containsKey("component")) {
        jsonContainsComponents = true;
      }
      if (jsonDecoded.containsKey("referenceRange")) {
        jsonContainsReferences = true;
      }
      print(jsonDecode(res.body));
      Observation observation = Observation.fromJSON(jsonDecoded, jsonContainsComponents, jsonContainsReferences);

      return observation;
    }
    return null;
  }

  Future<List<Observation>?> getAllObservationsByPatient(String patientId) async {
    var res = await http.get(Uri.parse('$baseUrl?patient=$patientId'), headers: {'accept': 'application/fhir+json'});
    List<Observation> allObservationsPatient = [];
    var jsonContainsComponents = false;
    var jsonContainsReferences = false;

    if (res.statusCode == 200) {
      var decoded = jsonDecode(res.body);
      var observationsDecoded = decoded["entry"];
      observationsDecoded.forEach((observation) {
        if (observation["resource"].containsKey("component")) {
          jsonContainsComponents = true;
        }
        if (observation["resource"].containsKey("referenceRange")) {
          jsonContainsReferences = true;
        }
        allObservationsPatient.add(Observation.fromJSON(observation["resource"], jsonContainsComponents, jsonContainsReferences));
        jsonContainsComponents = false;
        jsonContainsReferences = false;
      });

      return allObservationsPatient;
    }

    return null;
  }

//MUST BE DELETED IN THE END
  Future<void> deleteObservationById() async {
    for (int id = 0; id < 200; id++) {
      if ((id != 77) && (id != 70) && (id != 58)) {
        await http.delete(Uri.parse('$baseUrl/$id'), headers: {'accept': 'application/fhir+json'});
      }
    }
  }
}
