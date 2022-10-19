// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:medical_devices/business_logic/bloc/device/device_bloc.dart';

class AlertsCard extends StatelessWidget {
  final List<String> listDisconnectedDevices;
  AlertsCard({required this.listDisconnectedDevices});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 230, 230, 230),
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Text(
              translate('medical_devices.alerts.alerts'),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 40.0),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: listDisconnectedDevices.length,
              itemBuilder: ((context, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(50.0, 0.0, 0.0, 30.0),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.warning,
                          color: Colors.red,
                          size: 40.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${translate('medical_devices.alerts.device_disconnected_1')} ${listDisconnectedDevices[index]} ${translate('medical_devices.alerts.device_disconnected_2')}',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}
