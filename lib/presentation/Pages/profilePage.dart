// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:medical_devices/business_logic/bloc/authorization/authorization_bloc.dart';
import 'package:medical_devices/business_logic/bloc/historical/historical_bloc.dart';
import 'package:medical_devices/data/Models/Observation.dart';
import 'package:medical_devices/data/Models/User.dart';
import 'package:medical_devices/data/Services/deviceService.dart';
import 'package:medical_devices/presentation/Pages/historicalMeasuresPage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthorizationBloc, AuthorizationState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is AuthorizedState) {
          return Container();
        } else {
          return Center(
            child: Text('Unauthorized'),
          );
        }
      },
    );
  }
}
