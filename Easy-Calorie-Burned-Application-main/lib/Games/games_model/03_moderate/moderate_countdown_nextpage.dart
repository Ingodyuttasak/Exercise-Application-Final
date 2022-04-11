import 'dart:async';


import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:mobile_final/Games/games_model/03_moderate/01_lunges/pose_detector_views_lunges.dart';
import 'package:mobile_final/Games/games_model/03_moderate/03_arm_circles/pose_detector_views_arm_circles.dart';
import 'package:mobile_final/Games/games_model/03_moderate/02_standing_twist/pose_detector_views_standing_twist.dart';
import 'package:mobile_final/Games/games_model/03_moderate/04_elbow_plank/pose_detector_views_elbow_plank.dart';

class moderate_countdown_nextpage extends StatefulWidget {
  final int scoreSum;
  final int getplaytime;
  final int setstep;

  const moderate_countdown_nextpage({
    this.scoreSum = 0,
    this.getplaytime = 0,
    this.setstep = 0,
  });

  @override
  _moderate_countdown_nextpageState createState() =>
      _moderate_countdown_nextpageState();
}

class _moderate_countdown_nextpageState
    extends State<moderate_countdown_nextpage> {
  // int count = 5;
  int count = 21;
  String goTo = '';
  String pathgif = "" ,namegif="";

  @override
  void initState() {
    super.initState();
    if (widget.setstep >= 1 && widget.setstep <= 2) {
            pathgif = "assets/images/lunge.gif";
            namegif = 'Lunges';
          }else if (widget.setstep >= 3 && widget.setstep <= 5) {
            pathgif = "assets/images/standing.gif";
            namegif = 'Standing twist';
          }else if (widget.setstep >= 6 && widget.setstep <= 8) {
            pathgif = "assets/images/arm-circle.gif";
            namegif = 'Arm circles';
          }else if (widget.setstep >= 9 && widget.setstep <= 12) {
            pathgif = "assets/images/plank.gif";
            namegif = 'Elbow plank';
          }
    audioTokc();
    autoCount();
  }

  // Future playAudioBG() async {
  //   FlameAudio.bgm.play('NCS_mix_20_02.mp3');
  // }

  Future audioTokc() async {
    FlameAudio.bgm.pause();
    FlameAudio.play('tok_c.mp3');
  }

  Future audioToke() async {
    FlameAudio.bgm.pause();
    FlameAudio.play('tok_e.mp3');
  }

  Future<void> pushpageimage() async {
    // playAudioBG();
    if (widget.setstep == 1) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  PoseDetectorView_lunges_moderate(
                    scoreSum: widget.scoreSum,
                    getplaytime: widget.getplaytime,
                    setStep: 2,
                  )),
          (Route<dynamic> route) => false);
    } else if (widget.setstep == 2) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  PoseDetectorView_lunges_moderate(
                    scoreSum: widget.scoreSum,
                    getplaytime: widget.getplaytime,
                    setStep: 3,
                  )),
          (Route<dynamic> route) => false);
    } else if (widget.setstep == 3) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  PoseDetectorView_standing_twist(
                    scoreSum: widget.scoreSum,
                    getplaytime: widget.getplaytime,
                    setStep: 4,
                  )),
          (Route<dynamic> route) => false);
    } else if (widget.setstep == 4) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  PoseDetectorView_standing_twist(
                    scoreSum: widget.scoreSum,
                    getplaytime: widget.getplaytime,
                    setStep: 5,
                  )),
          (Route<dynamic> route) => false);
    } else if (widget.setstep == 5) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  PoseDetectorView_standing_twist(
                    scoreSum: widget.scoreSum,
                    getplaytime: widget.getplaytime,
                    setStep: 6,
                  )),
          (Route<dynamic> route) => false);
    } else if (widget.setstep == 6) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => PoseDetectorView_arm_circles(
                    scoreSum: widget.scoreSum,
                    getplaytime: widget.getplaytime,
                    setStep: 7,
                  )),
          (Route<dynamic> route) => false);
    } else if (widget.setstep == 7) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => PoseDetectorView_arm_circles(
                    scoreSum: widget.scoreSum,
                    getplaytime: widget.getplaytime,
                    setStep: 8,
                  )),
          (Route<dynamic> route) => false);
    } else if (widget.setstep == 8) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => PoseDetectorView_arm_circles(
                    scoreSum: widget.scoreSum,
                    getplaytime: widget.getplaytime,
                    setStep: 9,
                  )),
          (Route<dynamic> route) => false);
    } else if (widget.setstep == 9) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => PoseDetectorView_elbow_plank(
                    scoreSum: widget.scoreSum,
                    getplaytime: widget.getplaytime,
                    setStep: 10,
                  )),
          (Route<dynamic> route) => false);
    } else if (widget.setstep == 10) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => PoseDetectorView_elbow_plank(
                    scoreSum: widget.scoreSum,
                    getplaytime: widget.getplaytime,
                    setStep: 11,
                  )),
          (Route<dynamic> route) => false);
    } else if (widget.setstep == 11) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => PoseDetectorView_elbow_plank(
                    scoreSum: widget.scoreSum,
                    getplaytime: widget.getplaytime,
                    setStep: 12,
                  )),
          (Route<dynamic> route) => false);
    }
  }

  Future<void> autoCount() async {
    Duration duration = Duration(seconds: 1);
    // audio.play('audio/Sanctuary_Guardian.mp3');
    // ignore: await_only_futures
    await Timer(duration, () {
      if (count == 3) {
        audioTokc();
        if (widget.setstep == 1) {
          setState(() {
            goTo = 'Lunges set 2';
            count--;
          });
        } else if (widget.setstep == 2) {
          setState(() {
            goTo = 'Lunges set 3';
            count--;
          });
        } else if (widget.setstep == 3) {
          setState(() {
            goTo = 'Standing twist set 1 ';
            count--;
          });
        } else if (widget.setstep == 4) {
          setState(() {
            goTo = 'Standing twist set 2';
            count--;
          });
        } else if (widget.setstep == 5) {
          setState(() {
            goTo = 'Standing twist set 3';
            count--;
          });
        } else if (widget.setstep == 6) {
          setState(() {
            goTo = 'Arm circles set 1';
            count--;
          });
        } else if (widget.setstep == 7) {
          setState(() {
            goTo = 'Arm circles set 2';
            count--;
          });
        } else if (widget.setstep == 8) {
          setState(() {
            goTo = 'Arm circles set 3';
            count--;
          });
        } else if (widget.setstep == 9) {
          setState(() {
            goTo = 'Elbow plank set 1';
            count--;
          });
        } else if (widget.setstep == 10) {
          setState(() {
            goTo = 'Elbow plank set 2';
            count--;
          });
        } else if (widget.setstep == 11) {
          setState(() {
            goTo = 'Elbow plank set 3';
            count--;
          });
        }
        autoCount();
      } else if (count == 2) {
        audioTokc();
        setState(() {
          goTo = 'READY';
          count--;
        });
        autoCount();
      } else if (count == 1) {
        audioToke();
        setState(() {
          goTo = 'GO!';
          count--;
        });
        autoCount();
      } else if (count == 0) {
        pushpageimage();
      } else {
        audioTokc();
        setState(() {
          count--;
        });
        autoCount();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: goTo == ''
          ? Center(
            child: Column(
                children: [
                  SizedBox(
                    height: 120,
                  ),
                  Container(
                    child: Text(
                      '${(namegif)}',
                      style: TextStyle(
                        color: Colors.orange.shade200,
                        fontSize: 30,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Container(
                  //   Image.asset("${pathgif}",height: 100,width: 150,),
                  // ),
                  Image.asset("${pathgif}",width: 220,),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    child: Text(
                      '${(count - 1).toString()}',
                      style: TextStyle(
                        color: Colors.orange.shade200,
                        fontSize: 90,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ),
                  
                ],
              
              
            ))
          : Center(
              child: Text(
              '${goTo}',
              style: TextStyle(
                color: Colors.orange.shade200,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            )),
    );
  }
}
