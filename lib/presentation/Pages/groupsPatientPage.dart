// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:medical_devices/business_logic/bloc/authorization/authorization_bloc.dart';
import 'package:medical_devices/business_logic/bloc/groups/groups_bloc.dart';
import 'package:medical_devices/business_logic/bloc/requests/requests_bloc.dart';
import 'package:medical_devices/data/Models/Group.dart';

class GroupsPatientPage extends StatefulWidget {
  const GroupsPatientPage({Key? key}) : super(key: key);

  @override
  _GroupsPatientPageState createState() => _GroupsPatientPageState();
}

class _GroupsPatientPageState extends State<GroupsPatientPage> {
  List<String> idPatientsRequests = [];
  List<String> listGroupsRequests = [];
  late String idPatient;
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<GroupsBloc>(context).add(GoToIdleEvent());
    BlocProvider.of<RequestsBloc>(context).add(GoToUnloadedEvent());
    return BlocBuilder<AuthorizationBloc, AuthorizationState>(
      builder: (context, state) {
        if (state is AuthorizedState) {
          idPatient = state.user.apiId;
        }
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    TabBar(
                      indicatorColor: Color.fromARGB(255, 30, 61, 72),
                      labelColor: Color.fromARGB(255, 30, 61, 72),
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                      tabs: [
                        Tab(
                          child: Text('Requests'),
                        ),
                        Tab(
                          child: Text('Groups'),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 500,
                      child: TabBarView(
                        children: <Widget>[
                          BlocBuilder<RequestsBloc, RequestsState>(
                            builder: (context, state) {
                              if (state is RequestsLoadedState) {
                                for (int i = 0; i < state.jsonRequests.length; i++) {
                                  listGroupsRequests.add(state.jsonRequests[i]['group']['name']);
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
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.people,
                                                  size: 40.0,
                                                ),
                                                SizedBox(width: 10.0),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      state.jsonRequests[index]['group']['name'],
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 15.0,
                                                      ),
                                                    ),
                                                    Text(
                                                      state.jsonRequests[index]['group']['description'],
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.normal,
                                                        fontSize: 13.0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Spacer(),
                                                SizedBox(
                                                  height: 40.0,
                                                  width: 40.0,
                                                  child: FloatingActionButton(
                                                    backgroundColor: Theme.of(context).primaryColor,
                                                    onPressed: () {
                                                      print(idPatient);
                                                      BlocProvider.of<RequestsBloc>(context).add(AcceptRequestEvent(state.jsonRequests[index]['group']['_id'], idPatient, state.jsonRequests[index]['_id']));
                                                    },
                                                    child: Icon(Icons.check),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                                                  child: SizedBox(
                                                    height: 40.0,
                                                    width: 40.0,
                                                    child: FloatingActionButton(
                                                      backgroundColor: Color.fromARGB(255, 30, 61, 72),
                                                      onPressed: () {
                                                        BlocProvider.of<RequestsBloc>(context).add(DeclineRequestEvent(state.jsonRequests[index]['_id'], idPatient));
                                                      },
                                                      child: Icon(
                                                        Icons.close,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
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
                                BlocProvider.of<RequestsBloc>(context).add(LoadRequestsPatientEvent(idPatient));
                                return Center(child: CircularProgressIndicator());
                              }
                            },
                          ),
                          BlocBuilder<GroupsBloc, GroupsState>(
                            builder: (context, state) {
                              if (state is GroupsLoadedState) {
                                var listGroups = [];
                                for (int i = 0; i < state.listGroups.length; i++) {
                                  if (listGroupsRequests.contains(state.listGroups[i].name)) {
                                  } else {
                                    listGroups.add(state.listGroups[i]);
                                  }
                                }
                                if (listGroups.isEmpty) {
                                  return Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          translate('pages.groups_page.no_groups_patient'),
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
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: listGroups.length,
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
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.group,
                                                      size: 40.0,
                                                    ),
                                                    SizedBox(width: 10.0),
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          listGroups[index].name,
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 15.0,
                                                          ),
                                                        ),
                                                        Text(
                                                          listGroups[index].description,
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
                                        );
                                      }),
                                    ),
                                  );
                                }
                              }
                              if (state is NoGroupsState) {
                                return Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        translate('pages.groups_page.no_groups_patient'),
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 30, 61, 72),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      Icon(
                                        Icons.groups,
                                        size: 100.0,
                                        color: Color.fromARGB(255, 30, 61, 72),
                                      )
                                    ],
                                  ),
                                );
                              }
                              if (state is GroupsLoadingState) {
                                return Center(child: CircularProgressIndicator());
                              } else {
                                BlocProvider.of<GroupsBloc>(context).add(LoadGroupsEvent(idPatient, false));
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
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
      },
    );
  }
}
