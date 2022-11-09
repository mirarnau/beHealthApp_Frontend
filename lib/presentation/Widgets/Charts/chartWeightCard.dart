// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:medical_devices/data/Models/Observation.dart';
import 'package:medical_devices/presentation/Widgets/inforCharts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

ValueNotifier<int?> dataClicked = ValueNotifier<int?>(null);

class ChartWeightCard extends StatelessWidget {
  final List<Observation> listObservations;
  final String title;
  final bool legendVisible = true;

  ChartWeightCard({required this.listObservations, required this.title});

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
            majorGridLines: MajorGridLines(width: 0),
            labelFormat: '{value} ${listObservations[0].valueQuantity.unit}',
            isVisible: false,
          ),
          series: <ChartSeries>[
            LineSeries<Observation, String>(
                name: translate('pages.historical_page.titles.weight'),
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
                onPointTap: (ChartPointDetails details) {
                  dataClicked.value = details.pointIndex;
                }),
          ],
        ),
        InfoChartsCard(
          listObservations: listObservations,
        )
      ],
    );
  }
}
