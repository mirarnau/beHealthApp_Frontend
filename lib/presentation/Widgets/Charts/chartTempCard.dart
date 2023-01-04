// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:medical_devices/data/Models/Observation.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartTempCard extends StatelessWidget {
  final List<Observation> listObservations;
  final String title;
  final bool legendVisible = true;

  ChartTempCard({required this.listObservations, required this.title});

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
          tooltipBehavior: _tooltipBehavior,
          plotAreaBorderWidth: 0.0,
          primaryXAxis: CategoryAxis(
            majorGridLines: MajorGridLines(width: 0),
            borderWidth: 0.0,
          ),
          primaryYAxis: NumericAxis(
            plotBands: [
              PlotBand(
                start: listObservations[0].referenceRange[0].high.value,
                end: listObservations[0].referenceRange[0].high.value,
                dashArray: const <double>[6, 10],
                borderColor: Colors.red,
                borderWidth: 2,
              ),
              PlotBand(
                start: listObservations[0].referenceRange[0].low.value,
                end: listObservations[0].referenceRange[0].low.value,
                dashArray: const <double>[6, 10],
                borderColor: Colors.blue,
                borderWidth: 2,
              ),
              PlotBand(
                start: listObservations[0].referenceRange[0].low.value,
                end: listObservations[0].referenceRange[0].high.value,
                color: Color.fromARGB(255, 215, 255, 247),
                borderWidth: 0,
              )
            ],
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
      if (listObservations[i].valueQuantity.value < listObservations[i].referenceRange[0].low.value) {
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
                  Icon(
                    Icons.thermostat,
                    color: Colors.blue,
                    size: 30.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${DateTime.parse(listObservations[i].effectiveDateTime).day}/${DateTime.parse(listObservations[i].effectiveDateTime).month}/${DateTime.parse(listObservations[i].effectiveDateTime).year}'),
                      Text(
                        'Low temperature anomaly detected',
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
      if (listObservations[i].valueQuantity.value > listObservations[i].referenceRange[0].high.value) {
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
                  Icon(
                    Icons.thermostat,
                    color: Colors.red,
                    size: 30.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${DateTime.parse(listObservations[i].effectiveDateTime).day}/${DateTime.parse(listObservations[i].effectiveDateTime).month}/${DateTime.parse(listObservations[i].effectiveDateTime).year}'),
                      Text(
                        'High temperature anomaly detected',
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
