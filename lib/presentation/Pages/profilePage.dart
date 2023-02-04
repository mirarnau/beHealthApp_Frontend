// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_devices/business_logic/bloc/authorization/authorization_bloc.dart';
import 'package:medical_devices/data/Models/Observation.dart';
import 'package:medical_devices/data/Services/userService.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<AnomalyReport> listAnomalyReports = [];
  bool checkDone = false;
  List<Widget> listWidgetsCarroussel = [];

  UserService userService = UserService();
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthorizationBloc, AuthorizationState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is AuthorizedState) {
          if (!checkDone) {
            getAnomalies(state.user.apiId);
          }
          return Scaffold(
            body: SingleChildScrollView(
              child: Center(
                child: Stack(
                  children: [
                    Container(
                      height: 320.0,
                      width: MediaQuery.of(context).size.width,
                      color: Color.fromARGB(255, 30, 61, 72),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 60.0,
                              backgroundImage: NetworkImage(state.user.imageUrl),
                            ),
                            SizedBox(height: 12.0),
                            Text(
                              state.user.fullName,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 22.0,
                              ),
                            ),
                            Text(
                              state.user.email,
                              style: TextStyle(
                                color: Color.fromARGB(255, 215, 215, 215),
                                fontWeight: FontWeight.normal,
                                fontSize: 16.0,
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Visibility(
                              visible: state.user.role.contains('MANAGER'),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.yellow,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Text(
                                    'MANAGER',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: !state.user.role.contains('MANAGER'),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 33, 205, 243),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Text(
                                    'PATIENT',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 280.0),
                        child: Container(
                          height: 80,
                          width: 140.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(20),
                            color: Theme.of(context).primaryColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0, 2),
                                blurRadius: 6.0,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.directions_walk,
                                size: 34.0,
                              ),
                              SizedBox(width: 6.0),
                              Text(
                                state.user.todayFootsteps.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 400.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Container(
                              height: 140,
                              width: 180.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(0, 2),
                                    blurRadius: 6.0,
                                  ),
                                ],
                              ),
                              child: CarouselSlider(
                                  items: getWidgetsAnomalies(),
                                  options: CarouselOptions(
                                    enlargeCenterPage: false,
                                    autoPlay: false,
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    scrollDirection: Axis.horizontal,
                                    enableInfiniteScroll: false,
                                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                                    viewportFraction: 1,
                                  )),
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Container(
                              height: 140,
                              width: 180.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(0, 2),
                                    blurRadius: 6.0,
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  SizedBox(height: 20.0),
                                  Icon(
                                    Icons.flag,
                                    color: Color.fromARGB(255, 30, 61, 72),
                                    size: 40.0,
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    (state.user.todayFootsteps + 793).toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22.0,
                                    ),
                                  ),
                                  SizedBox(height: 4.0),
                                  Text(
                                    'Average daily footsteps',
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14.0,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 570.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Container(
                              height: 140,
                              width: 180.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(0, 2),
                                    blurRadius: 6.0,
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  SizedBox(height: 20.0),
                                  Icon(
                                    Icons.settings,
                                    color: Color.fromARGB(255, 30, 61, 72),
                                    size: 40.0,
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    'Settings',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22.0,
                                    ),
                                  ),
                                  SizedBox(height: 4.0),
                                  Text(
                                    'Update personal data',
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14.0,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Container(
                              height: 140,
                              width: 180.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(0, 2),
                                    blurRadius: 6.0,
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  SizedBox(height: 32.0),
                                  Icon(
                                    Icons.logout,
                                    color: Color.fromARGB(255, 30, 61, 72),
                                    size: 40.0,
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    'Logout',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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

  void getAnomalies(String id) async {
    var response = await userService.getAnomaliesPatient(id);
    if (response != null) {
      setState(() {
        checkDone = true;
        listAnomalyReports = response;
      });
    }
  }

  List<Widget> getWidgetsAnomalies() {
    List<Widget> listWidgets = [];
    listWidgets.add(
      Column(
        children: [
          SizedBox(height: 14.0),
          Icon(
            Icons.heart_broken,
            color: Color.fromARGB(255, 30, 61, 72),
            size: 40.0,
          ),
          SizedBox(height: 2.0),
          Text(
            listAnomalyReports.length.toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22.0,
            ),
          ),
          SizedBox(height: 2.0),
          Text(
            'Potential anomalies',
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 14.0,
            ),
          ),
          SizedBox(height: 4.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('SWIPE'),
              Icon(
                Icons.swipe_left,
              )
            ],
          )
        ],
      ),
    );
    for (int i = 0; i < listAnomalyReports.length; i++) {
      listWidgets.add(
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    listAnomalyReports[i].result == 1 ? Icons.arrow_downward : Icons.arrow_upward,
                    color: listAnomalyReports[i].result == 1 ? Colors.blue : Colors.red,
                    size: 30.0,
                  ),
                  Text(
                    listAnomalyReports[i].value.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 34.0,
                      color: listAnomalyReports[i].result == 1 ? Colors.blue : Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 6.0),
            Text(
              listAnomalyReports[i].codingDisplay,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: listAnomalyReports[i].result == 1 ? Colors.blue : Colors.red,
                fontSize: 13.0,
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              listAnomalyReports[i].date,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 13.0,
              ),
            )
          ],
        ),
      );
    }
    return listWidgets;
  }
}
