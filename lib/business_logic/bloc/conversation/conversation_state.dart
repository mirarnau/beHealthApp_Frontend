part of 'conversation_bloc.dart';

abstract class ConversationState extends Equatable {}

class ConversationsIdleConversationsState extends ConversationState {
  @override
  List<Object?> get props => [];
}

class ConversationsIdleChatState extends ConversationState {
  @override
  List<Object?> get props => [];
}

class ConversationNotFoundState extends ConversationState {
  @override
  List<Object?> get props => [];
}

class NoConversationsState extends ConversationState {
  @override
  List<Object?> get props => [];
}

class ConversationsLoadingState extends ConversationState {
  @override
  List<Object?> get props => [];
}

class ConversationsSendingState extends ConversationState {
  @override
  List<Object?> get props => [];
}

class ConversationsLoadedState extends ConversationState {
  final List<Conversation> listConversations;
  ConversationsLoadedState(this.listConversations);
  @override
  List<Object?> get props => [listConversations];
}

class ConversationSingleLoadedState extends ConversationState {
  final Conversation conversation;
  ConversationSingleLoadedState(this.conversation);
  @override
  List<Object?> get props => [conversation];
}
