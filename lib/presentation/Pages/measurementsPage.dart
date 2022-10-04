// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:medical_devices/business_logic/bloc/patient/patient_bloc.dart';
import 'package:medical_devices/data/Services/patientService.dart';
import 'package:medical_devices/presentation/Widgets/deviceCard.dart';

class MeasurementsPage extends StatefulWidget {
  const MeasurementsPage({Key? key}) : super(key: key);

  @override
  _MeasurementsPageState createState() => _MeasurementsPageState();
}

class _MeasurementsPageState extends State<MeasurementsPage> {
  PatientService patientService = PatientService();
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PatientBloc(patientService)..add(PatientLoadRequest("52")),
        ),
      ],
      child: BlocConsumer<PatientBloc, PatientState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is PatientLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Scaffold(
              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0),
                    child: Center(
                        child: (Text(
                      translate('pages.measurements_page.my_devices'),
                      style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
                    ))),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: CarouselSlider(
                        items: [DeviceCard(nameDevice: translate('medical_devices.oximeter'), photoDevice: Image.asset('assets/images/ol_750.png'), modelDevice: 'OL-750'), DeviceCard(nameDevice: translate('medical_devices.tensiometer'), photoDevice: Image.asset('assets/images/bpm_200w.png'), modelDevice: 'BPM 200W'), DeviceCard(nameDevice: translate('medical_devices.scale'), photoDevice: Image.asset('assets/images/bl_1500.png'), modelDevice: 'BL-1500'), DeviceCard(nameDevice: translate('medical_devices.thermometer'), photoDevice: Image.asset('assets/images/it_45b.png'), modelDevice: 'IT-45B'), DeviceCard(nameDevice: translate('medical_devices.pressure_bracelet'), photoDevice: Image.asset('assets/images/bpm_100.png'), modelDevice: 'BPM-100'), DeviceCard(nameDevice: translate('medical_devices.temperature_bracelet'), photoDevice: Image.asset('assets/images/bt_125.png'), modelDevice: 'BT-125')],
                        options: CarouselOptions(
                          height: 410.0,
                          enlargeCenterPage: true,
                          autoPlay: false,
                          aspectRatio: 16 / 9,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          scrollDirection: Axis.horizontal,
                          enableInfiniteScroll: true,
                          autoPlayAnimationDuration: Duration(milliseconds: 800),
                          viewportFraction: 0.6,
                        )),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
