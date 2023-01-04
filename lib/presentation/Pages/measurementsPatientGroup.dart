// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:medical_devices/business_logic/bloc/historical/historical_bloc.dart';
import 'package:medical_devices/data/Models/Observation.dart';
import 'package:medical_devices/data/Models/User.dart';
import 'package:medical_devices/data/Services/deviceService.dart';
import 'package:medical_devices/presentation/Pages/historicalMeasuresPage.dart';

class MeasurementsPatientGroup extends StatefulWidget {
  final String selectedDevice;
  final User patient;
  final String photoDevice;
  const MeasurementsPatientGroup({Key? key, required this.selectedDevice, required this.patient, required this.photoDevice}) : super(key: key);

  @override
  _MeasurementsPatientGroupState createState() => _MeasurementsPatientGroupState();
}

class _MeasurementsPatientGroupState extends State<MeasurementsPatientGroup> {
  late List<Observation> temperatureObservations = [];
  late List<Observation> weightObservations = [];
  late List<Observation> pressureObservations = [];
  DeviceService deviceService = DeviceService();

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HistoricalBloc(deviceService)..add(LoadHistoricalDataEvent(widget.patient.id)),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Color.fromARGB(255, 255, 255, 255)),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Theme.of(context).cardColor,
          title: Text(
            translate('titles.beHealthApp'),
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
          ),
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.chat_bubble_rounded))],
        ),
        body: BlocConsumer<HistoricalBloc, HistoricalState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is HistoricalLoadedState) {
              filterObservations(state.listObservations, context);
              return Center(
                  child: CircularProgressIndicator(
                color: Colors.red,
              ));
            }
            if (state is HistoricalVisualizationState) {
              if (state.visualizedObservations.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50.0),
                          child: Text(
                            "The user doesn't have measurements for this device yet",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color.fromARGB(255, 30, 61, 72),
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Icon(
                          Icons.question_mark,
                          size: 100.0,
                          color: Color.fromARGB(255, 30, 61, 72),
                        )
                      ],
                    ),
                  ),
                );
              }
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 200.0,
                      width: 200.0,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Image.asset(
                          widget.photoDevice,
                        ),
                      ),
                    ),
                    Text(
                      widget.selectedDevice,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      widget.patient.fullName,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 15.0,
                        color: Color.fromARGB(255, 60, 60, 60),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 40.0, 10.0, 400.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: decideChart(state),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  void filterObservations(List<Observation> listObservation, BuildContext c) {
    for (int i = 0; i < listObservation.length; i++) {
      var listCodings = listObservation[i].code.coding;
      for (int k = 0; k < listCodings.length; k++) {
        if (listCodings[k].code == "8310-5") {
          temperatureObservations.add(listObservation[i]);
        }
        if (listCodings[k].code == "29463-7") {
          weightObservations.add((listObservation[i]));
        }
        if (listCodings[k].code == "85354-9") {
          pressureObservations.add(listObservation[i]);
        }
      }
    }

    if (widget.selectedDevice == translate('medical_devices.scale')) {
      BlocProvider.of<HistoricalBloc>(c).add(SelectHistoricalVisualizationEvent(weightObservations, widget.selectedDevice));
    }
    if (widget.selectedDevice == translate('medical_devices.temperature_bracelet')) {
      BlocProvider.of<HistoricalBloc>(c).add(SelectHistoricalVisualizationEvent(temperatureObservations, widget.selectedDevice));
    }
    if (widget.selectedDevice == translate('medical_devices.pressure_bracelet')) {
      BlocProvider.of<HistoricalBloc>(c).add(SelectHistoricalVisualizationEvent(pressureObservations, widget.selectedDevice));
    }
    if (widget.selectedDevice == translate('medical_devices.tensiometer')) {
      BlocProvider.of<HistoricalBloc>(c).add(SelectHistoricalVisualizationEvent(pressureObservations, widget.selectedDevice));
    }
    if (widget.selectedDevice == translate('medical_devices.thermometer')) {
      BlocProvider.of<HistoricalBloc>(c).add(SelectHistoricalVisualizationEvent(temperatureObservations, widget.selectedDevice));
    }
  }
}
