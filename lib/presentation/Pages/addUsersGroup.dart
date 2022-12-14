// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:medical_devices/data/Models/User.dart';
import 'package:medical_devices/data/Services/userService.dart';

class AddUsersGroupPage extends StatefulWidget {
  final Function selectUsers;
  final List<String> listIdUsersAdded;
  const AddUsersGroupPage({Key? key, required this.selectUsers, required this.listIdUsersAdded}) : super(key: key);

  @override
  _AddUsersGroupPageState createState() => _AddUsersGroupPageState();
}

class _AddUsersGroupPageState extends State<AddUsersGroupPage> {
  late List<User> listUsersMatch;
  late UserService userService = UserService();

  void initState() {
    listUsersMatch = [];
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
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
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.chat_bubble_rounded)),
        ],
      ),
      body: Center(
        child: Stack(
          children: [
            FloatingSearchBar(
              queryStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 16.0),
              iconColor: Colors.white,
              hint: translate('pages.groups_page.search_users'),
              hintStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 16.0),
              scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
              transitionDuration: const Duration(milliseconds: 300),
              transitionCurve: Curves.easeInOut,
              physics: const BouncingScrollPhysics(),
              axisAlignment: isPortrait ? 0.0 : -1.0,
              openAxisAlignment: 0.0,
              width: isPortrait ? 600 : 500,
              debounceDelay: const Duration(milliseconds: 500),
              onQueryChanged: (query) async {
                // Call your model, bloc, controller here.
                if (query == "") {
                  query = "all";
                }
                listUsersMatch = await userService.filterUser(query);
                setState(() {});
              },
              transition: CircularFloatingSearchBarTransition(),
              actions: [
                FloatingSearchBarAction.searchToClear(
                  showIfClosed: false,
                ),
              ],
              builder: (context, transition) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Material(
                    color: Colors.white,
                    elevation: 4.0,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: listUsersMatch.map((user) {
                        return SizedBox(
                          height: 112,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                                child: SizedBox(
                                  height: 60.0,
                                  width: 60.0,
                                  child: Image.network(user.imageUrl),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      user.fullName,
                                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16.0),
                                    ),
                                    Text(
                                      user.email,
                                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal, fontSize: 16.0),
                                    )
                                  ],
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                                child: SizedBox(
                                  height: 55.0,
                                  width: 55.0,
                                  child: FloatingActionButton(
                                    heroTag: user.apiId,
                                    backgroundColor: widget.listIdUsersAdded.contains(user.apiId) ? Theme.of(context).primaryColor : Color.fromARGB(255, 30, 61, 72),
                                    onPressed: () {
                                      if (widget.listIdUsersAdded.contains(user.apiId)) {
                                        widget.listIdUsersAdded.remove(user.apiId);
                                      } else {
                                        widget.listIdUsersAdded.add(user.apiId);
                                      }
                                      setState(() {});
                                    },
                                    child: Icon(
                                      widget.listIdUsersAdded.contains(user.apiId) ? Icons.check : Icons.person_add,
                                      size: 26,
                                      color: widget.listIdUsersAdded.contains(user.apiId) ? Colors.black : Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 60.0),
                child: RaisedButton(
                  elevation: 5.0,
                  onPressed: () {
                    widget.selectUsers(widget.listIdUsersAdded);
                    Navigator.pop(context);
                  },
                  padding: EdgeInsets.all(15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  color: Color.fromARGB(255, 5, 232, 185),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        translate('pages.groups_page.confirm_users'),
                        style: TextStyle(
                          color: Color.fromARGB(255, 33, 40, 48),
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
