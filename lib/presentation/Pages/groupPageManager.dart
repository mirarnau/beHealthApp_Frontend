// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:medical_devices/business_logic/bloc/requests/requests_bloc.dart';
import 'package:medical_devices/data/Models/Group.dart';
import 'package:medical_devices/presentation/Pages/infoPatientGroup.dart';

class GroupPageManager extends StatefulWidget {
  final Group group;
  const GroupPageManager({Key? key, required this.group}) : super(key: key);

  @override
  _GroupPageManagerState createState() => _GroupPageManagerState();
}

class _GroupPageManagerState extends State<GroupPageManager> {
  List<String> idPatientsRequests = [];
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<RequestsBloc>(context).add(LoadRequestsGroupEvent(widget.group.id));
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Color.fromARGB(255, 255, 255, 255)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Theme.of(context).cardColor,
        title: Text(
          translate('titles.beHealthApp'),
          style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.chat_bubble_rounded))],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DefaultTabController(
            length: 3,
            child: Column(
              children: [
                TabBar(
                  indicatorColor: Color.fromARGB(255, 30, 61, 72),
                  labelColor: Color.fromARGB(255, 30, 61, 72),
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  tabs: [
                    Tab(
                      child: Text('Users'),
                    ),
                    Tab(
                      child: Text('Charts'),
                    ),
                    Tab(
                      child: Text('Requests'),
                    ),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 700,
                  child: TabBarView(
                    children: <Widget>[
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: widget.group.patients.length,
                        itemBuilder: ((context, index) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                            child: GestureDetector(
                              onTap: () {},
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => InfoPatientPage(user: widget.group.patients[index])));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                    20.0,
                                  )),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: SizedBox(
                                      width: 60.0,
                                      height: 60.0,
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 30.0,
                                            backgroundImage: NetworkImage(widget.group.patients[index].imageUrl),
                                          ),
                                          SizedBox(width: 10.0),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                widget.group.patients[index].fullName,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15.0,
                                                ),
                                              ),
                                              Text(
                                                widget.group.patients[index].email,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 13.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Spacer(),
                                          BlocBuilder<RequestsBloc, RequestsState>(
                                            builder: (context, state) {
                                              if (state is RequestsLoadedState) {
                                                for (int i = 0; i < state.jsonRequests.length; i++) {
                                                  idPatientsRequests.add(state.jsonRequests[i]['patient']['_id']);
                                                }
                                              }
                                              return Visibility(
                                                visible: idPatientsRequests.contains(widget.group.patients[index].apiId),
                                                child: Container(
                                                  color: Color.fromARGB(255, 255, 200, 0),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(4.0),
                                                    child: Text(
                                                      'PENDING',
                                                      style: TextStyle(fontWeight: FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                      Text('Charts'),
                      BlocBuilder<RequestsBloc, RequestsState>(
                        builder: (context, state) {
                          if (state is RequestsLoadedState) {
                            for (int i = 0; i < state.jsonRequests.length; i++) {
                              idPatientsRequests.add(state.jsonRequests[i]['patient']['_id']);
                            }
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.jsonRequests.length,
                              itemBuilder: ((context, index) {
                                return Padding(
                                  padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                        20.0,
                                      )),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: SizedBox(
                                          width: 60.0,
                                          height: 60.0,
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 30.0,
                                                backgroundImage: NetworkImage(state.jsonRequests[index]['patient']['image_url']),
                                              ),
                                              SizedBox(width: 10.0),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    state.jsonRequests[index]['patient']['full_name'],
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 15.0,
                                                    ),
                                                  ),
                                                  Text(
                                                    state.jsonRequests[index]['patient']['email'],
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.normal,
                                                      fontSize: 13.0,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            );
                          }
                          if (state is NoRequestsState) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    translate('pages.groups_page.no_requests'),
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 30, 61, 72),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                  Icon(
                                    Icons.group_off,
                                    size: 100.0,
                                    color: Color.fromARGB(255, 30, 61, 72),
                                  )
                                ],
                              ),
                            );
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
