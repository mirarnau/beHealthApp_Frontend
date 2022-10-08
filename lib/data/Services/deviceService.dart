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
}
