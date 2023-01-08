import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medical_devices/data/Models/Conversation.dart';
import 'package:medical_devices/data/Services/conversationService.dart';

part 'conversation_event.dart';
part 'conversation_state.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  final ConversationService _conversationService;
  ConversationBloc(this._conversationService) : super(ConversationsIdleConversationsState()) {
    on<CreateConversationEvent>((event, emit) async {
      emit(ConversationsLoadingState());
      var res = await _conversationService.createConversation(event.idManager, event.idPatient, event.idGroup);
      if (res != null) {
        emit(ConversationsIdleChatState());
      }
    });
    on<LoadConversationsPatientEvent>((event, emit) async {
      emit(ConversationsLoadingState());
      var res = await _conversationService.getConversationsByPatient(event.idPatient);
      if (res != null) {
        emit(ConversationsLoadedState(res));
      } else {
        emit(NoConversationsState());
      }
    });
    on<LoadConversationsManagerEvent>((event, emit) async {
      emit(ConversationsLoadingState());
      var res = await _conversationService.getConversationsByManager(event.idManager);
      if (res != null) {
        emit(ConversationsLoadedState(res));
      } else {
        emit(NoConversationsState());
      }
    });
    on<LoadConversationsGroupEvent>((event, emit) async {
      emit(ConversationsLoadingState());
      var res = await _conversationService.getConversationsByGroup(event.idGroup);
      if (res != null) {
        emit(ConversationsLoadedState(res));
      } else {
        emit(NoConversationsState());
      }
    });
    on<AddMessageEvent>((event, emit) async {
      emit(ConversationsLoadingState());
      var res = await _conversationService.addMessageToConversation(event.idConversation, event.idFrom, event.idTo, event.text);
      print(res.toString());
      if (res != null) {
        emit(ConversationSingleLoadedState(res));
      }
    });
    on<LoadConversationEvent>((event, emit) async {
      emit(ConversationsLoadingState());
      var res = await _conversationService.getConversation(event.idManager, event.idPatient, event.idGroup);
      if (res != null) {
        emit(ConversationSingleLoadedState(res));
      } else {
        emit(ConversationNotFoundState());
      }
    });
    on<ConversationToIdleChatEvent>((event, emit) {
      emit(ConversationsIdleChatState());
    });
    on<ConversationToIdleConversationEvent>((event, emit) {
      emit(ConversationsIdleConversationsState());
    });
  }
}
