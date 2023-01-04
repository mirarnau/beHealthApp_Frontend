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
    return Column(
      children: [
        SfCartesianChart(
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
            plotBands: [
              PlotBand(
                start: listObservations[0].component[0].referenceRangeComponent[0].high.value, //First component is systolic and second is diastolic
                end: listObservations[0].component[0].referenceRangeComponent[0].high.value,
                dashArray: const <double>[6, 10],
                borderColor: Colors.red,
                borderWidth: 2,
              ),
              PlotBand(
                start: listObservations[0].component[0].referenceRangeComponent[0].low.value,
                end: listObservations[0].component[0].referenceRangeComponent[0].low.value,
                dashArray: const <double>[6, 10],
                borderColor: Colors.blue,
                borderWidth: 2,
              ),
              PlotBand(
                start: listObservations[0].component[0].referenceRangeComponent[0].low.value,
                end: listObservations[0].component[0].referenceRangeComponent[0].high.value,
                color: Color.fromARGB(255, 255, 239, 238),
                borderWidth: 0,
              ),
              PlotBand(
                start: listObservations[0].component[1].referenceRangeComponent[0].high.value, //First component is systolic and second is diastolic
                end: listObservations[0].component[1].referenceRangeComponent[0].high.value,
                dashArray: const <double>[6, 10],
                borderColor: Colors.red,
                borderWidth: 2,
              ),
              PlotBand(
                start: listObservations[0].component[1].referenceRangeComponent[0].low.value,
                end: listObservations[0].component[1].referenceRangeComponent[0].low.value,
                dashArray: const <double>[6, 10],
                borderColor: Colors.blue,
                borderWidth: 2,
              ),
              PlotBand(
                start: listObservations[0].component[1].referenceRangeComponent[0].low.value,
                end: listObservations[0].component[1].referenceRangeComponent[0].high.value,
                color: Color.fromARGB(255, 230, 244, 255),
                borderWidth: 0,
              )
            ],
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
          ],
        ),
        Column(
          children: getAnomaliesWidgets(),
        )
      ],
    );
  }

  List<Widget> getAnomaliesWidgets() {
    List<Widget> listWidgetsAnomalies = [];
    for (int i = 0; i < listObservations.length; i++) {
      Component systolic = listObservations[i].component[0];
      Component diastolic = listObservations[i].component[1];
      if (systolic.valueQuantity.value < systolic.referenceRangeComponent[0].low.value) {
        listWidgetsAnomalies.add(
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 7.0, 0.0, 7.0),
            child: Container(
              child: Row(
                children: [
                  Icon(
                    Icons.warning,
                    color: Colors.yellow,
                    size: 30.0,
                  ),
                  Text(
                    'SYS',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                      fontSize: 16.0,
                    ),
                  ),
                  Icon(
                    Icons.arrow_downward,
                    color: Colors.blue,
                    size: 30.0,
                  ),
                  SizedBox(width: 8.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${DateTime.parse(listObservations[i].effectiveDateTime).day}/${DateTime.parse(listObservations[i].effectiveDateTime).month}/${DateTime.parse(listObservations[i].effectiveDateTime).year}'),
                      Text(
                        'Low systolic pressure detected',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }
      if (systolic.valueQuantity.value > systolic.referenceRangeComponent[0].high.value) {
        listWidgetsAnomalies.add(
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 7.0, 0.0, 7.0),
            child: Container(
              child: Row(
                children: [
                  Icon(
                    Icons.warning,
                    color: Colors.yellow,
                    size: 30.0,
                  ),
                  Text(
                    'SYS',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                      fontSize: 16.0,
                    ),
                  ),
                  Icon(
                    Icons.arrow_upward,
                    color: Colors.red,
                    size: 30.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${DateTime.parse(listObservations[i].effectiveDateTime).day}/${DateTime.parse(listObservations[i].effectiveDateTime).month}/${DateTime.parse(listObservations[i].effectiveDateTime).year}'),
                      Text(
                        'High systolic pressure detected',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }
      if (diastolic.valueQuantity.value < diastolic.referenceRangeComponent[0].low.value) {
        listWidgetsAnomalies.add(
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 7.0, 0.0, 7.0),
            child: Container(
              child: Row(
                children: [
                  Icon(
                    Icons.warning,
                    color: Colors.yellow,
                    size: 30.0,
                  ),
                  Text(
                    'DYS',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      fontSize: 16.0,
                    ),
                  ),
                  Icon(
                    Icons.arrow_downward,
                    color: Colors.blue,
                    size: 30.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${DateTime.parse(listObservations[i].effectiveDateTime).day}/${DateTime.parse(listObservations[i].effectiveDateTime).month}/${DateTime.parse(listObservations[i].effectiveDateTime).year}'),
                      Text(
                        'Low dyastolic pressure detected',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }
      if (diastolic.valueQuantity.value > diastolic.referenceRangeComponent[0].high.value) {
        listWidgetsAnomalies.add(
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 7.0, 0.0, 7.0),
            child: Container(
              child: Row(
                children: [
                  Icon(
                    Icons.warning,
                    color: Colors.yellow,
                    size: 30.0,
                  ),
                  Text(
                    'DYS',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      fontSize: 16.0,
                    ),
                  ),
                  Icon(
                    Icons.arrow_upward,
                    color: Colors.red,
                    size: 30.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${DateTime.parse(listObservations[i].effectiveDateTime).day}/${DateTime.parse(listObservations[i].effectiveDateTime).month}/${DateTime.parse(listObservations[i].effectiveDateTime).year}'),
                      Text(
                        'High dyastolic pressure detected',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }
    }
    return listWidgetsAnomalies;
  }
}
