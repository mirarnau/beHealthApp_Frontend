// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_devices/business_logic/bloc/authorization/authorization_bloc.dart';
import 'package:medical_devices/data/Models/Group.dart';
import 'package:medical_devices/data/Models/User.dart';
import 'package:medical_devices/data/Services/groupService.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class InfoStepsManagerPage extends StatefulWidget {
  final Group group;
  const InfoStepsManagerPage({Key? key, required this.group}) : super(key: key);

  @override
  _InfoStepsManagerPageState createState() => _InfoStepsManagerPageState();
}

class _InfoStepsManagerPageState extends State<InfoStepsManagerPage> {
  GroupService groupService = GroupService();
  num lastDayAverage = 0;
  num historicalAverage = 0;
  num percentageVariation = 0;
  num lowRangeValue = 0;
  num highRangeValue = 0;
  late List<User> sortedPatients;
  late User myUser;
  void initState() {
    sortedPatients = widget.group.patients;
    super.initState();
    getAverages();
  }

  @override
  Widget build(BuildContext context) {
    TooltipBehavior _tooltipBehavior = TooltipBehavior(
      enable: true,
      duration: 0,
      color: Theme.of(context).cardColor,
    );
    sortPatientsGroupByRating();
    return BlocBuilder<AuthorizationBloc, AuthorizationState>(
      builder: (context, state) {
        if (state is AuthorizedState) {
          myUser = state.user;
        }
        return SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20.0),
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
                      start: lowRangeValue,
                      end: highRangeValue,
                      dashArray: const <double>[6, 10],
                      borderColor: Colors.green,
                      borderWidth: 2,
                      color: Color.fromARGB(255, 236, 250, 236),
                    ),
                  ],
                  majorGridLines: MajorGridLines(width: 0),
                  labelFormat: '{value} steps',
                  isVisible: false,
                ),
                series: <ChartSeries>[
                  LineSeries<DailyStepsAverage, String>(
                    name: 'Steps',
                    color: Theme.of(context).primaryColor,
                    width: 1.0,
                    dataSource: widget.group.dailyStepsAverages,
                    xValueMapper: (DailyStepsAverage stepsAverage, _) => '${stepsAverage.date.day}/${stepsAverage.date.month}',
                    yValueMapper: (DailyStepsAverage stepsAverage, _) => stepsAverage.value ~/ widget.group.patients.length,
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
              SizedBox(height: 10.0),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Container(
                      height: 140,
                      width: 180.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0, 2),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 20.0),
                          Text(
                            "HISTORICAL",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                historicalAverage.toInt().toString(),
                                style: TextStyle(
                                  color: Color.fromARGB(255, 30, 61, 72),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28.0,
                                ),
                              ),
                              SizedBox(width: 6.0),
                              Text(
                                'STEPS',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 30, 61, 72),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.0,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'PER PERSON ON AVERAGE',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                              color: Color.fromARGB(255, 30, 61, 72),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Container(
                      height: 140,
                      width: 180.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0, 2),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              decideArrow(),
                              Text(
                                "YESTERDAY",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.0,
                                  color: lastDayAverage > historicalAverage ? Colors.green : Colors.red,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                lastDayAverage.toInt().toString(),
                                style: TextStyle(
                                  color: lastDayAverage > historicalAverage ? Colors.green : Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28.0,
                                ),
                              ),
                              SizedBox(width: 6.0),
                              Text(
                                'STEPS',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 30, 61, 72),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.0,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 2.0),
                          Text(
                            'PER PERSON ON AVERAGE',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                              color: Color.fromARGB(255, 30, 61, 72),
                            ),
                          ),
                          SizedBox(height: 6.0),
                          getMarkYesterday(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Container(
                      height: 140,
                      width: 180.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0, 2),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 20.0),
                          Text(
                            "DEVIATION",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                              color: Colors.orange,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                percentageVariation.toInt().toString(),
                                style: TextStyle(
                                  color: Color.fromARGB(255, 30, 61, 72),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28.0,
                                ),
                              ),
                              SizedBox(width: 6.0),
                              Text(
                                '%',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 30, 61, 72),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'AVERAGE VARIATION',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                              color: Color.fromARGB(255, 30, 61, 72),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Container(
                      height: 140,
                      width: 180.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0, 2),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 20.0),
                          Text(
                            "NORMAL RANGE",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                              color: Color.fromARGB(255, 30, 61, 72),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                lowRangeValue.toInt().toString(),
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22.0,
                                ),
                              ),
                              SizedBox(width: 8.0),
                              Icon(Icons.compare_arrows_outlined),
                              SizedBox(width: 8.0),
                              Text(
                                highRangeValue.toInt().toString(),
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22.0,
                                ),
                              ),
                              SizedBox(width: 6.0),
                            ],
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            'DAILY STEPS',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                              color: Color.fromARGB(255, 30, 61, 72),
                            ),
                          ),
                          getMarkRange()
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40.0),
              Column(children: getRanking())
            ],
          ),
        );
      },
    );
  }

  void storeAverage() async {
    var updatedGroup = await groupService.storeTotalAverageSteps(widget.group.id, DateTime.now());
    if (updatedGroup != null) {
      lastDayAverage = updatedGroup.dailyStepsAverages.last.value;
    }
    setState(() {});
  }

  void getAverages() async {
    var averages = await groupService.getAverages(widget.group.id);
    lastDayAverage = averages['lastDayAverage'];
    historicalAverage = averages['historicalAverage'];
    percentageVariation = averages['percentageDeviation'];
    lowRangeValue = historicalAverage - averages['standardDeviation'];
    highRangeValue = historicalAverage + averages['standardDeviation'];
    setState(() {});
  }

  Widget decideArrow() {
    if (lastDayAverage > historicalAverage) {
      return Icon(
        Icons.arrow_upward,
        color: Colors.green,
      );
    } else {
      return Icon(
        Icons.arrow_downward,
        color: Colors.red,
      );
    }
  }

  Widget getMarkYesterday() {
    if (lastDayAverage > historicalAverage) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.verified,
            color: Colors.green,
          ),
          SizedBox(width: 4.0),
          Text(
            'VERY GOOD MARK',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 10.0,
              color: Colors.green,
            ),
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.directions_walk_outlined,
            color: Colors.red,
          ),
          SizedBox(width: 4.0),
          Text(
            'LOWER THAN AVERAGE',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 10.0,
              color: Colors.red,
            ),
          ),
        ],
      );
    }
  }

  Widget getMarkRange() {
    if (myUser.todayFootsteps > highRangeValue) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.emoji_events,
            color: Color.fromARGB(255, 255, 209, 59),
          ),
          SizedBox(width: 4.0),
          Text(
            "YOU'RE AVOBE RANGE",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 10.0,
              color: Color.fromARGB(255, 255, 193, 59),
            ),
          ),
        ],
      );
    }
    if (myUser.todayFootsteps < highRangeValue) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.directions_walk_outlined,
            color: Colors.red,
          ),
          SizedBox(width: 4.0),
          Text(
            "YOU'RE UNDER RANGE",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 10.0,
              color: Colors.red,
            ),
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.verified,
            color: Colors.green,
          ),
          SizedBox(width: 4.0),
          Text(
            "YOU'RE WITHIN RANGE",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 10.0,
              color: Colors.green,
            ),
          ),
        ],
      );
    }
  }

  void sortPatientsGroupByRating() {
    sortedPatients.sort((User b, User a) => a.todayFootsteps.compareTo(b.todayFootsteps));
  }

  List<Widget> getRanking() {
    List<Widget> listWidgets = [];
    for (int i = 0; i < sortedPatients.length; i++) {
      if (i == 0) {
        listWidgets.add(SizedBox(height: 4.0));
        listWidgets.add(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 193, 59),
              borderRadius: BorderRadius.circular(16.0),
            ),
            height: 50.0,
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                SizedBox(width: 10.0),
                Icon(
                  Icons.emoji_events,
                  size: 28.0,
                ),
                SizedBox(width: 12.0),
                Text(
                  '1. ${sortedPatients.first.fullName}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 18.0),
                  child: Text(
                    '${sortedPatients.first.todayFootsteps} steps',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
      }
      if (i == 1) {
        listWidgets.add(SizedBox(height: 4.0));
        listWidgets.add(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 196, 196, 196),
              borderRadius: BorderRadius.circular(16.0),
            ),
            height: 50.0,
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                SizedBox(width: 10.0),
                Icon(
                  Icons.verified,
                  size: 28.0,
                ),
                SizedBox(width: 12.0),
                Text(
                  '2. ${sortedPatients[1].fullName}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 18.0),
                  child: Text(
                    '${sortedPatients[1].todayFootsteps} steps',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
      }
      if (i == 2) {
        listWidgets.add(SizedBox(height: 4.0));
        listWidgets.add(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 225, 160, 137),
              borderRadius: BorderRadius.circular(16.0),
            ),
            height: 50.0,
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                SizedBox(width: 10.0),
                Icon(
                  Icons.directions_walk_outlined,
                  size: 28.0,
                ),
                SizedBox(width: 12.0),
                Text(
                  '3. ${sortedPatients[2].fullName}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 18.0),
                  child: Text(
                    '${sortedPatients[2].todayFootsteps} steps',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
      }
    }
    return listWidgets;
  }
}
