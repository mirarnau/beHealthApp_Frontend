// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:medical_devices/business_logic/bloc/device/device_bloc.dart';
import 'package:medical_devices/data/Models/Observation.dart';
import 'package:medical_devices/presentation/Widgets/Charts/chartWeightCard.dart';

class InfoChartsCard extends StatefulWidget {
  final List<Observation> listObservations;
  InfoChartsCard({required this.listObservations});

  @override
  State<InfoChartsCard> createState() => _InfoChartsCardState();
}

class _InfoChartsCardState extends State<InfoChartsCard> {
  late int? dataClickedValue;
  @override
  void initState() {
    dataClicked.addListener(() {
      setState(() {
        dataClickedValue = dataClicked.value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
