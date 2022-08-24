// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

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
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: photoDevice,
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                nameDevice,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                modelDevice,
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
