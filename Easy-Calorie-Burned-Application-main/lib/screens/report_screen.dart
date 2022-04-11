import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_final/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class reportScreen extends StatefulWidget {
  const reportScreen({Key? key}) : super(key: key);

  @override
  State<reportScreen> createState() => _reportScreenState();
}

class _reportScreenState extends State<reportScreen> {
  final _formkey = GlobalKey<FormState>();
  static const values1 = <String>['5', '4', '3', '2', '1'];
  static const values2 = <String>['5', '4', '3', '2', '1'];
  static const values3 = <String>['5', '4', '3', '2', '1'];
  static const values4 = <String>['5', '4', '3', '2', '1'];
  static const values5 = <String>['5', '4', '3', '2', '1'];
  String selectedValue1 = values1.first;
  String selectedValue2 = values2.first;
  String selectedValue3 = values3.first;
  String selectedValue4 = values4.first;
  String selectedValue5 = values5.first;
  final selectedColor = Colors.blue;
  final unselectedColor = Colors.white;
  String? uidMe;

  Widget buildQuestion1() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: values1.map(
          (value) {
            final selected = this.selectedValue1 == value;
            final color = selected ? selectedColor : unselectedColor;
            return Row(
              children: [
                Radio<String>(
                    value: value,
                    groupValue: selectedValue1,
                    onChanged: (value) => setState(() {
                          this.selectedValue1 = value!;
                          print(value);
                        })),
                Text(value),
              ],
            );
          },
        ).toList(),
      );

  Widget buildQuestion2() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: values2.map(
          (value) {
            final selected = this.selectedValue2 == value;
            final color = selected ? selectedColor : unselectedColor;
            return Row(
              children: [
                Radio<String>(
                    value: value,
                    groupValue: selectedValue2,
                    onChanged: (value) => setState(() {
                          this.selectedValue2 = value!;
                          print(value);
                        })),
                Text(value),
              ],
            );
          },
        ).toList(),
      );

  Widget buildQuestion3() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: values3.map(
          (value) {
            final selected = this.selectedValue3 == value;
            final color = selected ? selectedColor : unselectedColor;
            return Row(
              children: [
                Radio<String>(
                    value: value,
                    groupValue: selectedValue3,
                    onChanged: (value) => setState(() {
                          this.selectedValue3 = value!;
                          print(value);
                        })),
                Text(value),
              ],
            );
          },
        ).toList(),
      );

  Widget buildQuestion4() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: values4.map(
          (value) {
            final selected = this.selectedValue4 == value;
            final color = selected ? selectedColor : unselectedColor;
            return Row(
              children: [
                Radio<String>(
                    value: value,
                    groupValue: selectedValue4,
                    onChanged: (value) => setState(() {
                          this.selectedValue4 = value!;
                          print(value);
                        })),
                Text(value),
              ],
            );
          },
        ).toList(),
      );

  Widget buildQuestion5() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: values5.map(
          (value) {
            final selected = this.selectedValue5 == value;
            final color = selected ? selectedColor : unselectedColor;
            return Row(
              children: [
                Radio<String>(
                    value: value,
                    groupValue: selectedValue5,
                    onChanged: (value) => setState(() {
                          this.selectedValue5 = value!;
                          print(value);
                        })),
                Text(value),
              ],
            );
          },
        ).toList(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 90, left: 30, right: 30),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              Text(
                "แบบสอบถามความพึงพอใจต่อการใช้งาน",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
              Text(
                "คำชี้แจง กรุณาเลือกระดับคะแนนที่พึงพอใจต่อการใช้งาน",
                style: TextStyle(fontSize: 14),
              ),
              Text(
                "5 = ดีมาก, 4 = ดี, 3 = ปานกลาง, 2 = น้อย, 1 = น้อยที่สุด",
                style: TextStyle(fontSize: 14, color: Colors.red),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.only(
                    top: 20, left: 10, right: 10, bottom: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "1.แอปพลิเคชันใช้งานได้ง่าย",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    buildQuestion1(),
                    Text(
                      "2.แอปพลิเคชันมีความเสถียร",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    buildQuestion2(),
                    Text(
                      "3.แอปพลิเคชันมีความสวยงาม",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    buildQuestion3(),
                    Text(
                      "4.แอปพลิเคชันมีความน่าใช้งาน",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    buildQuestion4(),
                    Text(
                      "5.ภาพรวมของแอปพลิเคชัน Easy exercise",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    buildQuestion5(),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(150, 50),
                          primary: Colors.blue.shade300,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () async {
                        sendReport();
                        await FirebaseAuth.instance
                            .authStateChanges()
                            .listen((event) async {
                          uidMe = event!.uid;

                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(uidMe)
                              .update({'report': true});
                        });
                        showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  content: Builder(
                                    builder: (context) {
                                      return Container(
                                        height: 200,
                                        width: 200,
                                        child: Column(
                                          children: [
                                            Image.asset(
                                              'assets/images/check1.gif',
                                              height: 100,
                                              width: 100,
                                            ),
                                            Text("ขอบคุณที่ตอบแบบสอบถามครับ"),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            ElevatedButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const MainScreen()),
                                                  );
                                                },
                                                child: Text("กลับสู่หน้าหลัก"))
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ));
                        // showDialog(
                        //     context: context,
                        //     builder: (BuildContext context) => AlertDialog(
                        //           content: Column(children: [

                        //           ],),
                        //           actions: [

                        //           ],
                        //         ));
                      },
                      child: Text("ส่งแบบสอบถาม"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  sendReport() async {
    await FirebaseAuth.instance.authStateChanges().listen((event) async {
      String uid = event!.uid;
      await FirebaseFirestore.instance.collection('report').doc(uid).set({
        'question1': int.parse(selectedValue1),
        'question2': int.parse(selectedValue2),
        'question3': int.parse(selectedValue3),
        'question4': int.parse(selectedValue4),
        'question5': int.parse(selectedValue5),
      });
    });
  }
}
