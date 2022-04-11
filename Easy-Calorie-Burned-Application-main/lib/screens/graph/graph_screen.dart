import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:mobile_final/model/score_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/date_symbol_data_local.dart';

class showGraph extends StatefulWidget {
  const showGraph({Key? key}) : super(key: key);

  @override
  _showGraphState createState() => _showGraphState();
}

class _showGraphState extends State<showGraph> {
  String? uid;
  int sumSun = 0,
      sumMon = 0,
      sumTue = 0,
      sumWed = 0,
      sumThu = 0,
      sumFri = 0,
      sumSat = 0;
  int sumSun1 = 0,
      sumMon1 = 0,
      sumTue1 = 0,
      sumWed1 = 0,
      sumThu1 = 0,
      sumFri1 = 0,
      sumSat1 = 0;
  int sumSun2 = 0,
      sumMon2 = 0,
      sumTue2 = 0,
      sumWed2 = 0,
      sumThu2 = 0,
      sumFri2 = 0,
      sumSat2 = 0;
  int msec = 86400000, weekcount = 0, weekcount1 = 0, weekcount2 = 0;
  List<String> selDay = [];
  List<String> selDay1 = [];
  List<String> selDay2 = [];

  // List<ScoreModel> grahMild = [];
  // List<ScoreModel> grahMild1 = [];
  // List<ScoreModel> grahMild2 = [];
  String? dateDay, dateDay1, dateDay2;
  String dateT = '', printYear1 = '', printYear2 = '', printYear3 = '';

  Future selectDay() async {
    selDay.clear();
    for (int i = 6; i >= 0; i--) {
      selDay.add(DateFormat('d MMM y').format(
          DateTime.fromMillisecondsSinceEpoch(Timestamp.fromDate(DateTime.now())
                  .toDate()
                  .millisecondsSinceEpoch -
              ((msec * i) + (msec * weekcount)))));
    }
    setState(() {
      printYear1 = DateFormat('y').format(DateTime.fromMillisecondsSinceEpoch(
          Timestamp.fromDate(DateTime.now()).toDate().millisecondsSinceEpoch -
              ((msec * 6) + (msec * weekcount))));
    });
  }

  Future selectDay1() async {
    selDay1.clear();
    for (int i = 6; i >= 0; i--) {
      selDay1.add(DateFormat('d MMM y').format(
          DateTime.fromMillisecondsSinceEpoch(Timestamp.fromDate(DateTime.now())
                  .toDate()
                  .millisecondsSinceEpoch -
              ((msec * i) + (msec * weekcount1)))));
    }
    setState(() {
      printYear2 = DateFormat('y').format(DateTime.fromMillisecondsSinceEpoch(
          Timestamp.fromDate(DateTime.now()).toDate().millisecondsSinceEpoch -
              ((msec * 6) + (msec * weekcount1))));
    });
  }

