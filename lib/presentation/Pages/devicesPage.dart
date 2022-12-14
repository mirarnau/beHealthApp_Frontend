// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:medical_devices/business_logic/bloc/authorization/authorization_bloc.dart';
import 'package:medical_devices/business_logic/bloc/connection/connection_bloc.dart';
import 'package:medical_devices/business_logic/bloc/device/device_bloc.dart';
import 'package:medical_devices/business_logic/bloc/patient/patient_bloc.dart';
import 'package:medical_devices/data/Models/Device.dart';
import 'package:medical_devices/presentation/Widgets/alertsCard.dart';
import 'package:medical_devices/presentation/Widgets/deviceCard.dart';

class DevicesPage extends StatefulWidget {
  const DevicesPage({Key? key}) : super(key: key);

  @override
  _DevicesPageState createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthorizationBloc, AuthorizationState>(
      builder: (context, state) {
        if (state is AuthorizedState) {
          BlocProvider.of<ConnectionBloc>(context).add(LoadLinkedDevicesEvent(state.user.apiId));
        }
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
                    body: BlocBuilder<ConnectionBloc, ConnectionOwnState>(
                      builder: (context, state) {
                        if (state is LinkedDevicesLoadedState) {
                          return SingleChildScrollView(
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
                                Padding(padding: const EdgeInsets.only(top: 25.0), child: decideWidget(state)),
                                TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: Color.fromARGB(255, 30, 61, 72),
                                      fixedSize: Size(220.0, 40.0),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pushNamed('/bluetooth');
                                    },
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            translate('pages.measurements_page.manage_devices'),
                                            style: TextStyle(color: Color.fromARGB(255, 238, 238, 238), fontSize: 18, fontWeight: FontWeight.bold),
                                          ),
                                          Icon(
                                            Icons.wifi,
                                            color: Color.fromARGB(255, 238, 238, 238),
                                          )
                                        ],
                                      ),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child: AlertsCard(listDisconnectedDevices: getDisconnectedDevices(state.linkedDevices)),
                                )
                              ],
                            ),
                          );
                        } else {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Connecting device',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(100.0, 10.0, 100.0, 0.0),
                                child: LinearProgressIndicator(
                                  color: Theme.of(context).primaryColor,
                                  backgroundColor: Color.fromARGB(255, 30, 61, 72),
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  );
                },
              );
            }
          },
        );
      },
    );
  }

  Widget decideWidget(LinkedDevicesLoadedState state) {
    if (state.linkedDevices.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 40.0),
        child: Center(
          child: Column(
            children: [
              Icon(
                Icons.devices_other,
                color: Color.fromARGB(255, 30, 61, 72),
                size: 100.0,
              ),
              Text(
                "You don't have any device yet",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Color.fromARGB(255, 30, 61, 72),
                ),
              ),
            ],
          ),
        ),
      );
    }
    List<DeviceCard> listCards = [];
    for (int i = 0; i < state.linkedDevices.length; i++) {
      listCards.add(DeviceCard(
        nameDevice: state.linkedDevices[i].nameDevice,
        photoDevice: state.linkedDevices[i].photoDevice,
        modelDevice: state.linkedDevices[i].modelDevice,
        connected: state.linkedDevices[i].connected,
        verified: state.linkedDevices[i].verified,
      ));
    }
    return CarouselSlider(
        items: listCards,
        options: CarouselOptions(
          height: 490.0,
          enlargeCenterPage: false,
          autoPlay: false,
          autoPlayCurve: Curves.fastOutSlowIn,
          scrollDirection: Axis.horizontal,
          enableInfiniteScroll: false,
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          viewportFraction: 0.8,
        ));
  }

  List<String> getDisconnectedDevices(List<Device> devices) {
    List<String> listDisconnectedDevices = [];
    for (int i = 0; i < devices.length; i++) {
      if (!devices[i].connected) {
        listDisconnectedDevices.add(devices[i].modelDevice);
      }
    }
    return listDisconnectedDevices;
  }
}
