// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:medical_devices/business_logic/bloc/connection/connection_bloc.dart';
import 'package:medical_devices/business_logic/bloc/device/device_bloc.dart';
import 'package:medical_devices/data/Models/User.dart';
import 'package:medical_devices/presentation/Pages/measurementsPatientGroup.dart';

class DeviceCardInfo extends StatelessWidget {
  final String nameDevice;
  final String photoDevice;
  final String modelDevice;
  final bool verified;
  final User patient;

  DeviceCardInfo({required this.nameDevice, required this.photoDevice, required this.modelDevice, required this.verified, required this.patient});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 30.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.0),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 18, 18, 18).withOpacity(0.4),
              offset: const Offset(
                0.0,
                10.0,
              ),
              blurRadius: 20.0,
              spreadRadius: -10.0,
            ),
          ],
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: 150.0,
                    width: 150.0,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Image.asset(photoDevice),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            nameDevice,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Visibility(
                          visible: verified,
                          child: Icon(
                            Icons.verified,
                            color: Colors.blue,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    modelDevice,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0, color: Theme.of(context).primaryColor),
                  ),
                  SizedBox(height: 5.0),
                  TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        fixedSize: Size(150.0, 40.0),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MeasurementsPatientGroup(
                                      selectedDevice: nameDevice,
                                      patient: patient,
                                      photoDevice: photoDevice,
                                    )));
                      },
                      child: Center(
                        child: Text(
                          'Measurements',
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
