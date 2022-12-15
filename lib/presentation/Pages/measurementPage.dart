// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:medical_devices/business_logic/bloc/authorization/authorization_bloc.dart';
import 'package:medical_devices/business_logic/bloc/device/device_bloc.dart';
import 'package:medical_devices/business_logic/bloc/historical/historical_bloc.dart';
import 'package:medical_devices/business_logic/bloc/patient/patient_bloc.dart';
import 'package:medical_devices/data/Models/Observation.dart';
import 'package:medical_devices/data/Services/deviceService.dart';
import 'package:medical_devices/data/Services/userService.dart';
import 'package:medical_devices/presentation/Pages/historicalMeasuresPage.dart';
import 'package:medical_devices/presentation/Widgets/deviceCard.dart';
import 'package:medical_devices/presentation/Widgets/pressureMeasureCard.dart';
import 'package:medical_devices/presentation/Widgets/thermometerMeasureCard.dart';
import 'package:medical_devices/presentation/Widgets/weightMeasureCard.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'dart:math';

class MeasurementPage extends StatefulWidget {
  const MeasurementPage({Key? key}) : super(key: key);

  @override
  _MeasurementPageState createState() => _MeasurementPageState();
}

class _MeasurementPageState extends State<MeasurementPage> {
  late String nameDevice;
  late String idObservation;
  late String idPatient;
  late num value;
  late num value2;
  late String observationType;

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthorizationBloc, AuthorizationState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is AuthorizedState) {
          //idPatient = state.user.id;
          idPatient = '52';
          print(state.user.id);
        }
        return BlocConsumer<DeviceBloc, DeviceState>(
          listener: (context, state) {
            if (state is DeviceIdleState) {
              Navigator.of(context).pop();
            }
          },
          builder: (context, state) {
            if (state is DeviceSelectedState) {
              nameDevice = state.nameDevice;
            }
            if (state is DeviceMeasureDoneState) {
              nameDevice = state.nameDevice;
            }

            return Center(
              child: Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back_ios, color: Color.fromARGB(255, 255, 255, 255)),
                    onPressed: () {
                      BlocProvider.of<DeviceBloc>(context).add(DeSelectDeviceEvent());
                    },
                  ),
                  backgroundColor: Theme.of(context).cardColor,
                  title: Text(
                    translate('titles.beHealthApp'),
                    style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                  ),
                  actions: [IconButton(onPressed: () {}, icon: Icon(Icons.chat_bubble_rounded))],
                ),
                body: Stack(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0.0, 80.0, 0.0, 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: Theme.of(context).primaryColor,
                                  size: 30.0,
                                ),
                                onTap: () {
                                  BlocProvider.of<DeviceBloc>(context).add(DeSelectDeviceEvent());
                                },
                              ),
                              SizedBox(width: 3.0),
                              Text(
                                nameDevice,
                                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        getWidget(state, context),
                        Visibility(
                          visible: state is DeviceMeasureDoneState || state is DeviceSelectedState,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: TextButton(
                              style: TextButton.styleFrom(backgroundColor: Theme.of(context).primaryColor, fixedSize: Size(200.0, 40.0)),
                              onPressed: () {
                                BlocProvider.of<DeviceBloc>(context).add(DeviceDoMeasureEvent(idPatient, value, value2, nameDevice, observationType));
                              },
                              child: Text(
                                translate('pages.measurements_page.measure'),
                                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SlidingUpPanel(
                      maxHeight: 820.0,
                      renderPanelSheet: false,
                      panel: _floatingPanel(idPatient, context),
                      collapsed: _floatingCollapsed(context),
                      backdropEnabled: true,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget getWidget(DeviceState state, BuildContext c) {
    if (state is DeviceMeasureDoneState) {
      if (nameDevice == "Scale") {
        return WeightMeasureCard(
          value: state.observation.valueQuantity.value.toString(),
          unit: state.observation.valueQuantity.unit,
        );
      }
      if (nameDevice == "Pressure bracelet") {
        return PressureMeasureCard(
          sistolicValue: state.observation.component[0].valueQuantity.value.toString(),
          diastolicValue: state.observation.component[1].valueQuantity.value.toString(),
          sistolicUnit: state.observation.component[0].valueQuantity.unit,
          diastolicUnit: state.observation.component[1].valueQuantity.unit,
        );
      }
      if (nameDevice == "Tensiometer") {
        return PressureMeasureCard(
          sistolicValue: state.observation.component[0].valueQuantity.value.toString(),
          diastolicValue: state.observation.component[1].valueQuantity.value.toString(),
          sistolicUnit: state.observation.component[0].valueQuantity.unit,
          diastolicUnit: state.observation.component[1].valueQuantity.unit,
        );
      }
      if (nameDevice == "Thermometer") {
        return ThermometerMeasureCard(
          value: state.observation.valueQuantity.value.toString(),
          unit: state.observation.valueQuantity.unit,
          referenceRange: state.observation.referenceRange,
          measureDone: true,
        );
      }
      if (nameDevice == "Temperature bracelet") {
        return ThermometerMeasureCard(
          value: state.observation.valueQuantity.value.toString(),
          unit: state.observation.valueQuantity.unit,
          referenceRange: state.observation.referenceRange,
          measureDone: true,
        );
      } else {
        return Text('a');
      }
    }
    if (state is DeviceSelectedState) {
      if (nameDevice == "Scale") {
        Random random = Random();
        int min = 65;
        int max = 110;
        value = min + random.nextInt(max - min);
        value2 = 0;
        observationType = "Weight";

        return WeightMeasureCard(value: "-", unit: "Kg");
      }
      if (nameDevice == "Pressure bracelet") {
        Random random = Random();
        int minSys = 90;
        int maxSys = 120;
        int minDiast = 60;
        int maxDiast = 80;
        value = minSys + random.nextInt(maxSys - minSys);
        value2 = minDiast + random.nextInt(maxDiast - minDiast);
        observationType = "Pressure";
        return PressureMeasureCard(
          sistolicValue: "-",
          diastolicValue: "-",
          sistolicUnit: "mmHg",
          diastolicUnit: "mmHg",
        );
      }
      if (nameDevice == "Tensiometer") {
        Random random = Random();
        int minSys = 90;
        int maxSys = 120;
        int minDiast = 60;
        int maxDiast = 80;
        value = minSys + random.nextInt(maxSys - minSys);
        value2 = minDiast + random.nextInt(maxDiast - minDiast);
        observationType = "Pressure";
        return PressureMeasureCard(
          sistolicValue: "-",
          diastolicValue: "-",
          sistolicUnit: "mmHg",
          diastolicUnit: "mmHg",
        );
      }
      if (nameDevice == "Thermometer") {
        Random random = Random();
        int min = 34;
        int max = 39;
        value = min + random.nextInt(max - min);
        value2 = 0;
        observationType = "Temperature";
        List<ReferenceRange> emptyReferencesList = [];
        return ThermometerMeasureCard(
          value: "-",
          unit: "ºC",
          referenceRange: emptyReferencesList,
          measureDone: false,
        );
      }
      if (nameDevice == "Temperature bracelet") {
        Random random = Random();
        int min = 34;
        int max = 39;
        value = min + random.nextInt(max - min);
        value2 = 0;
        observationType = "Temperature";
        List<ReferenceRange> emptyReferencesList = [];
        return Column(
          children: [
            ThermometerMeasureCard(
              value: "-",
              unit: "ºC",
              referenceRange: emptyReferencesList,
              measureDone: false,
            ),
          ],
        );
      } else {
        return Text('b');
      }
    }
    if (state is DeviceMeasuringState) {
      return Center(
          child: Padding(
        padding: const EdgeInsets.only(top: 60.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              translate('pages.measurements_page.measuring'),
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(70.0, 0.0, 70.0, 0.0),
                child: LinearProgressIndicator(
                  color: Theme.of(context).primaryColor,
                  backgroundColor: Theme.of(context).cardColor,
                ),
              ),
            ),
          ],
        ),
      ));
    } else {
      return Text('C');
    }
  }
}

Widget _floatingCollapsed(BuildContext buildContext) {
  return Container(
    decoration: BoxDecoration(
      color: Theme.of(buildContext).primaryColor,
      borderRadius: BorderRadius.only(topLeft: Radius.circular(14.0), topRight: Radius.circular(14.0)),
    ),
    margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
    child: Column(
      children: [
        Icon(
          Icons.horizontal_rule,
          size: 30.0,
          color: Colors.white,
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 0.0),
            child: Text(
              translate("pages.measurements_page.my_measurements"),
              style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _floatingPanel(String idPatient, BuildContext c) {
  DeviceService deviceService = DeviceService();
  return Container(
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(24.0)), boxShadow: [
      BoxShadow(
        blurRadius: 20.0,
        color: Colors.grey,
      ),
    ]),
    margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
    child: BlocProvider(
        create: (context) => HistoricalBloc(deviceService)..add(LoadHistoricalDataEvent(idPatient)),
        child: Column(
          children: [
            Container(
              height: 80.0,
              decoration: BoxDecoration(
                color: Theme.of(c).primaryColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(14.0), topRight: Radius.circular(14.0)),
              ),
              margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
              child: Column(
                children: [
                  Icon(
                    Icons.horizontal_rule,
                    size: 30.0,
                    color: Colors.white,
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 0.0),
                      child: Text(
                        translate("pages.measurements_page.my_measurements"),
                        style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            HistoricalMeasurementsPage()
          ],
        )),
  );
}
