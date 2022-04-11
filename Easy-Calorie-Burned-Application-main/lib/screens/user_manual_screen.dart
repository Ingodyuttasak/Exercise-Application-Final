import 'package:flutter/material.dart';
import 'package:mobile_final/main_screen.dart';
import 'package:mobile_final/screens/Manual/mn_edit.dart';
import 'package:mobile_final/screens/Manual/mn_friend.dart';
import 'package:mobile_final/screens/Manual/mn_graph.dart';
import 'package:mobile_final/screens/Manual/mn_howtoplay.dart';
import 'package:mobile_final/screens/Manual/mn_ranking.dart';
import 'package:mobile_final/screens/Manual/mn_weight.dart';

class userManual extends StatefulWidget {
  const userManual({Key? key}) : super(key: key);

  @override
  State<userManual> createState() => _userManualState();
}

class _userManualState extends State<userManual> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: (){
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MainScreen()),
          );
          },
        ),
        title: Text("คู่มือการใช้งาน"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Material(
                      child: InkWell(
                        highlightColor: Colors.lightBlue.withOpacity(0.3),
                        splashColor: Colors.blue.withOpacity(0.5),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const mnWeight()),
                          );
                        },
                        child: Ink(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                  flex: 2,
                                  child: Text(
                                    "กราฟน้ำหนัก",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )),
                              Container(
                                height: 100,
                                width: 20,
                              ),
                              Expanded(
                                  flex: 2,
                                  child: Image.asset(
                                    'assets/images/mu_iconweight.png',
                                    height: 90,
                                    width: 90,
                                  ))
                            ],
                          ),
                          height: 120,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                // colors: [
                                //   Colors.blueGrey.shade700,
                                //   Colors.blue.shade50,
                                // ],
                                // stops: [
                                //   0.1,
                                //   0.2,
                                //   0.9,
                                // ],
                                colors: [
                                  Colors.blueGrey.shade900,
                                  // Colors.blueGrey.shade600,
                                  Colors.lightBlue.shade700,
                                ],
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Material(
                      child: InkWell(
                        highlightColor: Colors.lightBlue.withOpacity(0.3),
                        splashColor: Colors.blue.withOpacity(0.5),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const howtoPlay()),
                          );
                        },
                        child: Ink(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                  flex: 2,
                                  child: Text(
                                    "วิธีเล่นเกม",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )),
                              Container(
                                height: 100,
                                width: 20,
                              ),
                              Expanded(
                                  flex: 2,
                                  child: Image.asset(
                                    'assets/images/mu_icongameEx.png',
                                    height: 90,
                                    width: 90,
                                  ))
                            ],
                          ),
                          height: 120,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                // colors: [
                                //   Colors.indigo.shade300,
                                //   Colors.blue.shade50,
                                // ],
                                colors: [
                                  Colors.deepPurple.shade400,
                                  Colors.blueGrey.shade700,
                                  // Colors.lightBlue.shade700,
                                ],
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Material(
                      child: InkWell(
                        highlightColor: Colors.lightBlue.withOpacity(0.3),
                        splashColor: Colors.blue.withOpacity(0.5),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const friendSystem()),
                          );
                        },
                        child: Ink(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                  flex: 2,
                                  child: Text(
                                    "ระบบเพื่อน",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )),
                              Container(
                                height: 100,
                                width: 20,
                              ),
                              Expanded(
                                  flex: 2,
                                  child: Image.asset(
                                    'assets/images/mu_iconfriend.png',
                                    height: 90,
                                    width: 90,
                                  ))
                            ],
                          ),
                          height: 120,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                // colors: [
                                //   Colors.blue.shade900,
                                //   Colors.blue.shade50,
                                // ],
                                colors: [
                                  Colors.blue.shade900,
                                  Colors.deepPurple.shade400,
                                  // Colors.lightBlue.shade700,
                                ],
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Material(
                      child: InkWell(
                        highlightColor: Colors.lightBlue.withOpacity(0.3),
                        splashColor: Colors.blue.withOpacity(0.5),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const rankingMn()),
                          );
                        },
                        child: Ink(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                  flex: 2,
                                  child: Text(
                                    "อันดับการแข่งขัน",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )),
                              Container(
                                height: 100,
                                width: 20,
                              ),
                              Expanded(
                                  flex: 2,
                                  child: Image.asset(
                                    'assets/images/mu_ranking.png',
                                    height: 90,
                                    width: 90,
                                  ))
                            ],
                          ),
                          height: 120,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                                  Colors.amber.shade900,
                                  Colors.blue.shade50,
                                ],
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Material(
                      child: InkWell(
                        highlightColor: Colors.lightBlue.withOpacity(0.3),
                        splashColor: Colors.blue.withOpacity(0.5),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const graphExcer()),
                          );
                        },
                        child: Ink(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                  flex: 2,
                                  child: Text(
                                    "กราฟออกกำลังกาย",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )),
                              Container(
                                height: 100,
                                width: 20,
                              ),
                              Expanded(
                                  flex: 2,
                                  child: Image.asset(
                                    'assets/images/mu_iconExcer.png',
                                    height: 90,
                                    width: 90,
                                  ))
                            ],
                          ),
                          height: 120,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                                  Colors.lightBlue.shade900,
                                  Colors.blue.shade50,
                                ],
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Material(
                      child: InkWell(
                        highlightColor: Colors.lightBlue.withOpacity(0.3),
                        splashColor: Colors.blue.withOpacity(0.5),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const editMn()),
                          );
                        },
                        child: Ink(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                  flex: 2,
                                  child: Text(
                                    "แก้ไขข้อมูลส่วนตัว",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )),
                              Container(
                                height: 100,
                                width: 20,
                              ),
                              Expanded(
                                  flex: 2,
                                  child: Image.asset(
                                    'assets/images/mu_icongameEx.png',
                                    height: 90,
                                    width: 90,
                                  ))
                            ],
                          ),
                          height: 120,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                                  Colors.blue,
                                  Colors.blue.shade50,
                                ],
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
