// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:medical_devices/NavDrawers/mainDrawer.dart';
import 'package:medical_devices/presentation/Pages/measurementsPage.dart';

class MainPage extends StatefulWidget {
  final int selectedIndex;
  const MainPage({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late int _selectedIndex = widget.selectedIndex;

  late final screens = [Text(translate('nav_bar.appointments')), Text(translate('nav_bar.telemedicine')), Text(translate('nav_bar.new_appointment')), MeasurementsPage(), Text(translate('nav_bar.my_health'))];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void initState() {
    changeLocale(context, 'en');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            icon: Icon(Icons.calendar_month),
            label: translate('nav_bar.appointments'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.phone_iphone),
            label: translate('nav_bar.telemedicine'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: translate('nav_bar.new_appointment'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: translate('nav_bar.measurements'),
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
  }
}
