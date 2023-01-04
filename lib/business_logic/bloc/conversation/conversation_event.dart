part of 'conversation_bloc.dart';

abstract class ConversationEvent extends Equatable {
  const ConversationEvent();
}

class CreateConversationEvent extends ConversationEvent {
  final String idManager;
  final String idPatient;
  final String idGroup;
  const CreateConversationEvent(this.idManager, this.idPatient, this.idGroup);
  @override
  List<Object?> get props => throw [idManager, idPatient];
}

class LoadConversationsPatientEvent extends ConversationEvent {
  final String idPatient;
  const LoadConversationsPatientEvent(this.idPatient);
  @override
  List<Object?> get props => throw [idPatient];
}

class LoadConversationsManagerEvent extends ConversationEvent {
  final String idManager;
  const LoadConversationsManagerEvent(this.idManager);
  @override
  List<Object?> get props => throw [idManager];
}

class LoadConversationsGroupEvent extends ConversationEvent {
  final String idGroup;
  const LoadConversationsGroupEvent(this.idGroup);
  @override
  List<Object?> get props => throw [idGroup];
}

class ConversationToIdleChatEvent extends ConversationEvent {
  @override
  List<Object?> get props => throw [];
}

class ConversationToIdleConversationEvent extends ConversationEvent {
  @override
  List<Object?> get props => throw [];
}

class LoadConversationEvent extends ConversationEvent {
  final String idManager;
  final String idPatient;
  final String idGroup;
  const LoadConversationEvent(this.idManager, this.idPatient, this.idGroup);
  @override
  List<Object?> get props => throw [idGroup];
}

class AddMessageEvent extends ConversationEvent {
  final String idConversation;
  final String idFrom;
  final String idTo;
  final String text;
  const AddMessageEvent(this.idConversation, this.idFrom, this.idTo, this.text);
  @override
  List<Object?> get props => throw [idConversation, idFrom, idTo, text];
}
