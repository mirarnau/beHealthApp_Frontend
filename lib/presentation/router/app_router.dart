// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_devices/presentation/Pages/mainPage.dart';
import 'package:medical_devices/presentation/Pages/devicesPage.dart';
import 'package:medical_devices/presentation/Pages/measurementPage.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => MainPage(
                  selectedIndex: 3,
                ));
      case '/device':
        return MaterialPageRoute(builder: (_) => MeasurementPage());

      default:
        return null;
    }
  }
}
