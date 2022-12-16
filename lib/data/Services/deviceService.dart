import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:medical_devices/data/Models/Observation.dart';
import 'package:medical_devices/data/Models/User.dart';

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

  Future<Observation?> addObservation(String idFhirUser, num value, num value2, String observationType) async {
    String url = "http://localhost:3000/api/patients/observation";
    Map<String, dynamic> bodyJson = {};
    if (observationType == "Temperature") {
      bodyJson = Observation.tempObservationtoJson(idFhirUser, value);
    }
    if (observationType == "Pressure") {
      bodyJson = Observation.pressureObservationtoJson(idFhirUser, value, value2);
    }
    if (observationType == "Weight") {
      bodyJson = Observation.weightObservationtoJson(idFhirUser, value);
    }
    var res = await http.post(Uri.parse(url), headers: {'content-type': 'application/json', 'accept': 'application/fhir+json'}, body: json.encode(bodyJson));

    if (res.statusCode == 200) {
      var decoded = jsonDecode(res.body);
      var observation = Observation.fromJSON(decoded, decoded.containsKey("component"), decoded.containsKey("referenceRange"));
      return observation;
    }
    return null;
  }

  Future<List<Observation>?> getAllObservationsByPatient(String patientId) async {
    var res = await http.get(Uri.parse('$baseUrl?patient=$patientId'), headers: {'accept': 'application/fhir+json'});
    print(patientId);
    List<Observation> allObservationsPatient = [];
    var jsonContainsComponents = false;
    var jsonContainsReferences = false;
    var decoded = jsonDecode(res.body);

    if (decoded["total"] != 0) {
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
    for (int id = 0; id < 1000; id++) {
      await http.delete(Uri.parse('$baseUrl/$id'), headers: {'accept': 'application/fhir+json'});
    }
  }
}
