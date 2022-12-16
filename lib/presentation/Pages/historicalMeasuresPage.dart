// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:medical_devices/business_logic/bloc/device/device_bloc.dart';
import 'package:medical_devices/business_logic/bloc/historical/historical_bloc.dart';
import 'package:medical_devices/data/Models/Observation.dart';
import 'package:medical_devices/presentation/Widgets/Charts/chartPressureCard.dart';
import 'package:medical_devices/presentation/Widgets/Charts/chartTempCard.dart';
import 'package:medical_devices/presentation/Widgets/Charts/chartWeightCard.dart';

class HistoricalMeasurementsPage extends StatefulWidget {
  const HistoricalMeasurementsPage({Key? key}) : super(key: key);

  @override
  _HistoricalMeasurementsPageState createState() => _HistoricalMeasurementsPageState();
}

class _HistoricalMeasurementsPageState extends State<HistoricalMeasurementsPage> {
  late List<Observation> temperatureObservations = [];
  late List<Observation> weightObservations = [];
  late List<Observation> pressureObservations = [];
  late String selectedDevice;

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 4,
      child: Expanded(
        child: Column(
          children: [
            TabBar(
              labelColor: Theme.of(context).primaryColor,
              unselectedLabelColor: Color.fromARGB(169, 0, 0, 0),
              indicatorColor: Theme.of(context).primaryColor,
              indicatorSize: TabBarIndicatorSize.label,
              labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
              tabs: [
                Tab(
                  text: translate('pages.historical_page.day'),
                ),
                Tab(
                  text: translate('pages.historical_page.week'),
                ),
                Tab(
                  text: translate('pages.historical_page.month'),
                ),
                Tab(
                  text: translate('pages.historical_page.year'),
                )
              ],
            ),
            Expanded(
              child: TabBarView(children: <Widget>[
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 14.0),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          getWeekDay(DateTime.now().weekday),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    BlocConsumer<DeviceBloc, DeviceState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        if (state is DeviceSelectedState) {
                          selectedDevice = state.nameDevice;
                        }
                        return BlocConsumer<HistoricalBloc, HistoricalState>(
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
                                  padding: const EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 0.0),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "You don't have measurements for this device yet",
                                          style: TextStyle(
                                            color: Color.fromARGB(255, 30, 61, 72),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 30.0,
                                        ),
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
                              return Padding(
                                padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
                                child: decideChart(state),
                              );
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          },
                        );
                      },
                    )
                  ],
                ),
                Container(
                  height: 50.0,
                  width: 50.0,
                ),
                Container(
                  height: 50.0,
                  width: 50.0,
                ),
                Container(
                  height: 50.0,
                  width: 50.0,
                ),
              ]),
            )
          ],
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

    if (selectedDevice == translate('medical_devices.scale')) {
      BlocProvider.of<HistoricalBloc>(c).add(SelectHistoricalVisualizationEvent(weightObservations, selectedDevice));
    }
    if (selectedDevice == translate('medical_devices.temperature_bracelet')) {
      BlocProvider.of<HistoricalBloc>(c).add(SelectHistoricalVisualizationEvent(temperatureObservations, selectedDevice));
    }
    if (selectedDevice == translate('medical_devices.pressure_bracelet')) {
      BlocProvider.of<HistoricalBloc>(c).add(SelectHistoricalVisualizationEvent(pressureObservations, selectedDevice));
    }
    if (selectedDevice == translate('medical_devices.tensiometer')) {
      BlocProvider.of<HistoricalBloc>(c).add(SelectHistoricalVisualizationEvent(pressureObservations, selectedDevice));
    }
    if (selectedDevice == translate('medical_devices.thermometer')) {
      BlocProvider.of<HistoricalBloc>(c).add(SelectHistoricalVisualizationEvent(temperatureObservations, selectedDevice));
    }
  }
}

String getWeekDay(int day) {
  if (day == 1) {
    return translate(translate('pages.historical_page.weekdays.monday'));
  }
  if (day == 2) {
    return translate(translate('pages.historical_page.weekdays.tuesday'));
  }
  if (day == 3) {
    return translate(translate('pages.historical_page.weekdays.wednesday'));
  }
  if (day == 4) {
    return translate(translate('pages.historical_page.weekdays.thursday'));
  }
  if (day == 5) {
    return translate(translate('pages.historical_page.weekdays.friday'));
  }
  if (day == 6) {
    return translate(translate('pages.historical_page.weekdays.saturday'));
  } else {
    return translate(translate('pages.historical_page.weekdays.sunday'));
  }
}

Widget decideChart(HistoricalVisualizationState state) {
  if (state.associatedDevice == translate('medical_devices.thermometer')) {
    return ChartTempCard(
      listObservations: state.visualizedObservations,
      title: translate('pages.historical_page.titles.temperature'),
    );
  }
  if (state.associatedDevice == translate('medical_devices.temperature_bracelet')) {
    return ChartTempCard(
      listObservations: state.visualizedObservations,
      title: translate('pages.historical_page.titles.temperature'),
    );
  }
  if (state.associatedDevice == translate('medical_devices.pressure_bracelet')) {
    return ChartPressureCard(
      listObservations: state.visualizedObservations,
      title: translate('pages.historical_page.titles.pressure'),
    );
  }
  if (state.associatedDevice == translate('medical_devices.tensiometer')) {
    return ChartPressureCard(
      listObservations: state.visualizedObservations,
      title: translate('pages.historical_page.titles.pressure'),
    );
  }
  if (state.associatedDevice == translate('medical_devices.scale')) {
    return ChartWeightCard(
      listObservations: state.visualizedObservations,
      title: translate('pages.historical_page.titles.weight'),
    );
  } else {
    return Container();
  }
}
