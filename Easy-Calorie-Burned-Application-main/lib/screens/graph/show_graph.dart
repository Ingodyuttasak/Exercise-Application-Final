// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_final/model/score_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class showGraphS extends StatefulWidget {
  const showGraphS({Key? key}) : super(key: key);

  @override
  State<showGraphS> createState() => _showGraphSState();
}

class _showGraphSState extends State<showGraphS> {
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

  String? dateDay, dateDay1, dateDay2;
  String dateT = '', printYear1 = '', printYear2 = '', printYear3 = '';

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

  List<String> selDaye = [];
  List<String> selDaym = [];
  List<String> selDays = [];

  int iie = 0, iiie = 0;
  int iim = 0, iiim = 0;
  int iis = 0, iiis = 0;
  String dateDaye = '', printYear2e = '', printYear3e = '', printYearMe = '';
  String dateDaym = '', printYear2m = '', printYear3m = '', printYearMm = '';
  String dateDays = '', printYear2s = '', printYear3s = '', printYearMs = '';
  int monthCounte = 0, isetae = 0, isetbe = 0;
  int monthCountm = 0, isetam = 0, isetbm = 0;
  int monthCounts = 0, isetas = 0, isetbs = 0;

  Future selectDay() async {
    selDay.clear();
    for (int i = 6; i >= 0; i--) {
      selDay.add(DateFormat('EEE d MMM y').format(
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
      selDay1.add(DateFormat('EEE d MMM y').format(
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
      selDay2.add(DateFormat('EEE d MMM y').format(
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
      

      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('mildScore')
          .get()
          .then((value) {
        for (var item in value.docs) {
          ScoreModel model = ScoreModel.fromMap(item.data());
          
          setState(() {
            Timestamp time = model.playDate;
            var date = new DateTime.fromMicrosecondsSinceEpoch(
                time.microsecondsSinceEpoch);

            dateDay = new DateFormat('EEE d MMM y').format(date);

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
      

      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('moderateScore')
          .get()
          .then((value) {
        for (var item in value.docs) {
          ScoreModel model = ScoreModel.fromMap(item.data());
          
          setState(() {
            // grahMild1.add(model);
            Timestamp time = model.playDate;
            var date = new DateTime.fromMicrosecondsSinceEpoch(
                time.microsecondsSinceEpoch);
            dateDay1 = new DateFormat('EEE d MMM y').format(date);

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
     

      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('strenuousScore')
          .get()
          .then((value) {
        for (var item in value.docs) {
          ScoreModel model = ScoreModel.fromMap(item.data());
          
          setState(() {
            Timestamp time = model.playDate;
            var date = new DateTime.fromMicrosecondsSinceEpoch(
                time.microsecondsSinceEpoch);
            dateDay2 = new DateFormat('EEE d MMM y').format(date);
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
        printYear2e = DateFormat('M').format(
            DateTime.fromMillisecondsSinceEpoch(
                Timestamp.fromDate(DateTime.now())
                        .toDate()
                        .millisecondsSinceEpoch -
                    (msec * iie) +
                    (msec * iiie) +
                    (monthCounte * msec)));
        iiie++;
      } while (printYear2e == printYear3e);
      selDaye.add(DateFormat('MMM y').format(
          DateTime.fromMillisecondsSinceEpoch(Timestamp.fromDate(DateTime.now())
                  .toDate()
                  .millisecondsSinceEpoch -
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
        printYear2m = DateFormat('M').format(
            DateTime.fromMillisecondsSinceEpoch(
                Timestamp.fromDate(DateTime.now())
                        .toDate()
                        .millisecondsSinceEpoch -
                    (msec * iim) +
                    (msec * iiim) +
                    (monthCountm * msec)));
        iiim++;
      } while (printYear2m == printYear3m);
      selDaym.add(DateFormat('MMM y').format(
          DateTime.fromMillisecondsSinceEpoch(Timestamp.fromDate(DateTime.now())
                  .toDate()
                  .millisecondsSinceEpoch -
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
        printYear2s = DateFormat('M').format(
            DateTime.fromMillisecondsSinceEpoch(
                Timestamp.fromDate(DateTime.now())
                        .toDate()
                        .millisecondsSinceEpoch -
                    (msec * iis) +
                    (msec * iiis) +
                    (monthCounts * msec)));
        iiis++;
      } while (printYear2s == printYear3s);
      selDays.add(DateFormat('MMM y').format(
          DateTime.fromMillisecondsSinceEpoch(Timestamp.fromDate(DateTime.now())
                  .toDate()
                  .millisecondsSinceEpoch -
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

  @override
  void initState() {
    super.initState();

    graphList();
    graphList1();
    graphList2();

    selectDay();
    selectDay1();
    selectDay2();

    graphListe();
    selectmonthe();
    graphListm();
    selectmonthm();
    graphLists();
    selectmonths();
  }

  Widget build(BuildContext context) => DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.blue[900],
            foregroundColor: Colors.black,
            title: Text(
              "กราฟแสดงการออกกำลังกาย",
              style: TextStyle(color: Colors.white),
            ),
            bottom: TabBar(
                labelColor: Colors.blue[900],
                unselectedLabelColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    color: Colors.white),
                // ignore: prefer_const_literals_to_create_immutables
                tabs: [
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("รายวัน"),
                    ),
                  ),
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("รายเดือน"),
                    ),
                  ),
                ]),
          ),
          body: TabBarView(
            children: [
              //day
              Scaffold(
                backgroundColor: Colors.white,
                body: SingleChildScrollView(
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 40,
                            width: 160,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                color: Colors.green[300]),
                            child: Center(
                                child: Text(
                              "ระดับ Mild",
                              style: TextStyle(fontSize: 20),
                            )),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.green[50],
                                border: Border(
                                    bottom: BorderSide(
                                  color: Colors.green.shade300,
                                  width: 2,
                                ))),
                            child: Column(
                              children: [
                                Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.green[200],
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                            Icons.arrow_back_ios_new_rounded,
                                            size: 30),
                                        onPressed: () {
                                          setState(() {
                                            weekcount += 7;
                                            selectDay();
                                            graphList();
                                          });
                                        },
                                      ),
                                      Text("${selDay[0]} - ${selDay[6]}"),
                                      IconButton(
                                        icon: const Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            size: 30),
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
                                  title: ChartTitle(
                                      text:
                                          'กราฟแสดงการออกกำลังกายระดับ Mild รายวัน',
                                      textStyle: TextStyle(fontSize: 12)),
                                  legend: Legend(isVisible: false),
                                  tooltipBehavior:
                                      TooltipBehavior(enable: true),
                                  series: <ChartSeries>[
                                    ColumnSeries<MildDate, String>(
                                        dataSource: [
                                          MildDate(
                                              selDay[0].substring(4, 10),
                                              sumSun,
                                              Colors.lightGreen.shade300),
                                          MildDate(
                                              selDay[1].substring(4, 10),
                                              sumMon,
                                              Colors.lightGreen.shade400),
                                          MildDate(
                                              selDay[2].substring(4, 10),
                                              sumTue,
                                              Colors.lightGreen.shade500),
                                          MildDate(
                                              selDay[3].substring(4, 10),
                                              sumWed,
                                              Colors.lightGreen.shade600),
                                          MildDate(
                                              selDay[4].substring(4, 10),
                                              sumThu,
                                              Colors.lightGreen.shade700),
                                          MildDate(
                                              selDay[5].substring(4, 10),
                                              sumFri,
                                              Colors.lightGreen.shade800),
                                          MildDate(
                                              selDay[6].substring(4, 10),
                                              sumSat,
                                              Colors.lightGreen.shade900),
                                        ],
                                        xValueMapper: (MildDate score, _) =>
                                            score.playDate,
                                        yValueMapper: (MildDate score, _) =>
                                            score.score,
                                        dataLabelSettings:
                                            DataLabelSettings(isVisible: true),
                                        pointColorMapper: (MildDate data, _) =>
                                            data.color
                                        // enableTooltip: true
                                        )
                                  ],
                                  primaryXAxis: CategoryAxis(),
                                  primaryYAxis: NumericAxis(
                                      edgeLabelPlacement:
                                          EdgeLabelPlacement.shift,
                                      // numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0),
                                      title:
                                          AxisTitle(text: 'คะแนนระดับ Mild')),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            height: 40,
                            width: 160,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                color: Colors.yellow[300]),
                            child: Center(
                                child: Text(
                              "ระดับ Moderate",
                              style: TextStyle(fontSize: 20),
                            )),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.yellow[50],
                                border: Border(
                                    bottom: BorderSide(
                                  color: Colors.yellow.shade300,
                                  width: 2,
                                ))),
                            child: Column(
                              children: [
                                Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.yellow[200],
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                            Icons.arrow_back_ios_new_rounded,
                                            size: 30),
                                        onPressed: () {
                                          setState(() {
                                            weekcount1 += 7;
                                            selectDay1();
                                            graphList1();
                                          });
                                        },
                                      ),
                                      Text("${selDay1[0]} - ${selDay1[6]}"),
                                      IconButton(
                                        icon: const Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            size: 30),
                                        onPressed: () {
                                          setState(() {
                                            weekcount1 -= 7;
                                            selectDay1();
                                            graphList1();
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                SfCartesianChart(
                                  title: ChartTitle(
                                      text: 'กราฟแสดงการออกกำลังกายระดับ Moderate รายวัน' ,textStyle: TextStyle(fontSize: 12)),
                                  legend: Legend(isVisible: false),
                                  tooltipBehavior:
                                      TooltipBehavior(enable: true),
                                  series: <ChartSeries>[
                                    ColumnSeries<MildDate1, String>(
                                        dataSource: [
                                          MildDate1(selDay1[0].substring(4, 10),
                                              sumSun1, Colors.yellow.shade300),
                                          MildDate1(selDay1[1].substring(4, 10),
                                              sumMon1, Colors.yellow.shade400),
                                          MildDate1(selDay1[2].substring(4, 10),
                                              sumTue1, Colors.yellow.shade500),
                                          MildDate1(selDay1[3].substring(4, 10),
                                              sumWed1, Colors.yellow.shade600),
                                          MildDate1(selDay1[4].substring(4, 10),
                                              sumThu1, Colors.yellow.shade700),
                                          MildDate1(selDay1[5].substring(4, 10),
                                              sumFri1, Colors.yellow.shade800),
                                          MildDate1(selDay1[6].substring(4, 10),
                                              sumSat1, Colors.yellow.shade900),
                                        ],
                                        xValueMapper: (MildDate1 score, _) =>
                                            score.playDate,
                                        yValueMapper: (MildDate1 score, _) =>
                                            score.score,
                                        dataLabelSettings:
                                            DataLabelSettings(isVisible: true),
                                        pointColorMapper: (MildDate1 data, _) =>
                                            data.color
                                        // enableTooltip: true
                                        )
                                  ],
                                  primaryXAxis: CategoryAxis(),
                                  primaryYAxis: NumericAxis(
                                      edgeLabelPlacement:
                                          EdgeLabelPlacement.shift,
                                      // numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0),
                                      title: AxisTitle(
                                          text: 'คะแนนระดับ Moderate')),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            height: 40,
                            width: 160,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                color: Colors.red[300]),
                            child: Center(
                                child: Text(
                              "ระดับ Strenuous",
                              style: TextStyle(fontSize: 20),
                            )),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.red[50],
                                border: Border(
                                    bottom: BorderSide(
                                  color: Colors.red.shade300,
                                  width: 2,
                                ))),
                            child: Column(
                              children: [
                                Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.red[200],
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                            Icons.arrow_back_ios_new_rounded,
                                            size: 30),
                                        onPressed: () {
                                          setState(() {
                                            weekcount2 += 7;
                                            selectDay2();
                                            graphList2();
                                          });
                                        },
                                      ),
                                      Text("${selDay2[0]} - ${selDay2[6]}"),
                                      IconButton(
                                        icon: const Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            size: 30),
                                        onPressed: () {
                                          setState(() {
                                            weekcount2 -= 7;
                                            selectDay2();
                                            graphList2();
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                SfCartesianChart(
                                  title: ChartTitle(
                                      text: 'กราฟแสดงการออกกำลังกายระดับ Strenuous รายวัน' ,textStyle: TextStyle(fontSize: 12)),
                                  legend: Legend(isVisible: false),
                                  tooltipBehavior:
                                      TooltipBehavior(enable: true),
                                  series: <ChartSeries>[
                                    ColumnSeries<MildDate2, String>(
                                        dataSource: [
                                          MildDate2(selDay2[0].substring(4, 10),
                                              sumSun2, Colors.red.shade100),
                                          MildDate2(selDay2[1].substring(4, 10),
                                              sumMon2, Colors.red.shade200),
                                          MildDate2(selDay2[2].substring(4, 10),
                                              sumTue2, Colors.red.shade300),
                                          MildDate2(selDay2[3].substring(4, 10),
                                              sumWed2, Colors.red.shade400),
                                          MildDate2(selDay2[4].substring(4, 10),
                                              sumThu2, Colors.red.shade500),
                                          MildDate2(selDay2[5].substring(4, 10),
                                              sumFri2, Colors.red.shade600),
                                          MildDate2(selDay2[6].substring(4, 10),
                                              sumSat2, Colors.red.shade700),
                                        ],
                                        xValueMapper: (MildDate2 score, _) =>
                                            score.playDate,
                                        yValueMapper: (MildDate2 score, _) =>
                                            score.score,
                                        dataLabelSettings:
                                            DataLabelSettings(isVisible: true),
                                        pointColorMapper: (MildDate2 data, _) =>
                                            data.color
                                        // enableTooltip: true
                                        )
                                  ],
                                  primaryXAxis: CategoryAxis(),
                                  primaryYAxis: NumericAxis(
                                      edgeLabelPlacement:
                                          EdgeLabelPlacement.shift,
                                      // numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0),
                                      title:
                                          AxisTitle(text: 'คะแนนเฉลี่ยต่อวัน')),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              //month
              Scaffold(
                body: SingleChildScrollView(
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 40,
                            width: 160,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                color: Colors.green[300]),
                            child: Center(
                                child: Text(
                              "ระดับ Mild",
                              style: TextStyle(fontSize: 20),
                            )),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.green[50],
                                border: Border(
                                    bottom: BorderSide(
                                  color: Colors.green.shade300,
                                  width: 2,
                                ))),
                            child: Column(
                              children: [
                                Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.green[200],
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                            Icons.arrow_back_ios_new_rounded,
                                            size: 30),
                                        onPressed: () {
                                          setState(() {
                                            monthCounte -= 365 ~/ 2;
                                            isetae++;
                                            iie = 0;
                                            iiie = 0;
                                            selectmonthe();
                                            graphListe();
                                            print('###sel$selDaye');
                                          });
                                        },
                                      ),
                                      Text("${selDaye[0]} - ${selDaye[5]}"),
                                      IconButton(
                                        icon: const Icon(
                                            Icons.arrow_forward_ios_rounded,
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
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                SfCartesianChart(
                                  title: ChartTitle(
                                      text:
                                         'กราฟแสดงการออกกำลังกายระดับ Mild รายเดือน' ,textStyle: TextStyle(fontSize: 12)),
                                  legend: Legend(isVisible: false),
                                  tooltipBehavior:
                                      TooltipBehavior(enable: true),
                                  series: <ChartSeries>[
                                    ColumnSeries<MildDatee, String>(
                                        dataSource: [
                                          // MildDate('${selDay[6].substring(0, 4)}', sumSun,
                                          //     Colors.black),
                                          MildDatee(
                                              '${selDaye[0].substring(0, 4)}',
                                              sumSate,
                                              Colors.green.shade200),
                                          MildDatee(
                                              '${selDaye[1].substring(0, 4)}',
                                              sumFrie,
                                              Colors.green.shade300),
                                          MildDatee(
                                              '${selDaye[2].substring(0, 4)}',
                                              sumThue,
                                              Colors.green.shade400),
                                          MildDatee(
                                              '${selDaye[3].substring(0, 4)}',
                                              sumWede,
                                              Colors.green.shade500),
                                          MildDatee(
                                              '${selDaye[4].substring(0, 4)}',
                                              sumTuee,
                                              Colors.green.shade600),
                                          MildDatee(
                                              '${selDaye[5].substring(0, 4)}',
                                              sumMone,
                                              Colors.green.shade700),
                                        ],
                                        xValueMapper: (MildDatee score, _) =>
                                            score.playDate,
                                        yValueMapper: (MildDatee score, _) =>
                                            score.score,
                                        dataLabelSettings:
                                            DataLabelSettings(isVisible: true),
                                        pointColorMapper: (MildDatee data, _) =>
                                            data.color
                                        // enableTooltip: true
                                        )
                                  ],
                                  primaryXAxis: CategoryAxis(),
                                  primaryYAxis: NumericAxis(
                                      edgeLabelPlacement:
                                          EdgeLabelPlacement.shift,
                                      // numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0),
                                      title:
                                          AxisTitle(text: 'คะแนนระดับ Mild')),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            height: 40,
                            width: 160,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                color: Colors.yellow[300]),
                            child: Center(
                                child: Text(
                              "ระดับ Moderate",
                              style: TextStyle(fontSize: 20),
                            )),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.yellow[50],
                                border: Border(
                                    bottom: BorderSide(
                                  color: Colors.yellow.shade300,
                                  width: 2,
                                ))),
                            child: Column(
                              children: [
                                Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.yellow[200],
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                            Icons.arrow_back_ios_new_rounded,
                                            size: 30),
                                        onPressed: () {
                                          setState(() {
                                            monthCountm -= 365 ~/ 2;
                                            isetam++;
                                            iim = 0;
                                            iiim = 0;
                                            selectmonthm();
                                            graphListm();
                                          });
                                        },
                                      ),
                                      Text("${selDaym[0]} - ${selDaym[5]}"),
                                      IconButton(
                                        icon: const Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            size: 30),
                                        onPressed: () {
                                          setState(() {
                                            monthCountm += 365 ~/ 2;
                                            isetam++;
                                            iim = 0;
                                            iiim = 0;
                                            selectmonthm();
                                            graphListm();
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                SfCartesianChart(
                                  title: ChartTitle(
                                      text:
                                          'กราฟแสดงการออกกำลังกายระดับ Moderate รายเดือน' ,textStyle: TextStyle(fontSize: 12)),
                                  legend: Legend(isVisible: false),
                                  tooltipBehavior:
                                      TooltipBehavior(enable: true),
                                  series: <ChartSeries>[
                                    ColumnSeries<MildDatem, String>(
                                        dataSource: [
                                          // MildDate('${selDay[6].substring(0, 4)}', sumSun,
                                          //     Colors.black),
                                          MildDatem(
                                              '${selDaym[0].substring(0, 4)}',
                                              sumSatm,
                                              Colors.yellow.shade200),
                                          MildDatem(
                                              '${selDaym[1].substring(0, 4)}',
                                              sumFrim,
                                              Colors.yellow.shade300),
                                          MildDatem(
                                              '${selDaym[2].substring(0, 4)}',
                                              sumThum,
                                              Colors.yellow.shade400),
                                          MildDatem(
                                              '${selDaym[3].substring(0, 4)}',
                                              sumWedm,
                                              Colors.yellow.shade500),
                                          MildDatem(
                                              '${selDaym[4].substring(0, 4)}',
                                              sumTuem,
                                              Colors.yellow.shade600),
                                          MildDatem(
                                              '${selDaym[5].substring(0, 4)}',
                                              sumMonm,
                                              Colors.yellow.shade700),
                                        ],
                                        xValueMapper: (MildDatem score, _) =>
                                            score.playDate,
                                        yValueMapper: (MildDatem score, _) =>
                                            score.score,
                                        dataLabelSettings:
                                            DataLabelSettings(isVisible: true),
                                        pointColorMapper: (MildDatem data, _) =>
                                            data.color
                                        // enableTooltip: true
                                        )
                                  ],
                                  primaryXAxis: CategoryAxis(),
                                  primaryYAxis: NumericAxis(
                                      edgeLabelPlacement:
                                          EdgeLabelPlacement.shift,
                                      // numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0),
                                      title: AxisTitle(
                                          text: 'คะแนนระดับ moderate')),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            height: 40,
                            width: 160,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                color: Colors.red[300]),
                            child: Center(
                                child: Text(
                              "ระดับ Strenuous",
                              style: TextStyle(fontSize: 20),
                            )),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.red[50],
                                border: Border(
                                    bottom: BorderSide(
                                  color: Colors.red.shade300,
                                  width: 2,
                                ))),
                            child: Column(
                              children: [
                                Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.red[200],
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                            Icons.arrow_back_ios_new_rounded,
                                            size: 30),
                                        onPressed: () {
                                          setState(() {
                                            monthCounts -= 365 ~/ 2;
                                            isetas++;
                                            iis = 0;
                                            iiis = 0;
                                            selectmonths();
                                            graphLists();
                                          });
                                        },
                                      ),
                                      Text("${selDays[0]} - ${selDays[5]}"),
                                      IconButton(
                                        icon: const Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            size: 30),
                                        onPressed: () {
                                          setState(() {
                                            monthCounts += 365 ~/ 2;
                                            isetas++;
                                            iis = 0;
                                            iiis = 0;
                                            selectmonths();
                                            graphLists();
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                SfCartesianChart(
                                  title: ChartTitle(
                                      text:
                                          'กราฟแสดงการออกกำลังกายระดับ Strenuous รายเดือน' ,textStyle: TextStyle(fontSize: 12)),
                                  legend: Legend(isVisible: false),
                                  tooltipBehavior:
                                      TooltipBehavior(enable: true),
                                  series: <ChartSeries>[
                                    ColumnSeries<MildDates, String>(
                                        dataSource: [
                                          // MildDate('${selDay[6].substring(0, 4)}', sumSun,
                                          //     Colors.black),
                                          MildDates(
                                              '${selDays[0].substring(0, 4)}',
                                              sumSats,
                                              Colors.red.shade200),
                                          MildDates(
                                              '${selDays[1].substring(0, 4)}',
                                              sumFris,
                                              Colors.red.shade300),
                                          MildDates(
                                              '${selDays[2].substring(0, 4)}',
                                              sumThus,
                                              Colors.red.shade400),
                                          MildDates(
                                              '${selDays[3].substring(0, 4)}',
                                              sumWeds,
                                              Colors.red.shade500),
                                          MildDates(
                                              '${selDays[4].substring(0, 4)}',
                                              sumTues,
                                              Colors.red.shade600),
                                          MildDates(
                                              '${selDays[5].substring(0, 4)}',
                                              sumMons,
                                              Colors.red.shade700),
                                        ],
                                        xValueMapper: (MildDates score, _) =>
                                            score.playDate,
                                        yValueMapper: (MildDates score, _) =>
                                            score.score,
                                        dataLabelSettings:
                                            DataLabelSettings(isVisible: true),
                                        pointColorMapper: (MildDates data, _) =>
                                            data.color
                                        // enableTooltip: true
                                        )
                                  ],
                                  primaryXAxis: CategoryAxis(),
                                  primaryYAxis: NumericAxis(
                                      edgeLabelPlacement:
                                          EdgeLabelPlacement.shift,
                                      // numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0),
                                      title: AxisTitle(
                                          text: 'คะแนนระดับ strenuouns')),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}

//Class ของกราฟ
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

//class ของรายเดือน
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


