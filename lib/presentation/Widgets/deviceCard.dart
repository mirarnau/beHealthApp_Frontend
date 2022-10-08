// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:medical_devices/business_logic/bloc/device/device_bloc.dart';

class DeviceCard extends StatelessWidget {
  final String nameDevice;
  final Image photoDevice;
  final String modelDevice;

  DeviceCard({required this.nameDevice, required this.photoDevice, required this.modelDevice});

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
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: photoDevice,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      nameDevice,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    modelDevice,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Theme.of(context).primaryColor),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 30.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: TextButton(
                    style: TextButton.styleFrom(backgroundColor: Theme.of(context).primaryColor, fixedSize: Size(200.0, 40.0)),
                    onPressed: () {
                      BlocProvider.of<DeviceBloc>(context).add(SelectDeviceEvent(nameDevice));
                    },
                    child: Text(
                      translate('pages.measurements_page.measure'),
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
