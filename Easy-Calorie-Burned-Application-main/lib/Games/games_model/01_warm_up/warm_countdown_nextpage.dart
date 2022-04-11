import 'dart:async';
import 'dart:math';

// import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile_final/Games/games_model/01_warm_up/01_arm_stretch_and_full/pose_detector_views_arm_strech_and_full.dart';
import 'package:mobile_final/Games/games_model/01_warm_up/02_front_kicking/pose_detector_views_front_kicking.dart';
import 'package:mobile_final/Games/games_model/01_warm_up/03_foot_touching/pose_detector_views_foot_touching.dart';
import 'package:mobile_final/Games/games_model/02_mild/01_lunges/pose_detector_views_lunges.dart';
import 'package:mobile_final/Games/games_model/03_moderate/01_lunges/pose_detector_views_lunges.dart';
import 'package:mobile_final/Games/games_model/04_Strenuous/01_lunges/pose_detector_views_lunges.dart';

class warm_countdown_nextpage extends StatefulWidget {
  final int getplaytime;
  final int setstep;
  final String activitygame;

  const warm_countdown_nextpage({
    this.getplaytime = 0,
    this.setstep = 1,
    this.activitygame = "mild",
  });

  @override
  _warm_countdown_nextpageState createState() =>
      _warm_countdown_nextpageState();
}

class _warm_countdown_nextpageState extends State<warm_countdown_nextpage> {
  // int count = 11;
  int count = 21;
  String goTo = '';
  String pathgif = "" ,namegif="";

  // String pathgif = "assets/images/armstrech.gif";
  // final assetsAudioPlayer = AssetsAudioPlayer();

  @override
  void initState() {
    super.initState();
      if (widget.setstep == 1) {
            pathgif = "assets/images/armstrech.gif";
            namegif = 'Arm strech and full';
          }else if (widget.setstep == 2) {
            pathgif = "assets/images/frontkick.gif";
            namegif = 'Front kicking';
          }else if (widget.setstep == 3) {
            pathgif = "assets/images/foot.gif";
            namegif = 'Foot touching';
          }else if (widget.setstep == 4) {
            pathgif = "assets/images/lunge.gif";
            namegif = 'Lunges';
          }
    // AssetsAudioPlayer().stop();
    // assAudio();
    audioTokc();
    autoCount();
  }

  // Future assAudio() async {
  //   assetsAudioPlayer.open(
  //     Audio("assets/audio/NCS_mix_20_04.mp3"),
  //   );
  //   assetsAudioPlayer.play();
  // }

  // Future playAudioBG() async {
  //   // FlameAudio.bgm.play('NCS_mix_20_02.mp3');
  //   // final assetsAudioPlayer = AssetsAudioPlayer();
  //   AssetsAudioPlayer().open(
  //     Audio("assets/audio/NCS_mix_20_04.mp3"),
  //   );
  //   AssetsAudioPlayer().play();

  // }

  Future audioTokc() async {
    // FlameAudio.bgm.pause();
    // AssetsAudioPlayer().stop();

    FlameAudio.play('tok_c.mp3');
  }

  Future audioToke() async {
    // FlameAudio.bgm.pause();
    // AssetsAudioPlayer().stop();
    FlameAudio.play('tok_e.mp3');
  }

  Future<void> pushstep() async {
    if (widget.setstep == 1) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PoseDetectorView_arm_strech_and_full(
                    getplaytime: widget.getplaytime,
                    activitygame: widget.activitygame,
                    setStep: 2,
                  )));
    } else if (widget.setstep == 2) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PoseDetectorView_front_kicking(
                    getplaytime: widget.getplaytime,
                    activitygame: widget.activitygame,
                    setStep: 3,
                  )));
    } else if (widget.setstep == 3) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PoseDetectorView_foot_touching(
                    getplaytime: widget.getplaytime,
                    activitygame: widget.activitygame,
                    setStep: 4,
                  )));
    }
  }

  Future<void> autoCount() async {
    Duration duration = Duration(seconds: 1);
    // audio.play('audio/Sanctuary_Guardian.mp3');
    // ignore: await_only_futures
    await Timer(duration, () {
      if (count == 4) {
        audioTokc();
        setState(() {
          goTo = 'WARM UP';
          count--;
        });
        autoCount();
      } else if (count == 3) {
        audioTokc();
        if (widget.setstep == 1) {
          setState(() {
            goTo = 'Arm strech and full';
            count--;
          });
        } else if (widget.setstep == 2) {
          setState(() {
            goTo = 'Front kicking';
            count--;
          });
        } else if (widget.setstep == 3) {
          setState(() {
            goTo = 'Foot touching ';
            count--;
          });
        } else if (widget.setstep == 4) {
          setState(() {
            goTo = 'Lunges set 1';
            count--;
          });
        }
        autoCount();
      } else if (count == 2) {
        audioTokc();
        setState(() {
          // audio.play('audio/Here_We_Go!_Mario_Sound_Effec.mp3');
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
        print("###su ${widget.activitygame} setstep ${widget.setstep}");
        if (widget.activitygame == "mild" && widget.setstep == 4) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PoseDetectorView_lunges_mild(
                        // scoreSum: widget.scoreSum,
                        getplaytime: widget.getplaytime,
                      )));
        } else if (widget.activitygame == "moderate" && widget.setstep == 4) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PoseDetectorView_lunges_moderate(
                        // scoreSum: widget.scoreSum,
                        getplaytime: widget.getplaytime,
                      )));
        } else if (widget.activitygame == "strenuous" && widget.setstep == 4) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PoseDetectorView_lunges_strenuous(
                        // scoreSum: widget.scoreSum,
                        getplaytime: widget.getplaytime,
                      )));
        } else {
          pushstep();
        }
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
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
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
                        color: widget.activitygame == "mild"
                            ? Colors.greenAccent
                            : widget.activitygame == "moderate"
                                ? Colors.orange.shade200
                                : Colors.red[300],
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
                        color: widget.activitygame == "mild"
                            ? Colors.greenAccent
                            : widget.activitygame == "moderate"
                                ? Colors.orange.shade200
                                : Colors.red[300],
                        fontSize: 90,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ))
            : Center(
                child: Text(
                '${goTo}',
                style: TextStyle(
                  color: widget.activitygame == "mild"
                      ? Colors.greenAccent
                      : widget.activitygame == "moderate"
                          ? Colors.orange.shade200
                          : Colors.red[300],
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              )),
      ),
    );
  }
}
