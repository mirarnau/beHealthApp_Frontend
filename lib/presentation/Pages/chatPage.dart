// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_devices/business_logic/bloc/authorization/authorization_bloc.dart';
import 'package:medical_devices/business_logic/bloc/conversation/conversation_bloc.dart';
import 'package:medical_devices/data/Models/Group.dart';
import 'package:medical_devices/data/Models/User.dart';

class ChatPage extends StatefulWidget {
  final User receiver;
  final String groupName;
  final String groupId;
  final String managerId;
  final bool isManager;

  const ChatPage({Key? key, required this.receiver, required this.groupName, required this.groupId, required this.managerId, required this.isManager}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final messageController = TextEditingController();

  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ConversationBloc>(context).add(ConversationToIdleChatEvent());
    return BlocBuilder<AuthorizationBloc, AuthorizationState>(
      builder: (context, stateAuth) {
        if (stateAuth is AuthorizedState) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              backgroundColor: Theme.of(context).cardColor,
              flexibleSpace: SafeArea(
                child: Container(
                  padding: EdgeInsets.only(right: 16),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          BlocProvider.of<ConversationBloc>(context).add(ConversationToIdleConversationEvent());
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Color.fromARGB(255, 197, 196, 196),
                        ),
                      ),
                      CircleAvatar(
                        radius: 20.0,
                        backgroundImage: NetworkImage(widget.receiver.imageUrl),
                      ),
                      SizedBox(width: 2),
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(widget.receiver.fullName, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              widget.groupName,
                              style: TextStyle(color: Color.fromARGB(255, 197, 196, 196), fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.settings,
                        color: Color.fromARGB(255, 197, 196, 196),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: BlocConsumer<ConversationBloc, ConversationState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is ConversationSingleLoadedState) {
                  if (state.conversation.listMessages.isEmpty) {
                    BlocProvider.of<ConversationBloc>(context).add(AddMessageEvent(state.conversation.id, stateAuth.user.apiId, widget.receiver.apiId, messageController.text));
                    messageController.clear();
                  }
                  return Container(
                    color: Color.fromARGB(255, 12, 24, 28),
                    child: Stack(
                      children: <Widget>[
                        ListView.builder(
                          itemCount: state.conversation.listMessages.length,
                          shrinkWrap: true,
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(8.0, 5.0, 8.0, 0.0),
                              child: Container(
                                padding: EdgeInsets.fromLTRB(state.conversation.listMessages[index].from.fullName != widget.receiver.fullName ? 50.0 : 5.0, 4, state.conversation.listMessages[index].from.fullName == widget.receiver.fullName ? 54.0 : 5.0, 4),
                                child: Align(
                                  alignment: (state.conversation.listMessages[index].from.fullName != widget.receiver.fullName ? Alignment.topRight : Alignment.topLeft),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: (state.conversation.listMessages[index].from.fullName == widget.receiver.fullName ? Color.fromARGB(255, 30, 61, 72) : Theme.of(context).primaryColor),
                                    ),
                                    padding: EdgeInsets.all(16),
                                    child: Text(
                                      state.conversation.listMessages[index].text,
                                      style: TextStyle(fontSize: 15, color: state.conversation.listMessages[index].from.fullName == widget.receiver.fullName ? Colors.white : Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                            height: 100,
                            width: double.infinity,
                            color: Color.fromARGB(255, 30, 61, 72),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {},
                                  child: Icon(
                                    Icons.add,
                                    color: Theme.of(context).primaryColor,
                                    size: 35,
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: TextFormField(
                                    controller: messageController,
                                    style: TextStyle(color: Color.fromARGB(255, 184, 184, 184)),
                                    decoration: InputDecoration(
                                      hintText: "Write message...",
                                      hintStyle: TextStyle(color: Color.fromARGB(255, 184, 184, 184), fontSize: 16.0),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 20.0),
                                  child: SizedBox(
                                    height: 50.0,
                                    width: 50.0,
                                    child: FloatingActionButton(
                                      onPressed: () {
                                        if (messageController.text.isNotEmpty) {
                                          BlocProvider.of<ConversationBloc>(context).add(AddMessageEvent(state.conversation.id, stateAuth.user.apiId, widget.receiver.apiId, messageController.text));
                                          messageController.clear();
                                        }
                                      },
                                      child: Icon(
                                        Icons.send,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                      backgroundColor: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                if (state is ConversationNotFoundState) {
                  return Container(
                    color: Color.fromARGB(255, 12, 24, 28),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                        height: 100,
                        width: double.infinity,
                        color: Color.fromARGB(255, 30, 61, 72),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {},
                              child: Icon(
                                Icons.add,
                                color: Theme.of(context).primaryColor,
                                size: 35,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: messageController,
                                style: TextStyle(color: Color.fromARGB(255, 184, 184, 184)),
                                decoration: InputDecoration(
                                  hintText: "Write message...",
                                  hintStyle: TextStyle(color: Color.fromARGB(255, 184, 184, 184), fontSize: 16.0),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: SizedBox(
                                height: 50.0,
                                width: 50.0,
                                child: FloatingActionButton(
                                  onPressed: () {
                                    if (messageController.text.isNotEmpty) {
                                      BlocProvider.of<ConversationBloc>(context).add(CreateConversationEvent(widget.managerId, widget.receiver.apiId, widget.groupId));
                                    }
                                  },
                                  child: Icon(
                                    Icons.send,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                  backgroundColor: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
                if (state is ConversationsLoadingState) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is ConversationsIdleChatState) {
                  if (widget.isManager) {
                    BlocProvider.of<ConversationBloc>(context).add(LoadConversationEvent(widget.managerId, widget.receiver.apiId, widget.groupId));
                  } else {
                    BlocProvider.of<ConversationBloc>(context).add(LoadConversationEvent(widget.managerId, stateAuth.user.apiId, widget.groupId));
                  }
                  return Center(child: Text('UNLOADED'));
                } else {
                  return Center(child: Text('IDLE CONVERSATION STATE'));
                }
              },
            ),
          );
        } else {
          return Center(child: Text('NOT AUTHORIZED'));
        }
      },
    );
  }
}
