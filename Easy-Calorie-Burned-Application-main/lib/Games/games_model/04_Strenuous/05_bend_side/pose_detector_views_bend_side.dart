import 'dart:async';
import 'dart:math';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit_bend_side/google_ml_kit.dart';
import 'package:mobile_final/Games/Gamescore/strenuous_showScore.dart';
import 'package:mobile_final/Games/games_model/04_Strenuous/strenuous_countdown_nextpage.dart';
import 'package:mobile_final/model/score_model.dart';
import 'package:mobile_final/model/user_model.dart';
import 'camera_view.dart';
import 'painters/pose_painter.dart';

class PoseDetectorView_bend_side extends StatefulWidget {
  final bool useClassifier;
  final bool isActivity;
  final int scoreSum;
  final int getplaytime;
  final int setStep;

  const PoseDetectorView_bend_side({
    this.useClassifier = true,
    this.isActivity = true,
    this.scoreSum = 0,
    this.getplaytime = 0,
    this.setStep = 0,
  });

  @override
  State<StatefulWidget> createState() => _PoseDetectorViewState();
}

class _PoseDetectorViewState extends State<PoseDetectorView_bend_side> {
  PoseDetector poseDetector = GoogleMlKit.vision.poseDetector();
  bool isBusy = false;
  CustomPaint? customPaint;
  String poseName = "";
  double poseAccuracy = 0.0;
  int poseReps = 0;
  int test = 0;
  bool _running = true;
  int playTime = 0;
  UserModel? userModel; //! ตัวเราเอง
  String? uidMe; //! uid ของเรา
  String? uid; //! uid เรา

  final assetsAudioPlayer = AssetsAudioPlayer();

  @override
  void initState() {
    super.initState();
    assAudio();
    findUid();
    movePage();
    autoPlayTime();
  }

  Future assAudio() async {
    int ci = Random().nextInt(4);
    assetsAudioPlayer.open(
      Audio("assets/audio/NCS_mix_20_0${ci + 2}.mp3"),
      loopMode: LoopMode.single,
    );
    assetsAudioPlayer.play();
  }

  Future findUid() async {
    await FirebaseAuth.instance.authStateChanges().listen((event) async {
      uidMe = event!.uid;
      print('## uid = $uidMe');
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uidMe)
          .get()
          .then((value) {
        setState(() {
          userModel = UserModel.fromMap(value.data()!);
        });
      });

      print('${userModel == null ? '## null' : '## ${userModel!.imageUrl}'}');
    });
  }

  Future<void> autoPlayTime() async {
    Duration duration = Duration(seconds: 1);
    // ignore: await_only_futures
    await Timer(duration, () {
      setState(() {
        playTime++;
      });
      autoPlayTime();
    });
  }

  Future movePage() async {
    while (_running) {
      await Future<void>.delayed(const Duration(seconds: 1));
      if (playTime >= 60) {
        // if (playTime >= 5) {
        if (true) {
          // if (poseReps >= 0) {
          _running = false;
          assetsAudioPlayer.stop();

          int sumScore = 0;
          DateTime dateTime = DateTime.now();
          Timestamp playDate = Timestamp.fromDate(dateTime);
          ScoreModel model = ScoreModel(sumScore, playTime, playDate);

          int timeSum = playTime;
          int _sumScore = widget.scoreSum;

          // rep * timeset/playtime*difficulty
          int a_sumScore = poseReps * 15 * 9;
          a_sumScore ~/= timeSum;
          _sumScore += a_sumScore;

          // sum time send to next class
          playTime += widget.getplaytime;

          // playTime = 827;
          // _sumScore = 315;

          num sumplayTime = playTime;

          print(
              "##############sum05 setstep${widget.setStep}, sumscore= $_sumScore, sumtime =$playTime, timeset = $timeSum, scoreset= $a_sumScore, poseReps= $poseReps");
          
          if (widget.setStep == 15) {
            await FirebaseFirestore.instance
                .collection('users')
                .doc(uidMe)
                .collection('strenuousScore')
                .doc(
                    '${dateTime.year}${dateTime.month < 10 ? '0' : ''}${dateTime.month}${dateTime.day < 10 ? '0' : ''}${dateTime.day}${dateTime.hour < 10 ? '0' : ''}${dateTime.hour}${dateTime.minute < 10 ? '0' : ''}${dateTime.minute}')
                .set({
              'sumScore': _sumScore,
              'playTime': sumplayTime,
              'playDate': playDate
            });
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => strenuous_showscore()),
                (Route<dynamic> route) => false);
          } else {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        strenuous_countdown_nextpage(
                          // PoseDetectorView_bend_side(
                          scoreSum: _sumScore,
                          getplaytime: playTime,
                          setstep: widget.setStep,
                        )),
                (Route<dynamic> route) => false);
          }
        }
      }
    }
  }

  void dispose() async {
    super.dispose();
    await poseDetector.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[300],
      body: Container(
        child: Stack(
          children: [
            CameraView(
              customPaint: customPaint,
              onImage: (inputImage) {
                processImage(
                  inputImage,
                  widget.useClassifier,
                  widget.isActivity,
                );
              },
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 140,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.red[300],
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Bend side",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            // Icon(Icons.class_),
                            Image(
                              image: AssetImage("assets/images/exercise.png"),
                              // color: Colors.black,
                              height: 30,
                              width: 30,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.amber[200],
                                ),
                                child: Text(' $poseName',
                                    style: TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Image(
                              image: AssetImage(
                                  "${poseAccuracy * 100 >= 60 ? 'assets/images/correct.png' : 'assets/images/noncorrect.png'}"),
                              // color: Colors.black,
                              height: 30,
                              width: 30,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.amber[200],
                                ),
                                child: Text(' $poseAccuracy',
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Image(
                              image: AssetImage("assets/images/counter.png"),
                              // color: Colors.black,
                              height: 30,
                              width: 30,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.amber[200],
                                ),
                                child: Text(
                                    '  ${poseReps > 0 ? '$poseReps times' : '0 time'}',
                                    style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Image(
                              image: AssetImage("assets/images/stopwatch.png"),
                              // color: Colors.green,
                              height: 30,
                              width: 30,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.amber[200],
                                ),
                                child: Text('  $playTime s',
                                    style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> processImage(
    InputImage inputImage,
    bool useClassifier,
    bool isActivity,
  ) async {
    if (isBusy) return;
    isBusy = true;
    final poses = await poseDetector.processImage(
      inputImage: inputImage,
      useClassifier: widget.useClassifier,
      isActivity: isActivity,
    );

    if (useClassifier) {
      poses.forEach((pose) {
        poseName = pose.name;
        poseAccuracy = pose.accuracy;
        test == 0 ? test = pose.reps : null;
        if (pose.reps != test) {
          poseReps++;
          test = pose.reps;
        }
      });
    }

    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null) {
      final painter = PosePainter(
        poses,
        inputImage.inputImageData!.size,
        inputImage.inputImageData!.imageRotation,
      );
      customPaint = CustomPaint(painter: painter);
    } else {
      customPaint = null;
    }

    isBusy = false;

    if (mounted) {
      setState(() {});
    }
  }
}
