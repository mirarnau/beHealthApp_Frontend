// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:medical_devices/business_logic/bloc/device/device_bloc.dart';

class DeviceCard extends StatelessWidget {
  final String nameDevice;
  final Image photoDevice;
  final String modelDevice;
  final bool connected;

  DeviceCard({required this.nameDevice, required this.photoDevice, required this.modelDevice, required this.connected});

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
                    height: 250.0,
                    width: 250.0,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: photoDevice,
                    ),
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
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      BlocBuilder<DeviceBloc, DeviceState>(
                        builder: (context, state) {
                          if (state is DeviceConnectingState) {
                            return TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: connected ? Theme.of(context).primaryColor : Colors.yellow,
                                  fixedSize: Size(200.0, 40.0),
                                ),
                                onPressed: () {
                                  if (connected) {
                                    BlocProvider.of<DeviceBloc>(context).add(SelectDeviceEvent(nameDevice));
                                  } else {
                                    BlocProvider.of<DeviceBloc>(context).add(ConnectDeviceEvent());
                                  }
                                },
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Connecting...',
                                        style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 20.0),
                                        child: SizedBox(
                                          height: 20.0,
                                          width: 20.0,
                                          child: CircularProgressIndicator(
                                            color: Colors.grey,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ));
                          } else {
                            return TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: connected ? Theme.of(context).primaryColor : Colors.grey,
                                  fixedSize: Size(200.0, 40.0),
                                ),
                                onPressed: () {
                                  if (connected) {
                                    BlocProvider.of<DeviceBloc>(context).add(SelectDeviceEvent(nameDevice));
                                  } else {
                                    BlocProvider.of<DeviceBloc>(context).add(ConnectDeviceEvent());
                                  }
                                },
                                child: Text(
                                  connected ? translate('pages.measurements_page.measure') : translate('medical_devices.connection.connect'),
                                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                                ));
                          }
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 14.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              connected ? Icons.bluetooth_connected : Icons.bluetooth_disabled,
                              color: connected ? Theme.of(context).primaryColor : Colors.red,
                            ),
                            Text(
                              connected ? translate('medical_devices.connection.connected') : translate('medical_devices.connection.disconnected'),
                              style: TextStyle(
                                color: connected ? Theme.of(context).primaryColor : Colors.red,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
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
