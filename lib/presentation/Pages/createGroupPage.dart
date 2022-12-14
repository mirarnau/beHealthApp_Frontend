// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:medical_devices/business_logic/bloc/authorization/authorization_bloc.dart';
import 'package:medical_devices/business_logic/bloc/groups/groups_bloc.dart';
import 'package:medical_devices/business_logic/bloc/requests/requests_bloc.dart';
import 'package:medical_devices/data/Models/Group.dart';
import 'package:medical_devices/data/Models/User.dart';
import 'package:medical_devices/presentation/Pages/addUsersGroup.dart';
import 'package:medical_devices/presentation/Pages/utilities/constants.dart';

class CreateGroupPage extends StatefulWidget {
  const CreateGroupPage({Key? key}) : super(key: key);

  @override
  _CreateGroupPageState createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends State<CreateGroupPage> {
  final nameGroupController = TextEditingController();
  final descriptionGroupController = TextEditingController();
  late List<String> listIdUsersAdded;

  void initState() {
    listIdUsersAdded = [];
    super.initState();
  }

  @override
  void dispose() {
    nameGroupController.dispose();
    descriptionGroupController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthorizationBloc, AuthorizationState>(
      builder: (context, state) {
        if (state is AuthorizedState) {
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
            body: Center(
              child: Column(
                children: [
                  SizedBox(height: 40.0),
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: FittedBox(
                      child: FloatingActionButton(
                        backgroundColor: Colors.white,
                        onPressed: () {},
                        child: Icon(
                          Icons.add_a_photo,
                          size: 35,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 14.0),
                  Text(
                    translate('pages.groups_page.add_group_photo'),
                    style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: 15.0),
                  ),
                  SizedBox(height: 20.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 10.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          decoration: createGroupDecorationStyle,
                          height: 60.0,
                          child: TextField(
                            controller: nameGroupController,
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'OpenSans',
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(top: 14.0),
                              prefixIcon: Icon(
                                Icons.group,
                                color: Colors.black,
                              ),
                              hintText: translate('pages.groups_page.name_group'),
                              hintStyle: TextStyle(color: Colors.black, fontFamily: 'OpenSans'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 10.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          decoration: createGroupDecorationStyle,
                          height: 60.0,
                          child: TextField(
                            controller: descriptionGroupController,
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'OpenSans',
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(top: 14.0),
                              prefixIcon: Icon(
                                Icons.description,
                                color: Colors.black,
                              ),
                              hintText: translate('pages.groups_page.description_group'),
                              hintStyle: TextStyle(color: Colors.black, fontFamily: 'OpenSans'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.0),
                  Text(
                    '${listIdUsersAdded.length} ${translate('pages.groups_page.users_added')}',
                    style: TextStyle(
                      color: Color.fromARGB(255, 30, 61, 72),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  SizedBox(
                    child: RaisedButton(
                      elevation: 5.0,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AddUsersGroupPage(selectUsers: selectUsers, listIdUsersAdded: listIdUsersAdded)));
                      },
                      padding: EdgeInsets.all(15.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      color: Color.fromARGB(255, 30, 61, 72),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person_add,
                            color: Colors.white,
                          ),
                          SizedBox(width: 6.0),
                          Text(
                            translate('pages.groups_page.add_users'),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 30.0),
                    child: Text(
                      translate('pages.groups_page.description'),
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontWeight: FontWeight.normal),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 60.0),
                    child: BlocConsumer<GroupsBloc, GroupsState>(
                      listener: (context, stateGroups) {
                        if (stateGroups is GroupCreatedState) {
                          List<GroupRequestGenerated> listRequests = [];
                          for (int i = 0; i < stateGroups.group.patients.length; i++) {
                            GroupRequestGenerated groupRequest = GroupRequestGenerated();
                            groupRequest.groupId = stateGroups.group.id;
                            groupRequest.patientId = stateGroups.group.patients[i].apiId;
                            listRequests.add(groupRequest);
                          }
                          BlocProvider.of<RequestsBloc>(context).add(GenerateRequestEvent(listRequests));
                          Navigator.pop(context);
                        }
                      },
                      builder: (context, stateGroups) {
                        if (stateGroups is GroupsLoadingState) {
                          return RaisedButton(
                            elevation: 5.0,
                            onPressed: () {},
                            padding: EdgeInsets.all(15.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            color: Theme.of(context).primaryColor,
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return RaisedButton(
                            elevation: 5.0,
                            onPressed: () {
                              if (nameGroupController.text.isNotEmpty && descriptionGroupController.text.isNotEmpty && listIdUsersAdded.isNotEmpty) {
                                Group newGroup = Group();
                                newGroup.name = nameGroupController.text;
                                newGroup.description = descriptionGroupController.text;
                                newGroup.manager = state.user;
                                newGroup.patients = [];
                                for (int i = 0; i < listIdUsersAdded.length; i++) {
                                  User user = User();
                                  user.apiId = listIdUsersAdded[i];
                                  newGroup.patients.add(user);
                                }
                                newGroup.requests = [];
                                BlocProvider.of<GroupsBloc>(context).add(AddGroupEvent(newGroup));
                              }
                            },
                            padding: EdgeInsets.all(15.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            color: Theme.of(context).primaryColor,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(width: 6.0),
                                Text(
                                  translate('pages.groups_page.confirm'),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Center(
            child: Text('Unauthorized'),
          );
        }
      },
    );
  }

  void selectUsers(List<String> listIdUsersSelected) {
    listIdUsersAdded = listIdUsersSelected;
    setState(() {});
  }
}
