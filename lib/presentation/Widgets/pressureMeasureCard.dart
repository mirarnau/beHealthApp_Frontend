// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:medical_devices/business_logic/bloc/device/device_bloc.dart';

class PressureMeasureCard extends StatelessWidget {
  final String sistolicValue;
  final String diastolicValue;
  final String sistolicUnit;
  final String diastolicUnit;

  PressureMeasureCard({required this.sistolicValue, required this.diastolicValue, required this.sistolicUnit, required this.diastolicUnit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: Column(
                children: [
                  Text(
                    'Sistolic',
                    style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.red),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 8.0, 8.0, 0.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text(
                            sistolicValue,
                            style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          sistolicUnit,
                          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 40.0),
              child: Column(
                children: [
                  Text(
                    'Diastolic',
                    style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 8.0, 8.0, 0.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text(
                            diastolicValue,
                            style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          diastolicUnit,
                          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
