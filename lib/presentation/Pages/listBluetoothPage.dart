// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:medical_devices/business_logic/bloc/authorization/authorization_bloc.dart';
import 'package:medical_devices/business_logic/bloc/connection/connection_bloc.dart';
import 'package:medical_devices/data/Models/Device.dart';

List<Device> dataReceived = [
  Device(
    "Toni's Apple Watch",
    'assets/images/apple_watch.png',
    'Apple Watch Series 8',
    false,
    false,
    false,
  ),
  Device(
    "Samsung Watch Toni",
    'assets/images/samsung_watch.png',
    'Samsung Smart Watch 5 ',
    false,
    false,
    false,
  ),
  Device(
    translate('medical_devices.oximeter'),
    'assets/images/ol_750.png',
    'OL-750',
    false,
    false,
    true,
  ),
  Device(
    translate('medical_devices.tensiometer'),
    'assets/images/bpm_200w.png',
    'BPM 200W',
    false,
    false,
    true,
  ),
  Device(
    translate('medical_devices.scale'),
    'assets/images/bl_1500.png',
    'BL-1500',
    false,
    false,
    true,
  ),
  Device(
    translate('medical_devices.thermometer'),
    'assets/images/it_45b.png',
    'IT-45B',
    false,
    false,
    true,
  ),
  Device(
    translate('medical_devices.pressure_bracelet'),
    'assets/images/bpm_100.png',
    'BPM-100',
    false,
    false,
    true,
  ),
  Device(
    translate('medical_devices.temperature_bracelet'),
    'assets/images/bt_125.png',
    'BT-125',
    false,
    false,
    true,
  ),
];

class ListBluetoothPage extends StatefulWidget {
  const ListBluetoothPage({Key? key}) : super(key: key);

  @override
  _ListBluetoothPageState createState() => _ListBluetoothPageState();
}

