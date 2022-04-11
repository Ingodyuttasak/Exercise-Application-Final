// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:mobile_final/model/score_model.dart';
import 'package:mobile_final/model/weight_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/date_symbol_data_local.dart';

class graph_weight extends StatefulWidget {
  const graph_weight({Key? key}) : super(key: key);

  @override
  _graph_weightState createState() => _graph_weightState();
}

class _graph_weightState extends State<graph_weight> {
  String? uid;
  int sumSun = 0,
      sumMon = 0,
      sumTue = 0,
      sumWed = 0,
      sumThu = 0,
      sumFri = 0,
      sumSat = 0;
  int msec = 86400000, weekcount = 0, i = 0;
  List<String> selDay = [];
  List<int> vdatemonth = [1, 3, 5, 7, 8, 10, 12];
  int ii = 0, iii = 0;
  String dateDay = '', printYear1 = '', printYear3 = '', printYearM = '';
  int monthCount = 0, iseta = 0, isetb = 0;

  String datetimeA = 'aa';
  int scoregrape = 0;

  @override
  void initState() {
    super.initState();

    selectweight();
  }

  Future<void> selectweight() async {
    selDay.clear();
    for (int i = 6; i >= 0; i--) {
      selDay.add(DateFormat('EEE d MMM y').format(
          DateTime.fromMillisecondsSinceEpoch(Timestamp.fromDate(DateTime.now())
                  .toDate()
                  .millisecondsSinceEpoch -
              ((msec * i) + (msec * weekcount)))));
      print('####daynow $selDay');
    }
    setState(() {
      printYear1 = DateFormat('y').format(DateTime.fromMillisecondsSinceEpoch(
          Timestamp.fromDate(DateTime.now()).toDate().millisecondsSinceEpoch -
              ((msec * 6) + (msec * weekcount))));
    });
    graphList();
  }

  Future graphList() async {
    sumSun = 0;
    sumMon = 0;
    sumTue = 0;
    sumWed = 0;
    sumThu = 0;
    sumFri = 0;
    sumSat = 0;
    await FirebaseAuth.instance.authStateChanges().listen((event) async {
      uid = event!.uid;
      print("### helo $uid");

      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('weightUpdate')
          .get()
          .then((value) {
        for (var item in value.docs) {
          WeightModel model = WeightModel.fromMap(item.data());
          print("### helo");
          setState(() {
            Timestamp time = model.weightTime;
            var date = new DateTime.fromMicrosecondsSinceEpoch(
                time.microsecondsSinceEpoch);
            dateDay = new DateFormat('EEE d MMM y').format(date);
            print('####timecheck $dateDay');
            print('###score ${model.nowWeight}');
            
            // if (model.nowWeight != 0 && datetimeA != dateDay) {
            //   datetimeA = dateDay;
            //   scoregrape = int.parse(model.nowWeight);
            //   print('####w $scoregrape d $datetimeA');
            // }

            if (dateDay == selDay[6]) {
              print("###dsun");
              sumSun = int.parse(model.nowWeight);
              print('####nowweight ${model.nowWeight}');
            } else if (dateDay == selDay[5]) {
              sumMon = int.parse(model.nowWeight);
              print('####nowweight ${model.nowWeight}');
              print("###dmon");
            } else if (dateDay == selDay[4]) {
              sumTue = int.parse(model.nowWeight);
              print('####nowweight ${model.nowWeight}');
            } else if (dateDay == selDay[3]) {
              sumWed = int.parse(model.nowWeight);
              print('####nowweight ${model.nowWeight}');
            } else if (dateDay == selDay[2]) {
              sumThu = int.parse(model.nowWeight);
              print('####nowweight ${model.nowWeight}');
            } else if (dateDay == selDay[1]) {
              sumFri = int.parse(model.nowWeight);
              print('####nowweight ${model.nowWeight}');
            } else if (dateDay == selDay[0]) {
              sumSat = int.parse(model.nowWeight);
              print('####nowweight ${model.nowWeight}');
            }
          });
        }
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[700],
        title: Text("กราฟแสดงน้ำหนัก"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.grey[600],
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_back_ios_new_rounded,
                                  size: 30),
                              onPressed: () {
                                setState(() {
                                  weekcount += 7;
                                  selectweight();
                                  graphList();

                                  print('###sel$selDay');
                                });
                              },
                            ),
                            Text("${selDay[0]} - ${selDay[6]}"),
                            IconButton(
                              icon: const Icon(Icons.arrow_forward_ios_rounded,
                                  size: 30),
                              onPressed: () {
                                setState(() {
                                  print('###sel$selDay');
                                  weekcount -= 7;
                                  selectweight();
                                  graphList();
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      SfCartesianChart(
                        title: ChartTitle(text: 'กราฟแสดงน้ำหนักรายวัน'),
                        legend: Legend(isVisible: false),
                        tooltipBehavior: TooltipBehavior(enable: true),
                        series: <ChartSeries>[
                          LineSeries<MildDate, String>(
                              dataSource: [
                                MildDate('${selDay[0].substring(4, 10)}',
                                    sumSat, Colors.blue.shade900),
                                MildDate('${selDay[1].substring(4, 10)}',
                                    sumFri, Colors.blue.shade900),
                                MildDate('${selDay[2].substring(4, 10)}',
                                    sumThu, Colors.blue.shade900),
                                MildDate('${selDay[3].substring(4, 10)}',
                                    sumWed, Colors.blue.shade900),
                                MildDate('${selDay[4].substring(4, 10)}',
                                    sumTue, Colors.blue.shade900),
                                MildDate('${selDay[5].substring(4, 10)}',
                                    sumMon, Colors.blue.shade900),
                                MildDate('${selDay[6].substring(4, 10)}',
                                    sumSun, Colors.blue.shade900),
                              ],
                              xValueMapper: (MildDate score, _) =>
                                  score.playDate,
                              yValueMapper: (MildDate score, _) => score.score,
                              dataLabelSettings:
                                  DataLabelSettings(isVisible: true),
                              pointColorMapper: (MildDate data, _) => data.color
                              // enableTooltip: true
                              )
                        ],
                        primaryXAxis: CategoryAxis(),
                        primaryYAxis: NumericAxis(
                            edgeLabelPlacement: EdgeLabelPlacement.shift,
                            // numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0),
                            title: AxisTitle(text: 'น้ำหนัก (กิโลกรัม)')),
                      ),
                    ],
                  ),
                ),
                Image.asset(
                  'assets/images/scalesWeight.gif',
                  width: 200,
                  height: 200,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MildDate {
  MildDate(this.playDate, this.score, this.color);
  final String playDate;
  final num score;
  final Color color;
}
