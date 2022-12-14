// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_devices/presentation/Pages/addUsersGroup.dart';
import 'package:medical_devices/presentation/Pages/createGroupPage.dart';
import 'package:medical_devices/presentation/Pages/listBluetoothPage.dart';
import 'package:medical_devices/presentation/Pages/loginPage.dart';
import 'package:medical_devices/presentation/Pages/mainPage.dart';
import 'package:medical_devices/presentation/Pages/devicesPage.dart';
import 'package:medical_devices/presentation/Pages/measurementPage.dart';
import 'package:medical_devices/presentation/Pages/registerPage.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case '/register':
        return MaterialPageRoute(builder: (_) => RegisterPage());
      case '/main':
        return MaterialPageRoute(
            builder: (_) => MainPage(
                  selectedIndex: 1,
                  isManager: true,
                ));
      case '/device':
        return MaterialPageRoute(builder: (_) => MeasurementPage());
      case '/bluetooth':
        return MaterialPageRoute(builder: (_) => ListBluetoothPage());
      case '/groups/create':
        return MaterialPageRoute(builder: (_) => CreateGroupPage());
      default:
        return null;
    }
  }
}
