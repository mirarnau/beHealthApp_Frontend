// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:medical_devices/business_logic/bloc/device/device_bloc.dart';
import 'package:medical_devices/data/Models/Observation.dart';

class ThermometerMeasureCard extends StatelessWidget {
  final String value;
  final String unit;
  final List<ReferenceRange> referenceRange;
  final bool measureDone;

  ThermometerMeasureCard({required this.value, required this.unit, required this.referenceRange, required this.measureDone});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: TextStyle(
                fontSize: 80.0,
                fontWeight: FontWeight.bold,
                color: anomalyDetected() == 0
                    ? Colors.black
                    : anomalyDetected() == 1
                        ? Colors.red
                        : Colors.blue),
          ),
          SizedBox(
            width: 10.0,
          ),
          Text(
            unit == "degrees C" ? 'ºC' : unit,
            style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  int anomalyDetected() {
    if (measureDone) {
      var highReferenceValue = referenceRange[0].high.value;
      var lowReferenceValue = referenceRange[referenceRange.length - 1].low.value; //The length -1 will always be the last postion, and never null.

      if (double.parse(value) > highReferenceValue) {
        return 1;
      }
      if (double.parse(value) < lowReferenceValue) {
        return 2;
      }
      return 0;
    } else {
      return 0;
    }
  }
}
