// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:medical_devices/business_logic/bloc/authorization/authorization_bloc.dart';
import 'package:medical_devices/business_logic/bloc/groups/groups_bloc.dart';
import 'package:medical_devices/presentation/Pages/groupPageManager.dart';

class GroupsManagerPage extends StatefulWidget {
  const GroupsManagerPage({Key? key}) : super(key: key);

  @override
  _GroupsManagerPageState createState() => _GroupsManagerPageState();
}

class _GroupsManagerPageState extends State<GroupsManagerPage> {
  String idManager = "";
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<GroupsBloc>(context).add(GoToIdleEvent());
    return Scaffold(
      body: BlocConsumer<AuthorizationBloc, AuthorizationState>(
        listener: (context, stateAuth) {},
        builder: (context, stateAuth) {
          if (stateAuth is AuthorizedState) {
            idManager = stateAuth.user.apiId;
          }
          return BlocBuilder<GroupsBloc, GroupsState>(
            builder: (context, state) {
              if (state is GroupsLoadedState) {
                return Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.listGroups.length,
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => GroupPageManager(group: state.listGroups[index])));
                          },
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
                                        state.listGroups[index].name,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                      Text(
                                        state.listGroups[index].description,
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
              if (state is NoGroupsState) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        translate('pages.groups_page.no_groups_manager'),
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
                BlocProvider.of<GroupsBloc>(context).add(LoadGroupsEvent(idManager, true));
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Theme.of(context).cardColor,
        onPressed: () {
          Navigator.of(context).pushNamed('/groups/create');
        },
        label: Row(
          children: [
            Icon(Icons.group_add),
            SizedBox(width: 10.0),
            Text(
              translate('pages.groups_page.create_group'),
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