  Future selectDay2() async {
    selDay2.clear();
    for (int i = 6; i >= 0; i--) {
      selDay2.add(DateFormat('d MMM y').format(
          DateTime.fromMillisecondsSinceEpoch(Timestamp.fromDate(DateTime.now())
                  .toDate()
                  .millisecondsSinceEpoch -
              ((msec * i) + (msec * weekcount2)))));
    }
    setState(() {
      printYear3 = DateFormat('y').format(DateTime.fromMillisecondsSinceEpoch(
          Timestamp.fromDate(DateTime.now()).toDate().millisecondsSinceEpoch -
              ((msec * 6) + (msec * weekcount2))));
    });
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
          .collection('mildScore')
          .get()
          .then((value) {
        for (var item in value.docs) {
          ScoreModel model = ScoreModel.fromMap(item.data());
          print("### helo");
          setState(() {
            Timestamp time = model.playDate;
            var date = new DateTime.fromMicrosecondsSinceEpoch(
                time.microsecondsSinceEpoch);
           
            dateDay = new DateFormat('d MMM y').format(date);
            

            if (dateDay == selDay[0]) {
              sumSun += model.sumScore;
            } else if (dateDay == selDay[1]) {
              sumMon += model.sumScore;
            } else if (dateDay == selDay[2]) {
              sumTue += model.sumScore;
            } else if (dateDay == selDay[3]) {
              sumWed += model.sumScore;
            } else if (dateDay == selDay[4]) {
              sumThu += model.sumScore;
            } else if (dateDay == selDay[5]) {
              sumFri += model.sumScore;
            } else if (dateDay == selDay[6]) {
              sumSat += model.sumScore;
            }
          });
        }
      });
    });
  }

  Future graphList1() async {
    sumSun1 = 0;
    sumMon1 = 0;
    sumTue1 = 0;
    sumWed1 = 0;
    sumThu1 = 0;
    sumFri1 = 0;
    sumSat1 = 0;
    await FirebaseAuth.instance.authStateChanges().listen((event) async {
      uid = event!.uid;
      print("### helo $uid");

      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('moderateScore')
          .get()
          .then((value) {
        for (var item in value.docs) {
          ScoreModel model = ScoreModel.fromMap(item.data());
          print("### helo");
          setState(() {
            // grahMild1.add(model);
            Timestamp time = model.playDate;
            var date = new DateTime.fromMicrosecondsSinceEpoch(
                time.microsecondsSinceEpoch);
            dateDay1 = new DateFormat('d MMM y').format(date);

            if (dateDay1 == selDay1[0]) {
              sumSun1 += model.sumScore;
            } else if (dateDay1 == selDay1[1]) {
              sumMon1 += model.sumScore;
            } else if (dateDay1 == selDay1[2]) {
              sumTue1 += model.sumScore;
            } else if (dateDay1 == selDay1[3]) {
              sumWed1 += model.sumScore;
            } else if (dateDay1 == selDay1[4]) {
              sumThu1 += model.sumScore;
            } else if (dateDay1 == selDay1[5]) {
              sumFri1 += model.sumScore;
            } else if (dateDay1 == selDay1[6]) {
              sumSat1 += model.sumScore;
            }
          });
        }
      });
    });
  }

  Future graphList2() async {
    sumSun2 = 0;
    sumMon2 = 0;
    sumTue2 = 0;
    sumWed2 = 0;
    sumThu2 = 0;
    sumFri2 = 0;
    sumSat2 = 0;
    await FirebaseAuth.instance.authStateChanges().listen((event) async {
      uid = event!.uid;
      print("### helo $uid");

      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('strenuousScore')
          .get()
          .then((value) {
        for (var item in value.docs) {
          ScoreModel model = ScoreModel.fromMap(item.data());
          print("### helo");
          setState(() {
            // grahMild.add(model);
            Timestamp time = model.playDate;
            var date = new DateTime.fromMicrosecondsSinceEpoch(
                time.microsecondsSinceEpoch);
            // dateDay = new DateFormat('EEE').format(date);
            dateDay2 = new DateFormat('d MMM y').format(date);
            // print('#####time${dateDay}');

            // print('#####time${dateT}');
            // print('#####score${model.sumScore}');

            // sunscore = sumSun ~/ counSun;
            // monscore = sumMon ~/ counMon;
            // print('######$sunscore $monscore');

            if (dateDay2 == selDay2[0]) {
              sumSun2 += model.sumScore;
            } else if (dateDay2 == selDay2[1]) {
              sumMon2 += model.sumScore;
            } else if (dateDay2 == selDay2[2]) {
              sumTue2 += model.sumScore;
            } else if (dateDay2 == selDay2[3]) {
              sumWed2 += model.sumScore;
            } else if (dateDay2 == selDay2[4]) {
              sumThu2 += model.sumScore;
            } else if (dateDay2 == selDay2[5]) {
              sumFri2 += model.sumScore;
            } else if (dateDay2 == selDay2[6]) {
              sumSat2 += model.sumScore;
            }
          });
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();

    graphList();
    graphList1();
    graphList2();

    selectDay();
    selectDay1();
    selectDay2();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("กราฟแสดงการออกกำลังกาย"),
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
                    color: Colors.greenAccent,
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.green,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                icon: const Icon(Icons.arrow_back_ios_new_rounded,size: 30),
                                
                                onPressed: () {
                                  setState(() {
                                    weekcount += 7;
                                    selectDay();
                                    graphList();
                                  });
                                },
                            ),
                            Text("คะแนนการออกกำลังกายในช่วง 7 วัน"),
                            IconButton(
                              icon: const Icon(Icons.arrow_forward_ios_rounded,size:30),
                                onPressed: () {
                                  setState(() {
                                    weekcount -= 7;
                                    selectDay();
                                    graphList();
                                  });
                                },
                                ),
                          ],
                        ),
                      ),
                      SfCartesianChart(
                        title: ChartTitle(text: 'กราฟแสดงการออกกำลังกายระดับ Mild ปี ${printYear2}'),
                        legend: Legend(isVisible: false),
                        tooltipBehavior: TooltipBehavior(enable: true),
                        series: <ChartSeries>[
                          ColumnSeries<MildDate, String>(
                              dataSource: [
                                MildDate(selDay[0].substring(0, 6), sumSun,
                                    Colors.black),
                                MildDate(selDay[1].substring(0, 6), sumMon,
                                    Colors.green.shade200),
                                MildDate(selDay[2].substring(0, 6), sumTue,
                                    Colors.green.shade300),
                                MildDate(selDay[3].substring(0, 6), sumWed,
                                    Colors.green.shade400),
                                MildDate(selDay[4].substring(0, 6), sumThu,
                                    Colors.green.shade500),
                                MildDate(selDay[5].substring(0, 6), sumFri,
                                    Colors.green.shade600),
                                MildDate(selDay[6].substring(0, 6), sumSat,
                                    Colors.green.shade700),
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
                            title: AxisTitle(text: 'คะแนนระดับ Mild')),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            weekcount1 += 7;
                            selectDay1();
                            graphList1();
                          });
                        },
                        child: Text('Back')),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            weekcount1 -= 7;
                            selectDay1();
                            graphList1();
                          });
                        },
                        child: Text('Next')),
                  ],
                ),
                SfCartesianChart(
                  title: ChartTitle(text: 'moderate ${printYear2}'),
                  legend: Legend(isVisible: false),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <ChartSeries>[
                    ColumnSeries<MildDate1, String>(
                        dataSource: [
                          MildDate1(selDay1[0].substring(0, 6), sumSun1,
                              Colors.black),
                          MildDate1(selDay1[1].substring(0, 6), sumMon1,
                              Colors.green.shade200),
                          MildDate1(selDay1[2].substring(0, 6), sumTue1,
                              Colors.green.shade300),
                          MildDate1(selDay1[3].substring(0, 6), sumWed1,
                              Colors.green.shade400),
                          MildDate1(selDay1[4].substring(0, 6), sumThu1,
                              Colors.green.shade500),
                          MildDate1(selDay1[5].substring(0, 6), sumFri1,
                              Colors.green.shade600),
                          MildDate1(selDay1[6].substring(0, 6), sumSat1,
                              Colors.green.shade700),
                        ],
                        xValueMapper: (MildDate1 score, _) => score.playDate,
                        yValueMapper: (MildDate1 score, _) => score.score,
                        dataLabelSettings: DataLabelSettings(isVisible: true),
                        pointColorMapper: (MildDate1 data, _) => data.color
                        // enableTooltip: true
                        )
                  ],
                  primaryXAxis: CategoryAxis(),
                  primaryYAxis: NumericAxis(
                      edgeLabelPlacement: EdgeLabelPlacement.shift,
                      // numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0),
                      title: AxisTitle(text: 'คะแนนเฉลี่ยต่อวัน')),
                ),
                Row(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            weekcount2 += 7;
                            selectDay2();
                            graphList2();
                          });
                        },
                        child: Text('Back')),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            weekcount2 -= 7;
                            selectDay2();
                            graphList2();
                          });
                        },
                        child: Text('Next')),
                  ],
                ),
                SfCartesianChart(
                  title: ChartTitle(text: 'strenuous ${printYear3}'),
                  legend: Legend(isVisible: false),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <ChartSeries>[
                    ColumnSeries<MildDate2, String>(
                        dataSource: [
                          MildDate2(selDay2[0].substring(0, 6), sumSun2,
                              Colors.black),
                          MildDate2(selDay2[1].substring(0, 6), sumMon2,
                              Colors.green.shade200),
                          MildDate2(selDay2[2].substring(0, 6), sumTue2,
                              Colors.green.shade300),
                          MildDate2(selDay2[3].substring(0, 6), sumWed2,
                              Colors.green.shade400),
                          MildDate2(selDay2[4].substring(0, 6), sumThu2,
                              Colors.green.shade500),
                          MildDate2(selDay2[5].substring(0, 6), sumFri2,
                              Colors.green.shade600),
                          MildDate2(selDay2[6].substring(0, 6), sumSat2,
                              Colors.green.shade700),
                        ],
                        xValueMapper: (MildDate2 score, _) => score.playDate,
                        yValueMapper: (MildDate2 score, _) => score.score,
                        dataLabelSettings: DataLabelSettings(isVisible: true),
                        pointColorMapper: (MildDate2 data, _) => data.color
                        // enableTooltip: true
                        )
                  ],
                  primaryXAxis: CategoryAxis(),
                  primaryYAxis: NumericAxis(
                      edgeLabelPlacement: EdgeLabelPlacement.shift,
                      // numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0),
                      title: AxisTitle(text: 'คะแนนเฉลี่ยต่อวัน')),
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

class MildDate1 {
  MildDate1(this.playDate, this.score, this.color);
  final String playDate;
  final num score;
  final Color color;
}

class MildDate2 {
  MildDate2(this.playDate, this.score, this.color);
  final String playDate;
  final num score;
  final Color color;
}

//mild Graph

// Row(
//                   children: [
//                     ElevatedButton(
//                         onPressed: () {
//                           setState(() {
//                             weekcount += 7;
//                             selectDay();
//                             graphList();
//                           });
//                         },
//                         child: Text('Back')),
//                     ElevatedButton(
//                         onPressed: () {
//                           setState(() {
//                             weekcount -= 7;
//                             selectDay();
//                             graphList();
//                           });
//                         },
//                         child: Text('Next')),
//                   ],
//                 ),
//                 SfCartesianChart(
//                   title: ChartTitle(text: 'mild ${printYear2}'),
//                   legend: Legend(isVisible: false),
//                   tooltipBehavior: TooltipBehavior(enable: true),
//                   series: <ChartSeries>[
//                     ColumnSeries<MildDate, String>(
//                         dataSource: [
//                           MildDate(
//                               selDay[0].substring(0, 6), sumSun, Colors.black),
//                           MildDate(selDay[1].substring(0, 6), sumMon,
//                               Colors.green.shade200),
//                           MildDate(selDay[2].substring(0, 6), sumTue,
//                               Colors.green.shade300),
//                           MildDate(selDay[3].substring(0, 6), sumWed,
//                               Colors.green.shade400),
//                           MildDate(selDay[4].substring(0, 6), sumThu,
//                               Colors.green.shade500),
//                           MildDate(selDay[5].substring(0, 6), sumFri,
//                               Colors.green.shade600),
//                           MildDate(selDay[6].substring(0, 6), sumSat,
//                               Colors.green.shade700),
//                         ],
//                         xValueMapper: (MildDate score, _) => score.playDate,
//                         yValueMapper: (MildDate score, _) => score.score,
//                         dataLabelSettings: DataLabelSettings(isVisible: true),
//                         pointColorMapper: (MildDate data, _) => data.color
//                         // enableTooltip: true
//                         )
//                   ],
//                   primaryXAxis: CategoryAxis(),
//                   primaryYAxis: NumericAxis(
//                       edgeLabelPlacement: EdgeLabelPlacement.shift,
//                       // numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0),
//                       title: AxisTitle(text: 'คะแนนเฉลี่ยต่อวัน')),
//                 ),