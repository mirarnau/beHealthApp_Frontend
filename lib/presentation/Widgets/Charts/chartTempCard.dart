// ignore_for_file: prefer_const_constructors

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:medical_devices/business_logic/bloc/device/device_bloc.dart';
import 'package:medical_devices/data/Models/Observation.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartTempCard extends StatelessWidget {
  final List<Observation> listObservations;
  final String title;
  final bool legendVisible = true;

  ChartTempCard({required this.listObservations, required this.title});

  @override
  Widget build(BuildContext context) {
    TooltipBehavior _tooltipBehavior = TooltipBehavior(enable: true);
    return SfCartesianChart(
        tooltipBehavior: _tooltipBehavior,
        plotAreaBorderWidth: 0.0,
        primaryXAxis: CategoryAxis(
          majorGridLines: MajorGridLines(width: 0),
          borderWidth: 0.0,
        ),
        primaryYAxis: NumericAxis(
          majorGridLines: MajorGridLines(width: 0),
          labelFormat: '{value} ºC',
          isVisible: false,
        ),
        series: <ChartSeries>[
          LineSeries<Observation, String>(
            name: translate('pages.historical_page.titles.temperature'),
            color: Theme.of(context).primaryColor,
            width: 1.0,
            dataSource: listObservations,
            xValueMapper: (Observation observation, _) => '${DateTime.parse(observation.effectiveDateTime).day}/${DateTime.parse(observation.effectiveDateTime).month}',
            yValueMapper: (Observation observation, _) => observation.valueQuantity.value,
            dataLabelSettings: DataLabelSettings(
              isVisible: true,
              textStyle: TextStyle(color: Color.fromARGB(255, 85, 85, 85), fontWeight: FontWeight.bold),
            ),
            enableTooltip: true,
            markerSettings: MarkerSettings(
              isVisible: true,
              color: Theme.of(context).primaryColor,
              borderColor: Theme.of(context).primaryColor,
              height: 10.0,
              width: 10.0,
              shape: DataMarkerType.circle,
            ),
          ),
          LineSeries<Observation, String>(
            name: translate('pages.historical_page.titles.temperature'),
            color: Colors.red,
            dashArray: <double>[10, 10],
            width: 1.0,
            dataSource: listObservations,
            enableTooltip: false,
            xValueMapper: (Observation observation, _) => '${DateTime.parse(observation.effectiveDateTime).day}/${DateTime.parse(observation.effectiveDateTime).month}',
            yValueMapper: (Observation observation, _) => observation.referenceRange[0].high.value,
          ),
          LineSeries<Observation, String>(
            name: translate('pages.historical_page.titles.temperature'),
            color: Colors.blue,
            dashArray: <double>[10, 10],
            enableTooltip: false,
            width: 1.0,
            dataSource: listObservations,
            xValueMapper: (Observation observation, _) => '${DateTime.parse(observation.effectiveDateTime).day}/${DateTime.parse(observation.effectiveDateTime).month}',
            yValueMapper: (Observation observation, _) => 35,
          ),
        ]);
  }

  List<ChartSeries<Observation, String>> _getStackedLine100Series() {
    return <ChartSeries<Observation, String>>[
      StackedLine100Series<Observation, String>(
        dataSource: listObservations,
        xValueMapper: (Observation observation, _) => '${DateTime.parse(observation.effectiveDateTime).day}/${DateTime.parse(observation.effectiveDateTime).month}',
        yValueMapper: (Observation observation, _) => observation.valueQuantity.value,
      ),
    ];
  }
}
