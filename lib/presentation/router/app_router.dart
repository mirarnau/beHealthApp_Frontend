// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_devices/presentation/Pages/mainPage.dart';
import 'package:medical_devices/presentation/Pages/measurementsPage.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => MainPage(
                  selectedIndex: 0,
                ));
      default:
        return null;
    }
  }
}
