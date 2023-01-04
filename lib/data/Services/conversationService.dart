import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:medical_devices/data/Models/Conversation.dart';
import 'package:medical_devices/data/Models/Device.dart';
import 'package:medical_devices/data/Models/Group.dart';
import 'package:medical_devices/data/Models/User.dart';
import 'package:localstorage/localstorage.dart';

class ConversationService {
  var baseUrlApi = "http://localhost:3000/api/conversations";
  final LocalStorage storage = LocalStorage('key');

  Future<List<Conversation>?> getConversationsByManager(String idManager) async {
    var res = await http.get(Uri.parse('$baseUrlApi/manager/$idManager'), headers: {'accept': 'application/json'});
    if (res.statusCode == 200) {
      var decoded = jsonDecode(res.body);
      List<Conversation> listConversationsManager = [];
      decoded.forEach((conversation) => listConversationsManager.add(Conversation.fromJSON(conversation)));
      return listConversationsManager;
    }
    return null;
  }

  Future<List<Conversation>?> getConversationsByPatient(String idPatient) async {
    var res = await http.get(Uri.parse('$baseUrlApi/patient/$idPatient'), headers: {'accept': 'application/json'});
    if (res.statusCode == 200) {
      var decoded = jsonDecode(res.body);
      List<Conversation> listConversationsPatient = [];
      decoded.forEach((conversation) => listConversationsPatient.add(Conversation.fromJSON(conversation)));
      return listConversationsPatient;
    }
    return null;
  }

  Future<List<Conversation>?> getConversationsByGroup(String idGroup) async {
    var res = await http.get(Uri.parse('$baseUrlApi/group/$idGroup'), headers: {'accept': 'application/json'});
    if (res.statusCode == 200) {
      var decoded = jsonDecode(res.body);
      List<Conversation> listConversationsGroup = [];
      decoded.forEach((conversation) => listConversationsGroup.add(Conversation.fromJSON(conversation)));
      return listConversationsGroup;
    }
    return null;
  }

  Future<Conversation?> addMessageToConversation(String idConversation, String idFrom, String idTo, String text) async {
    var bodyJson = {
      'idConversation': idConversation,
      'from': idFrom,
      'to': idTo,
      'text': text,
    };
    var res = await http.post(Uri.parse('$baseUrlApi/messages'), headers: {'content-type': 'application/json'}, body: json.encode(bodyJson));

    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      var conversation = Conversation.fromJSON(data);
      return conversation;
    }
    return null;
  }

  Future<String?> createConversation(String idManager, String idPatient, String idGroup) async {
    var bodyJson = {
      'manager': idManager,
      'patient': idPatient,
      'group': idGroup,
    };
    var res = await http.post(Uri.parse(baseUrlApi), headers: {'content-type': 'application/json'}, body: json.encode(bodyJson));

    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      return data['_id'];
    }
    return null;
  }

  Future<Conversation?> getConversation(String idManager, String idPatient, String idGroup) async {
    var bodyJson = {
      'manager': idManager,
      'patient': idPatient,
      'group': idGroup,
    };
    var res = await http.post(Uri.parse('$baseUrlApi/conversation'), headers: {'content-type': 'application/json'}, body: json.encode(bodyJson));

    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      var conversation = Conversation.fromJSON(data);
      return conversation;
    }
    return null;
  }
}
