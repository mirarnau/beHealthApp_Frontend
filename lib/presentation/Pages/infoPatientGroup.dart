// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:medical_devices/data/Models/User.dart';
import 'package:medical_devices/data/Services/userService.dart';
import 'package:medical_devices/presentation/Widgets/deviceCard.dart';
import 'package:medical_devices/presentation/Widgets/deviceCardInfo.dart';

class InfoPatientPage extends StatefulWidget {
  final User user;
  const InfoPatientPage({Key? key, required this.user}) : super(key: key);

  @override
  _InfoPatientPageState createState() => _InfoPatientPageState();
}

class _InfoPatientPageState extends State<InfoPatientPage> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Color.fromARGB(230, 30, 61, 72),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 10.0),
                      child: CircleAvatar(
                        radius: 50.0,
                        backgroundImage: NetworkImage(widget.user.imageUrl),
                      ),
                    ),
                    Text(
                      widget.user.fullName,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white),
                    ),
                    Text(
                      widget.user.email,
                      style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16.0, color: Color.fromARGB(255, 216, 216, 216)),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 30.0, 0.0, 0.0),
                      child: Row(
                        children: [
                          Row(
                            children: [
                              Text(
                                translate('pages.info_patient.address'),
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0, color: Color.fromARGB(255, 216, 216, 216)),
                              ),
                              Text(
                                'C/ Diagonal 3 ',
                                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14.0, color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 5.0, 0.0, 0.0),
                      child: Row(
                        children: [
                          Row(
                            children: [
                              Text(
                                translate('pages.info_patient.city'),
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0, color: Color.fromARGB(255, 216, 216, 216)),
                              ),
                              Text(
                                'Example City ',
                                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14.0, color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 5.0, 0.0, 0.0),
                      child: Row(
                        children: [
                          Row(
                            children: [
                              Text(
                                translate('pages.info_patient.country'),
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0, color: Color.fromARGB(255, 216, 216, 216)),
                              ),
                              Text(
                                'Example Country ',
                                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14.0, color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 5.0, 0.0, 0.0),
                      child: Row(
                        children: [
                          Row(
                            children: [
                              Text(
                                translate('pages.info_patient.phone_number'),
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0, color: Color.fromARGB(255, 216, 216, 216)),
                              ),
                              Text(
                                '+3460836738',
                                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14.0, color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
              child: Text(
                translate('pages.info_patient.user_devices'),
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ),
              ),
            ),
            decideWidgetDevices()
          ],
        ),
      ),
    );
  }

  Widget decideWidgetDevices() {
    if (widget.user.listDevices.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0),
        child: Center(
          child: Column(
            children: [
              Icon(
                Icons.devices_other,
                color: Color.fromARGB(255, 30, 61, 72),
                size: 100.0,
              ),
              Text(
                "The user has no devices yet",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Color.fromARGB(255, 30, 61, 72),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      List<DeviceCardInfo> listCards = [];
      for (int i = 0; i < widget.user.listDevices.length; i++) {
        listCards.add(DeviceCardInfo(
          nameDevice: widget.user.listDevices[i].nameDevice,
          photoDevice: widget.user.listDevices[i].photoDevice,
          modelDevice: widget.user.listDevices[i].modelDevice,
          verified: widget.user.listDevices[i].verified,
        ));
      }
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 40.0),
        child: CarouselSlider(
            items: listCards,
            options: CarouselOptions(
              height: 340.0,
              enlargeCenterPage: false,
              autoPlay: false,
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
              enableInfiniteScroll: false,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              viewportFraction: 0.8,
            )),
      );
    }
  }
}
