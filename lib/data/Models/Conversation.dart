import 'package:medical_devices/data/Models/Group.dart';
import 'package:medical_devices/data/Models/User.dart';

class Conversation {
  late final String id;
  late final User manager;
  late final User patient;
  late final String groupName;
  late final String groupId;
  late final List<Message> listMessages;
  Conversation();
  factory Conversation.fromJSON(dynamic json) {
    Conversation conversation = Conversation();
    conversation.id = json['_id'];
    conversation.groupName = json['group']['name'];
    conversation.groupId = json['group']['_id'];
    conversation.manager = User.fromJSON(json['manager']);
    conversation.patient = User.fromJSON(json['patient']);
    final messagesData = json['messages'] as List<dynamic>?;
    final listMessages = messagesData != null ? messagesData.map((message) => Message.fromJSON(message)).toList() : <Message>[];
    conversation.listMessages = listMessages;
    return conversation;
  }
}

class Message {
  late final User from;
  late final User to;
  late final String text;
  Message();
  factory Message.fromJSON(dynamic json) {
    Message message = Message();
    message.from = User.fromJSON(json['from']);
    message.to = User.fromJSON(json['to']);
    message.text = json['text'];
    return message;
  }
}
