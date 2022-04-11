import 'package:flutter/material.dart';
import 'package:mobile_final/Games/Gamescore/moderate_showScore.dart';
import 'package:mobile_final/Games/games_model/01_warm_up/warm_countdown_nextpage.dart';
import 'package:mobile_final/Games/games_model/03_moderate/04_elbow_plank/pose_detector_views_elbow_plank.dart';
import 'package:mobile_final/Games/games_model/03_moderate/moderate_countdown_nextpage.dart';

import 'games_model/04_Strenuous/05_bend_side/pose_detector_views_bend_side.dart';

class moderateScreen extends StatefulWidget {
  const moderateScreen({Key? key}) : super(key: key);

  @override
  _moderateScreenState createState() => _moderateScreenState();
}

class _moderateScreenState extends State<moderateScreen> {
  List<List<dynamic>> mildwarmList = [
    [
      "assets/images/armstrech.gif",
      "ท่ายืดกล้ามเนื้อแขน",
    ],
    [
      "assets/images/frontkick.gif",
      "ท่าเตะด้านหน้า",
    ],
    [
      "assets/images/foot.gif",
      "ท่าก้มแตะสลับเท้า",
    ]
  ];
  List<List<dynamic>> mildexList = [
    [
      "assets/images/lunge.gif",
      "ท่าลันจ์",
    ],
    [
      "assets/images/standing.gif",
      "ท่าสแตนดิ้งทวิสต์",
    ],
    [
      "assets/images/arm-circle.gif",
      "ท่าอาร์มไซเคิล",
    ],
    [
      "assets/images/plank.gif",
      "ท่าแพลงก์",
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.9),
            Colors.amberAccent.shade100.withOpacity(0.9),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        )),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 80, left: 30, right: 30),
              width: MediaQuery.of(context).size.width,
              height: 220,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 20,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(
                      "เกมออกกำลังกาย",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "ระดับกลาง (Moderate)",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Container(
                          width: 90,
                          height: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                  colors: [
                                    Colors.amberAccent.withOpacity(0.7),
                                    Colors.orange.withOpacity(0.7),
                                  ],
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.bottomRight)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.timer,
                                size: 20,
                                color: Colors.white,
                              ),
                              SizedBox(width: 5),
                              Text(
                                "13 Min",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ]),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(60),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          "ท่าอบอุ่นร่างกาย (3 ท่า)",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                        child: ListView.builder(
                            itemCount: mildwarmList.length,
                            itemBuilder: (_, index) {
                              return Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                ),
                                child: Container(
                                  height: 80,
                                  // color:Colors.green,
                                  width: double.infinity,
                                  child: Stack(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 30,
                                          ),
                                          Image.asset(
                                            mildwarmList[index][0],
                                            fit: BoxFit.cover,
                                            height: 80,
                                            width: 100,
                                          ),
                                          Expanded(
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 50, vertical: 20),
                                              child: Column(
                                                children: [
                                                  SizedBox(height: 15),
                                                  Text(
                                                    "${mildwarmList[index][1]}",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w300),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }))
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  // borderRadius: BorderRadius.only(
                  //   topRight: Radius.circular(60),
                  // ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          "ท่าออกกำลังกาย (4 ท่า)",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            // color: Colors.white
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                        child: ListView.builder(
                            itemCount: mildexList.length,
                            itemBuilder: (_, index) {
                              return Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                ),
                                child: Container(
                                  height: 80,
                                  // color:Colors.green,
                                  width: double.infinity,
                                  child: Stack(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 30,
                                          ),
                                          Image.asset(
                                            mildexList[index][0],
                                            fit: BoxFit.cover,
                                            height: 80,
                                            width: 100,
                                          ),
                                          Expanded(
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 50, vertical: 20),
                                              child: Column(
                                                children: [
                                                  SizedBox(height: 15),
                                                  Text(
                                                    "${mildexList[index][1]}",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w300),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }))
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const
                          // PoseDetectorView_elbow_plank(
                          //   setStep: 12,
                          // PoseDetectorView_bend_side(
                          // warm_countdown_nextpage(
                          //   activitygame: "moderate",
                          moderate_countdown_nextpage(
                            setstep: 11,
                          )),
                );
              },
              child: Container(
                height: 40.0,
                width: 300,
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.orangeAccent.shade200.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    "เริ่มเกม",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
