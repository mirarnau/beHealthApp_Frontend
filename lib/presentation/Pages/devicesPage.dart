// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:medical_devices/business_logic/bloc/device/device_bloc.dart';
import 'package:medical_devices/business_logic/bloc/patient/patient_bloc.dart';
import 'package:medical_devices/data/Models/Device.dart';
import 'package:medical_devices/data/Services/patientService.dart';
import 'package:medical_devices/presentation/Widgets/alertsCard.dart';
import 'package:medical_devices/presentation/Widgets/deviceCard.dart';

class DevicesPage extends StatefulWidget {
  const DevicesPage({Key? key}) : super(key: key);

  @override
  _DevicesPageState createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> {
  List<Device> listDevices = [
    Device(
      translate('medical_devices.oximeter'),
      Image.asset('assets/images/ol_750.png'),
      'OL-750',
      true,
    ),
    Device(
      translate('medical_devices.tensiometer'),
      Image.asset('assets/images/bpm_200w.png'),
      'BPM 200W',
      false,
    ),
    Device(
      translate('medical_devices.scale'),
      Image.asset('assets/images/bl_1500.png'),
      'BL-1500',
      true,
    ),
    Device(
      translate('medical_devices.thermometer'),
      Image.asset('assets/images/it_45b.png'),
      'IT-45B',
      true,
    ),
    Device(
      translate('medical_devices.pressure_bracelet'),
      Image.asset('assets/images/bpm_100.png'),
      'BPM-100',
      true,
    ),
    Device(
      translate('medical_devices.temperature_bracelet'),
      Image.asset('assets/images/bt_125.png'),
      'BT-125',
      true,
    )
  ];

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PatientBloc, PatientState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is PatientLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return BlocConsumer<DeviceBloc, DeviceState>(
            listener: (context, state) {
              if (state is DeviceSelectedState) {
                Navigator.of(context).pushNamed('/device');
              }
            },
            builder: (context, state) {
              return Scaffold(
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0),
                        child: Center(
                            child: (Text(
                          translate('pages.measurements_page.my_devices'),
                          style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
                        ))),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25.0),
                        child: CarouselSlider(
                            items: [
                              DeviceCard(
                                nameDevice: translate('medical_devices.oximeter'),
                                photoDevice: Image.asset('assets/images/ol_750.png'),
                                modelDevice: 'OL-750',
                                connected: true,
                              ),
                              DeviceCard(
                                nameDevice: translate('medical_devices.tensiometer'),
                                photoDevice: Image.asset('assets/images/bpm_200w.png'),
                                modelDevice: 'BPM 200W',
                                connected: false,
                              ),
                              DeviceCard(
                                nameDevice: translate('medical_devices.scale'),
                                photoDevice: Image.asset('assets/images/bl_1500.png'),
                                modelDevice: 'BL-1500',
                                connected: true,
                              ),
                              DeviceCard(
                                nameDevice: translate('medical_devices.thermometer'),
                                photoDevice: Image.asset('assets/images/it_45b.png'),
                                modelDevice: 'IT-45B',
                                connected: true,
                              ),
                              DeviceCard(
                                nameDevice: translate('medical_devices.pressure_bracelet'),
                                photoDevice: Image.asset('assets/images/bpm_100.png'),
                                modelDevice: 'BPM-100',
                                connected: true,
                              ),
                              DeviceCard(
                                nameDevice: translate('medical_devices.temperature_bracelet'),
                                photoDevice: Image.asset('assets/images/bt_125.png'),
                                modelDevice: 'BT-125',
                                connected: true,
                              ),
                            ],
                            options: CarouselOptions(
                              height: 490.0,
                              enlargeCenterPage: false,
                              autoPlay: false,
                              autoPlayCurve: Curves.fastOutSlowIn,
                              scrollDirection: Axis.horizontal,
                              enableInfiniteScroll: true,
                              autoPlayAnimationDuration: Duration(milliseconds: 800),
                              viewportFraction: 0.8,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: AlertsCard(listDisconnectedDevices: getDisconnectedDevices()),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }

  List<String> getDisconnectedDevices() {
    List<String> listDisconnectedDevices = [];
    for (int i = 0; i < listDevices.length; i++) {
      if (!listDevices[i].connected) {
        listDisconnectedDevices.add(listDevices[i].modelDevice);
      }
    }
    return listDisconnectedDevices;
  }
}
