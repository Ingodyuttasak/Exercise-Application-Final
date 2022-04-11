import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:mobile_final/model/score_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/date_symbol_data_local.dart';

class graph_mildmonth extends StatefulWidget {
  const graph_mildmonth({Key? key}) : super(key: key);

  @override
  _graph_mildmonthState createState() => _graph_mildmonthState();
}

class _graph_mildmonthState extends State<graph_mildmonth> {
  String? uid;
  int sumSune = 0,
      sumMone = 0,
      sumTuee = 0,
      sumWede = 0,
      sumThue = 0,
      sumFrie = 0,
      sumSate = 0,
      sumSunm = 0,
      sumMonm = 0,
      sumTuem = 0,
      sumWedm = 0,
      sumThum = 0,
      sumFrim = 0,
      sumSatm = 0,
      sumSuns = 0,
      sumMons = 0,
      sumTues = 0,
      sumWeds = 0,
      sumThus = 0,
      sumFris = 0,
      sumSats = 0;
  int msec = 86400000, weekcount = 0, i = 0;
  List<String> selDaye = [];
  List<String> selDaym = [];
  List<String> selDays = [];
  // List<String> selDD = [];
  // List<int> vdatemonth = [1, 3, 5, 7, 8, 10, 12];
  int iie = 0, iiie = 0;
  int iim = 0, iiim = 0;
  int iis = 0, iiis = 0;
  String dateDaye = '',
      printYear2e = '',
      printYear3e = '',
      printYearMe = '';
  String dateDaym = '',
      printYear2m = '',
      printYear3m = '',
      printYearMm = '';
  String dateDays = '',
      printYear2s = '',
      printYear3s = '',
      printYearMs = '';
  int monthCounte = 0, isetae = 0, isetbe = 0;
  int monthCountm = 0, isetam = 0, isetbm = 0;
  int monthCounts = 0, isetas = 0, isetbs = 0;

  @override
  void initState() {
    super.initState();
    graphListe();
    selectmonthe();
    graphListm();
    selectmonthm();
    graphLists();
    selectmonths();
  }

  
  Future<void> selectmonthe() async {
    selDaye.clear();
    if (isetae % 2 == 0) {
      isetbe = 1;
    } else {
      isetbe = 7;
    }
    do {
      printYear3e = DateFormat('M').format(DateTime.fromMillisecondsSinceEpoch(
          Timestamp.fromDate(DateTime.now()).toDate().millisecondsSinceEpoch -
              (msec * iie) +
              (monthCounte * msec)));
      iie++;
    } while (int.parse(printYear3e) != isetbe);
    selDaye.add(DateFormat('MMM y').format(DateTime.fromMillisecondsSinceEpoch(
        Timestamp.fromDate(DateTime.now()).toDate().millisecondsSinceEpoch -
            (msec * iie) +
            (monthCounte * msec))));

    for (int i = 4; i >= 0; i--) {
      do {
        printYear2e = DateFormat('M').format(DateTime.fromMillisecondsSinceEpoch(
            Timestamp.fromDate(DateTime.now()).toDate().millisecondsSinceEpoch -
                (msec * iie) +
                (msec * iiie) +
                (monthCounte * msec)));
        iiie++;
      } while (printYear2e == printYear3e);
      selDaye.add(DateFormat('MMM y').format(DateTime.fromMillisecondsSinceEpoch(
          Timestamp.fromDate(DateTime.now()).toDate().millisecondsSinceEpoch -
              (msec * iie) +
              (msec * iiie) +
              (monthCounte * msec))));
      printYear3e = DateFormat('M').format(DateTime.fromMillisecondsSinceEpoch(
          Timestamp.fromDate(DateTime.now()).toDate().millisecondsSinceEpoch -
              (msec * iie) +
              (msec * iiie) +
              (monthCounte * msec)));

      printYearMe = DateFormat('y').format(DateTime.fromMillisecondsSinceEpoch(
          Timestamp.fromDate(DateTime.now()).toDate().millisecondsSinceEpoch -
              (msec * iie) +
              (msec * iiie) +
              (monthCounte * msec)));
      print('####selm $selDaye');
    }
  }