class _ListBluetoothPageState extends State<ListBluetoothPage> {
  bool infoVisible = false;
  String clickedName = "";
  String clickedModel = "";
  bool clickedLinked = false;
  String selectedDeviceName = "";
  List<Device> listDevicesBluetooth = [
    Device(
      "Toni's Apple Watch",
      'assets/images/apple_watch.png',
      'Apple Watch Series 8',
      false,
      false,
      false,
    ),
    Device(
      "Samsung Watch Toni",
      'assets/images/samsung_watch.png',
      'Samsung Smart Watch 5 ',
      false,
      false,
      false,
    ),
    Device(
      translate('medical_devices.oximeter'),
      'assets/images/ol_750.png',
      'OL-750',
      false,
      false,
      true,
    ),
    Device(
      translate('medical_devices.tensiometer'),
      'assets/images/bpm_200w.png',
      'BPM 200W',
      false,
      false,
      true,
    ),
    Device(
      translate('medical_devices.scale'),
      'assets/images/bl_1500.png',
      'BL-1500',
      false,
      false,
      true,
    ),
    Device(
      translate('medical_devices.thermometer'),
      'assets/images/it_45b.png',
      'IT-45B',
      false,
      false,
      true,
    ),
    Device(
      translate('medical_devices.pressure_bracelet'),
      'assets/images/bpm_100.png',
      'BPM-100',
      false,
      false,
      true,
    ),
    Device(
      translate('medical_devices.temperature_bracelet'),
      'assets/images/bt_125.png',
      'BT-125',
      false,
      false,
      true,
    ),
  ];

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Color.fromARGB(255, 255, 255, 255)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Theme.of(context).cardColor,
        title: Text(
          translate('titles.beHealthApp'),
          style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.chat_bubble_rounded))],
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 30, 61, 72),
                    Color.fromARGB(255, 30, 61, 72),
                    Color.fromARGB(222, 30, 61, 72),
                    Color.fromARGB(255, 5, 232, 185),
                  ],
                  stops: [0.1, 0.4, 0.7, 0.9],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: BlocBuilder<ConnectionBloc, ConnectionOwnState>(
                  builder: (context, state) {
                    if (state is LinkedDevicesLoadedState) {
                      List<Device> updatedDevicesList = [];
                      for (int i = 0; i < state.linkedDevices.length; i++) {
                        updatedDevicesList.add(state.linkedDevices[i]);
                        for (int k = 0; k < listDevicesBluetooth.length; k++) {
                          if (listDevicesBluetooth[k].modelDevice == state.linkedDevices[i].modelDevice) {
                            listDevicesBluetooth.remove(listDevicesBluetooth[k]);
                          }
                        }
                      }
                      updatedDevicesList = List.from(updatedDevicesList)..addAll(listDevicesBluetooth);
                      for (int i = 0; i < updatedDevicesList.length; i++) {}
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: updatedDevicesList.length,
                        itemBuilder: ((context, index) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (selectedDeviceName != updatedDevicesList[index].nameDevice) {
                                    selectedDeviceName = updatedDevicesList[index].nameDevice;
                                  } else {
                                    selectedDeviceName = '';
                                  }
                                });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(34, 255, 255, 255),
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 6.0,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(20.0, 14.0, 20.0, 14.0),
                                          child: Icon(
                                            updatedDevicesList[index].added ? Icons.check : Icons.wifi,
                                            color: updatedDevicesList[index].added ? Colors.blue : Theme.of(context).primaryColor,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 20.0),
                                          child: Text(
                                            updatedDevicesList[index].nameDevice,
                                            style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Spacer(),
                                        Visibility(
                                          visible: updatedDevicesList[index].verified,
                                          child: Padding(
                                            padding: const EdgeInsets.only(right: 5.0),
                                            child: Icon(
                                              Icons.verified,
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              infoVisible = true;
                                              clickedName = updatedDevicesList[index].nameDevice;
                                              clickedModel = updatedDevicesList[index].modelDevice;
                                              clickedLinked = updatedDevicesList[index].added;
                                            });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(right: 20.0),
                                            child: Icon(
                                              Icons.info_outline,
                                              color: Colors.blue,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Visibility(
                                      visible: selectedDeviceName == updatedDevicesList[index].nameDevice,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(85.0, 0.0, 0.0, 10.0),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 90.0,
                                              child: Center(
                                                child: BlocBuilder<AuthorizationBloc, AuthorizationState>(
                                                  builder: (context, state) {
                                                    if (state is AuthorizedState) {
                                                      return decideWidget(updatedDevicesList[index].added, state, updatedDevicesList[index]);
                                                    } else {
                                                      return Center(child: Text('Unauthorized', style: TextStyle(color: Colors.white)));
                                                    }
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              )),
          Visibility(
            visible: infoVisible,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color.fromARGB(111, 5, 232, 187)),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Color.fromARGB(255, 30, 61, 72),
                ),
                width: 300.0,
                height: 230.0,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text(
                        'INFO',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 6.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                            text: translate('pages.manage_devices.name'),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          TextSpan(
                              text: clickedName,
                              style: TextStyle(
                                fontSize: 16.0,
                              )),
                        ])),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: translate('pages.manage_devices.model'),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              )),
                          TextSpan(
                              text: clickedModel,
                              style: TextStyle(
                                fontSize: 16.0,
                              )),
                        ])),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 14.0, 0.0, 0.0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Icon(
                                Icons.circle,
                                color: clickedLinked ? Theme.of(context).primaryColor : Colors.grey,
                                size: 16.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  clickedLinked ? translate('pages.manage_devices.linked') : translate('pages.manage_devices.not_linked'),
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: clickedLinked ? Theme.of(context).primaryColor : Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            fixedSize: Size(100.0, 40.0),
                          ),
                          onPressed: () {
                            setState(() {
                              infoVisible = false;
                            });
                          },
                          child: Center(
                            child: Text(
                              translate('pages.manage_devices.close'),
                              style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          )),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget decideWidget(bool linked, AuthorizedState authorizedState, Device device) {
    if (linked) {
      return GestureDetector(
        onTap: () {
          selectedDeviceName = "";
          listDevicesBluetooth = [
            Device(
              "Toni's Apple Watch",
              'assets/images/apple_watch.png',
              'Apple Watch Series 8',
              false,
              false,
              false,
            ),
            Device(
              "Samsung Watch Toni",
              'assets/images/samsung_watch.png',
              'Samsung Smart Watch 5 ',
              false,
              false,
              false,
            ),
            Device(
              translate('medical_devices.oximeter'),
              'assets/images/ol_750.png',
              'OL-750',
              false,
              false,
              true,
            ),
            Device(
              translate('medical_devices.tensiometer'),
              'assets/images/bpm_200w.png',
              'BPM 200W',
              false,
              false,
              true,
            ),
            Device(
              translate('medical_devices.scale'),
              'assets/images/bl_1500.png',
              'BL-1500',
              false,
              false,
              true,
            ),
            Device(
              translate('medical_devices.thermometer'),
              'assets/images/it_45b.png',
              'IT-45B',
              false,
              false,
              true,
            ),
            Device(
              translate('medical_devices.pressure_bracelet'),
              'assets/images/bpm_100.png',
              'BPM-100',
              false,
              false,
              true,
            ),
            Device(
              translate('medical_devices.temperature_bracelet'),
              'assets/images/bt_125.png',
              'BT-125',
              false,
              false,
              true,
            ),
          ];
          BlocProvider.of<ConnectionBloc>(context).add(UnlinkDeviceEvent(authorizedState.user.apiId, device));
        },
        child: Row(
          children: [
            Icon(
              Icons.link_off,
              color: Colors.blue,
            ),
            SizedBox(
              width: 8.0,
            ),
            Text(
              'Unlink',
              style: TextStyle(color: Colors.blue, fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {
          selectedDeviceName = "";
          listDevicesBluetooth = [
            Device(
              "Toni's Apple Watch",
              'assets/images/apple_watch.png',
              'Apple Watch Series 8',
              false,
              false,
              false,
            ),
            Device(
              "Samsung Watch Toni",
              'assets/images/samsung_watch.png',
              'Samsung Smart Watch 5 ',
              false,
              false,
              false,
            ),
            Device(
              translate('medical_devices.oximeter'),
              'assets/images/ol_750.png',
              'OL-750',
              false,
              false,
              true,
            ),
            Device(
              translate('medical_devices.tensiometer'),
              'assets/images/bpm_200w.png',
              'BPM 200W',
              false,
              false,
              true,
            ),
            Device(
              translate('medical_devices.scale'),
              'assets/images/bl_1500.png',
              'BL-1500',
              false,
              false,
              true,
            ),
            Device(
              translate('medical_devices.thermometer'),
              'assets/images/it_45b.png',
              'IT-45B',
              false,
              false,
              true,
            ),
            Device(
              translate('medical_devices.pressure_bracelet'),
              'assets/images/bpm_100.png',
              'BPM-100',
              false,
              false,
              true,
            ),
            Device(
              translate('medical_devices.temperature_bracelet'),
              'assets/images/bt_125.png',
              'BT-125',
              false,
              false,
              true,
            ),
          ];
          BlocProvider.of<ConnectionBloc>(context).add(LinkDeviceEvent(authorizedState.user.apiId, device));
        },
        child: Row(
          children: [
            Icon(
              Icons.link,
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(
              width: 8.0,
            ),
            Text(
              'Link',
              style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
    }
  }
}
