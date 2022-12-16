// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:medical_devices/NavDrawers/mainDrawer.dart';
import 'package:medical_devices/business_logic/bloc/authorization/authorization_bloc.dart';
import 'package:medical_devices/presentation/Pages/devicesPage.dart';
import 'package:medical_devices/presentation/Pages/groupsManagerPage.dart';
import 'package:medical_devices/presentation/Pages/groupsPatientPage.dart';
import 'package:medical_devices/presentation/Pages/profilePage.dart';

class MainPage extends StatefulWidget {
  final int selectedIndex;
  final bool isManager;
  const MainPage({Key? key, required this.selectedIndex, required this.isManager}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late int _selectedIndex = widget.selectedIndex;

  late final screensManager = [GroupsManagerPage(), DevicesPage(), ProfilePage()];
  late final screensPatient = [GroupsPatientPage(), DevicesPage(), ProfilePage()];
  late var screens;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void initState() {
    if (widget.isManager) {
      screens = screensManager;
    } else {
      screens = screensPatient;
    }
    changeLocale(context, 'en');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthorizationBloc, AuthorizationState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).cardColor,
            title: Text(
              translate('titles.beHealthApp'),
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            ),
            actions: [IconButton(onPressed: () {}, icon: Icon(Icons.chat_bubble_rounded))],
          ),
          drawer: NavDrawer(),
          body: Center(
            child: screens.elementAt(_selectedIndex),
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.groups),
                label: translate('nav_bar.groups'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart),
                label: translate('nav_bar.devices'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: translate('nav_bar.my_health'),
              ),
            ],
            currentIndex: _selectedIndex,
            backgroundColor: Theme.of(context).backgroundColor,
            unselectedItemColor: Theme.of(context).cardColor,
            selectedItemColor: Theme.of(context).primaryColor,
            onTap: _onItemTapped,
          ),
        );
      },
    );
  }
}
