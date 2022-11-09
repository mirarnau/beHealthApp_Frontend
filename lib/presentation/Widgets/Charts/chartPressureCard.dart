// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:medical_devices/data/Models/Observation.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartPressureCard extends StatelessWidget {
  final List<Observation> listObservations;
  final String title;
  final bool legendVisible = true;

  ChartPressureCard({required this.listObservations, required this.title});

  @override
  Widget build(BuildContext context) {
    TooltipBehavior _tooltipBehavior = TooltipBehavior(
      enable: true,
      duration: 0,
      color: Theme.of(context).cardColor,
    );
    return SfCartesianChart(
        legend: Legend(
          isVisible: true,
          position: LegendPosition.bottom,
        ),
        tooltipBehavior: _tooltipBehavior,
        plotAreaBorderWidth: 0.0,
        primaryXAxis: CategoryAxis(
          majorGridLines: MajorGridLines(width: 0),
          borderWidth: 0.0,
        ),
        primaryYAxis: NumericAxis(
          majorGridLines: MajorGridLines(width: 0),
          labelFormat: '{value} ${listObservations[0].component[0].valueQuantity.unit}',
          isVisible: false,
        ),
        series: <ChartSeries>[
          LineSeries<Observation, String>(
            name: translate('pages.historical_page.titles.systolic'),
            color: Colors.red,
            width: 1.0,
            dataSource: listObservations,
            xValueMapper: (Observation observation, _) => '${DateTime.parse(observation.effectiveDateTime).day}/${DateTime.parse(observation.effectiveDateTime).month}',
            yValueMapper: (Observation observation, _) => observation.component[0].valueQuantity.value,
            dataLabelSettings: DataLabelSettings(
              isVisible: true,
              textStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            enableTooltip: true,
            markerSettings: MarkerSettings(
              isVisible: true,
              color: Colors.red,
              borderColor: Colors.red,
              height: 10.0,
              width: 10.0,
              shape: DataMarkerType.circle,
            ),
          ),
          LineSeries<Observation, String>(
            name: translate('pages.historical_page.titles.dyastolic'),
            color: Colors.blue,
            width: 1.0,
            dataSource: listObservations,
            xValueMapper: (Observation observation, _) => '${DateTime.parse(observation.effectiveDateTime).day}/${DateTime.parse(observation.effectiveDateTime).month}',
            yValueMapper: (Observation observation, _) => observation.component[1].valueQuantity.value,
            dataLabelSettings: DataLabelSettings(
              isVisible: true,
              textStyle: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
            enableTooltip: true,
            markerSettings: MarkerSettings(
              isVisible: true,
              color: Colors.blue,
              borderColor: Colors.blue,
              height: 10.0,
              width: 10.0,
              shape: DataMarkerType.circle,
            ),
          ),
        ]);
  }
}