  Future graphListe() async {
    sumSune = 0;
    sumMone = 0;
    sumTuee = 0;
    sumWede = 0;
    sumThue = 0;
    sumFrie = 0;
    sumSate = 0;
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
            dateDaye = new DateFormat('MMM y').format(date);
            // if (dateDay == selDay[6]) {
            //   sumSun += model.sumScore;
            // } else
            if (dateDaye == selDaye[5]) {
              sumMone += model.sumScore;
            } else if (dateDaye == selDaye[4]) {
              sumTuee += model.sumScore;
            } else if (dateDaye == selDaye[3]) {
              sumWede += model.sumScore;
            } else if (dateDaye == selDaye[2]) {
              sumThue += model.sumScore;
            } else if (dateDaye == selDaye[1]) {
              sumFrie += model.sumScore;
            } else if (dateDaye == selDaye[0]) {
              sumSate += model.sumScore;
            }
          });
        }
      });
    });
  }
  Future<void> selectmonthm() async {
    selDaym.clear();
    if (isetam % 2 == 0) {
      isetbm = 1;
    } else {
      isetbm = 7;
    }
    do {
      printYear3m = DateFormat('M').format(DateTime.fromMillisecondsSinceEpoch(
          Timestamp.fromDate(DateTime.now()).toDate().millisecondsSinceEpoch -
              (msec * iim) +
              (monthCountm * msec)));
      iim++;
    } while (int.parse(printYear3m) != isetbm);
    selDaym.add(DateFormat('MMM y').format(DateTime.fromMillisecondsSinceEpoch(
        Timestamp.fromDate(DateTime.now()).toDate().millisecondsSinceEpoch -
            (msec * iim) +
            (monthCountm * msec))));

    for (int i = 4; i >= 0; i--) {
      do {
        printYear2m = DateFormat('M').format(DateTime.fromMillisecondsSinceEpoch(
            Timestamp.fromDate(DateTime.now()).toDate().millisecondsSinceEpoch -
                (msec * iim) +
                (msec * iiim) +
                (monthCountm * msec)));
        iiim++;
      } while (printYear2m == printYear3m);
      selDaym.add(DateFormat('MMM y').format(DateTime.fromMillisecondsSinceEpoch(
          Timestamp.fromDate(DateTime.now()).toDate().millisecondsSinceEpoch -
              (msec * iim) +
              (msec * iiim) +
              (monthCountm * msec))));
      printYear3m = DateFormat('M').format(DateTime.fromMillisecondsSinceEpoch(
          Timestamp.fromDate(DateTime.now()).toDate().millisecondsSinceEpoch -
              (msec * iim) +
              (msec * iiim) +
              (monthCountm * msec)));

      printYearMm = DateFormat('y').format(DateTime.fromMillisecondsSinceEpoch(
          Timestamp.fromDate(DateTime.now()).toDate().millisecondsSinceEpoch -
              (msec * iim) +
              (msec * iiim) +
              (monthCountm * msec)));
      print('####selmm $selDaym');
    }
  }
  Future graphListm() async {
    sumSunm = 0;
    sumMonm = 0;
    sumTuem = 0;
    sumWedm = 0;
    sumThum = 0;
    sumFrim = 0;
    sumSatm = 0;
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
            Timestamp time = model.playDate;
            var date = new DateTime.fromMicrosecondsSinceEpoch(
                time.microsecondsSinceEpoch);
            dateDaym = new DateFormat('MMM y').format(date);
            // if (dateDay == selDay[6]) {
            //   sumSun += model.sumScore;
            // } else
            if (dateDaym == selDaym[5]) {
              sumMonm += model.sumScore;
            } else if (dateDaym == selDaym[4]) {
              sumTuem += model.sumScore;
            } else if (dateDaym == selDaym[3]) {
              sumWedm += model.sumScore;
            } else if (dateDaym == selDaym[2]) {
              sumThum += model.sumScore;
            } else if (dateDaym == selDaym[1]) {
              sumFrim += model.sumScore;
            } else if (dateDaym == selDaym[0]) {
              sumSatm += model.sumScore;
            }
          });
        }
      });
    });
  }
  Future<void> selectmonths() async {
    selDays.clear();
    if (isetas % 2 == 0) {
      isetbs = 1;
    } else {
      isetbs = 7;
    }
    do {
      printYear3s = DateFormat('M').format(DateTime.fromMillisecondsSinceEpoch(
          Timestamp.fromDate(DateTime.now()).toDate().millisecondsSinceEpoch -
              (msec * iis) +
              (monthCounts * msec)));
      iis++;
    } while (int.parse(printYear3s) != isetbs);
    selDays.add(DateFormat('MMM y').format(DateTime.fromMillisecondsSinceEpoch(
        Timestamp.fromDate(DateTime.now()).toDate().millisecondsSinceEpoch -
            (msec * iis) +
            (monthCounts * msec))));

    for (int i = 4; i >= 0; i--) {
      do {
        printYear2s = DateFormat('M').format(DateTime.fromMillisecondsSinceEpoch(
            Timestamp.fromDate(DateTime.now()).toDate().millisecondsSinceEpoch -
                (msec * iis) +
                (msec * iiis) +
                (monthCounts * msec)));
        iiis++;
      } while (printYear2s == printYear3s);
      selDays.add(DateFormat('MMM y').format(DateTime.fromMillisecondsSinceEpoch(
          Timestamp.fromDate(DateTime.now()).toDate().millisecondsSinceEpoch -
              (msec * iis) +
              (msec * iiis) +
              (monthCounts * msec))));
      printYear3s = DateFormat('M').format(DateTime.fromMillisecondsSinceEpoch(
          Timestamp.fromDate(DateTime.now()).toDate().millisecondsSinceEpoch -
              (msec * iis) +
              (msec * iiis) +
              (monthCounts * msec)));

      printYearMs = DateFormat('y').format(DateTime.fromMillisecondsSinceEpoch(
          Timestamp.fromDate(DateTime.now()).toDate().millisecondsSinceEpoch -
              (msec * iis) +
              (msec * iiis) +
              (monthCounts * msec)));
      print('####sels $selDays');
    }
  }

  Future graphLists() async {
    sumSuns = 0;
    sumMons = 0;
    sumTues = 0;
    sumWeds = 0;
    sumThus = 0;
    sumFris = 0;
    sumSats = 0;
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
            Timestamp times = model.playDate;
            var dates = new DateTime.fromMicrosecondsSinceEpoch(
                times.microsecondsSinceEpoch);
            dateDays = new DateFormat('MMM y').format(dates);
            // if (dateDay == selDay[6]) {
            //   sumSun += model.sumScore;
            // } else
            if (dateDays == selDays[5]) {
              sumMons += model.sumScore;
            } else if (dateDays == selDays[4]) {
              sumTues += model.sumScore;
            } else if (dateDays == selDays[3]) {
              sumWeds += model.sumScore;
            } else if (dateDays == selDays[2]) {
              sumThus += model.sumScore;
            } else if (dateDays == selDays[1]) {
              sumFris += model.sumScore;
            } else if (dateDays == selDays[0]) {
              sumSats += model.sumScore;
            }
          });
        }
      });
    });
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
                              icon: const Icon(Icons.arrow_back_ios_new_rounded,
                                  size: 30),
                              onPressed: () {
                                setState(() {
                                  monthCounte -= 365 ~/ 2;
                                  isetae++;
                                  iie = 0;
                                  iiie = 0;
                                  selectmonthe();
                                  graphListe();

                                  // getstate2 = selDay[6];

                                  // weekcount += 7;

                                  // selDay.clear();
                                  // selectDay();

                                  // setselDD2 = true;
                                  // setstaree();

                                  print('###sel$selDaye');
                                });
                              },
                            ),
                            Text("คะแนนการออกกำลังกายในช่วง 7 วัน"),
                            IconButton(
                              icon: const Icon(Icons.arrow_forward_ios_rounded,
                                  size: 30),
                              onPressed: () {
                                setState(() {
                                  print('###sel$selDaye');
                                  monthCounte += 365 ~/ 2;
                                  isetae++;
                                  iie = 0;
                                  iiie = 0;
                                  selectmonthe();
                                  graphListe();
                                  // getstate2 = selDay[6];
                                  // weekcount -= 7;

                                  // selDay.clear();
                                  // setstaree();
                                  // setstarnext();
                                  // selectDay();
                                  // graphList();
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      SfCartesianChart(
                        title: ChartTitle(
                            text:
                                'กราฟแสดงการออกกำลังกายระดับ Mild ปี ${printYearMe}'),
                        legend: Legend(isVisible: false),
                        tooltipBehavior: TooltipBehavior(enable: true),
                        series: <ChartSeries>[
                          ColumnSeries<MildDatee, String>(
                              dataSource: [
                                // MildDate('${selDay[6].substring(0, 4)}', sumSun,
                                //     Colors.black),
                                MildDatee('${selDaye[0].substring(0, 4)}', sumSate,
                                    Colors.green.shade200),
                                MildDatee('${selDaye[1].substring(0, 4)}', sumFrie,
                                    Colors.green.shade300),
                                MildDatee('${selDaye[2].substring(0, 4)}', sumThue,
                                    Colors.green.shade400),
                                MildDatee('${selDaye[3].substring(0, 4)}', sumWede,
                                    Colors.green.shade500),
                                MildDatee('${selDaye[4].substring(0, 4)}', sumTuee,
                                    Colors.green.shade600),
                                MildDatee('${selDaye[5].substring(0, 4)}', sumMone,
                                    Colors.green.shade700),
                              ],
                              xValueMapper: (MildDatee score, _) =>
                                  score.playDate,
                              yValueMapper: (MildDatee score, _) => score.score,
                              dataLabelSettings:
                                  DataLabelSettings(isVisible: true),
                              pointColorMapper: (MildDatee data, _) => data.color
                              // enableTooltip: true
                              )
                        ],
                        primaryXAxis: CategoryAxis(),
                        primaryYAxis: NumericAxis(
                            edgeLabelPlacement: EdgeLabelPlacement.shift,
                            // numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0),
                            title: AxisTitle(text: 'คะแนนระดับ Mild')),
                      ),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.green,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_back_ios_new_rounded,
                                  size: 30),
                              onPressed: () {
                                setState(() {
                                  monthCountm -= 365 ~/ 2;
                                  isetam++;
                                  iim = 0;
                                  iiim = 0;
                                  selectmonthm();
                                  graphListm();

                                  // getstate2 = selDay[6];

                                  // weekcount += 7;

                                  // selDay.clear();
                                  // selectDay();

                                  // setselDD2 = true;
                                  // setstaree();

                                  print('###sel$selDaym');
                                });
                              },
                            ),
                            Text("คะแนนการออกกำลังกายในช่วง 7 วัน"),
                            IconButton(
                              icon: const Icon(Icons.arrow_forward_ios_rounded,
                                  size: 30),
                              onPressed: () {
                                setState(() {
                                  print('###sel$selDaym');
                                  monthCountm += 365 ~/ 2;
                                  isetam++;
                                  iim = 0;
                                  iiim = 0;
                                  selectmonthm();
                                  graphListm();
                                  // getstate2 = selDay[6];
                                  // weekcount -= 7;

                                  // selDay.clear();
                                  // setstaree();
                                  // setstarnext();
                                  // selectDay();
                                  // graphList();
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      SfCartesianChart(
                        title: ChartTitle(
                            text:
                                'กราฟแสดงการออกกำลังกายระดับ moderate ปี ${printYearMm}'),
                        legend: Legend(isVisible: false),
                        tooltipBehavior: TooltipBehavior(enable: true),
                        series: <ChartSeries>[
                          ColumnSeries<MildDatem, String>(
                              dataSource: [
                                // MildDate('${selDay[6].substring(0, 4)}', sumSun,
                                //     Colors.black),
                                MildDatem('${selDaym[0].substring(0, 4)}', sumSatm,
                                    Colors.green.shade200),
                                MildDatem('${selDaym[1].substring(0, 4)}', sumFrim,
                                    Colors.green.shade300),
                                MildDatem('${selDaym[2].substring(0, 4)}', sumThum,
                                    Colors.green.shade400),
                                MildDatem('${selDaym[3].substring(0, 4)}', sumWedm,
                                    Colors.green.shade500),
                                MildDatem('${selDaym[4].substring(0, 4)}', sumTuem,
                                    Colors.green.shade600),
                                MildDatem('${selDaym[5].substring(0, 4)}', sumMonm,
                                    Colors.green.shade700),
                              ],
                              xValueMapper: (MildDatem score, _) =>
                                  score.playDate,
                              yValueMapper: (MildDatem score, _) => score.score,
                              dataLabelSettings:
                                  DataLabelSettings(isVisible: true),
                              pointColorMapper: (MildDatem data, _) => data.color
                              // enableTooltip: true
                              )
                        ],
                        primaryXAxis: CategoryAxis(),
                        primaryYAxis: NumericAxis(
                            edgeLabelPlacement: EdgeLabelPlacement.shift,
                            // numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0),
                            title: AxisTitle(text: 'คะแนนระดับ moderate')),
                      ),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.green,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_back_ios_new_rounded,
                                  size: 30),
                              onPressed: () {
                                setState(() {
                                  monthCounts -= 365 ~/ 2;
                                  isetas++;
                                  iis = 0;
                                  iiis = 0;
                                  selectmonths();
                                  graphLists();

                                  // getstate2 = selDay[6];

                                  // weekcount += 7;

                                  // selDay.clear();
                                  // selectDay();

                                  // setselDD2 = true;
                                  // setstaree();

                                  print('###selss$selDays');
                                });
                              },
                            ),
                            Text("คะแนนการออกกำลังกายในช่วง 7 วัน"),
                            IconButton(
                              icon: const Icon(Icons.arrow_forward_ios_rounded,
                                  size: 30),
                              onPressed: () {
                                setState(() {
                                  print('###selss$selDays');
                                  monthCounts += 365 ~/ 2;
                                  isetas++;
                                  iis = 0;
                                  iiis = 0;
                                  selectmonths();
                                  graphLists();
                                  // getstate2 = selDay[6];
                                  // weekcount -= 7;

                                  // selDay.clear();
                                  // setstaree();
                                  // setstarnext();
                                  // selectDay();
                                  // graphList();
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      SfCartesianChart(
                        title: ChartTitle(
                            text:
                                'กราฟแสดงการออกกำลังกายระดับ stenuouns ปี ${printYearMs}'),
                        legend: Legend(isVisible: false),
                        tooltipBehavior: TooltipBehavior(enable: true),
                        series: <ChartSeries>[
                          ColumnSeries<MildDates, String>(
                              dataSource: [
                                // MildDate('${selDay[6].substring(0, 4)}', sumSun,
                                //     Colors.black),
                                MildDates('${selDays[0].substring(0, 4)}', sumSats,
                                    Colors.green.shade200),
                                MildDates('${selDays[1].substring(0, 4)}', sumFris,
                                    Colors.green.shade300),
                                MildDates('${selDays[2].substring(0, 4)}', sumThus,
                                    Colors.green.shade400),
                                MildDates('${selDays[3].substring(0, 4)}', sumWeds,
                                    Colors.green.shade500),
                                MildDates('${selDays[4].substring(0, 4)}', sumTues,
                                    Colors.green.shade600),
                                MildDates('${selDays[5].substring(0, 4)}', sumMons,
                                    Colors.green.shade700),
                              ],
                              xValueMapper: (MildDates score, _) =>
                                  score.playDate,
                              yValueMapper: (MildDates score, _) => score.score,
                              dataLabelSettings:
                                  DataLabelSettings(isVisible: true),
                              pointColorMapper: (MildDates data, _) => data.color
                              // enableTooltip: true
                              )
                        ],
                        primaryXAxis: CategoryAxis(),
                        primaryYAxis: NumericAxis(
                            edgeLabelPlacement: EdgeLabelPlacement.shift,
                            // numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0),
                            title: AxisTitle(text: 'คะแนนระดับ strenuouns')),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MildDatee {
  MildDatee(this.playDate, this.score, this.color);
  final String playDate;
  final num score;
  final Color color;
}
class MildDatem {
  MildDatem(this.playDate, this.score, this.color);
  final String playDate;
  final num score;
  final Color color;
}
class MildDates {
  MildDates(this.playDate, this.score, this.color);
  final String playDate;
  final num score;
  final Color color;
}
