import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:mobile_final/screens/user_manual_screen.dart';

class mnWeight extends StatefulWidget {
  const mnWeight({Key? key}) : super(key: key);

  @override
  State<mnWeight> createState() => _mnWeightState();
}

class _mnWeightState extends State<mnWeight> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: IntroductionScreen(
        globalBackgroundColor: Color(0xFFDBEAFE),
        dotsDecorator: DotsDecorator(
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          activeSize: const Size(20.0, 10.0),
        ),
        pages: [
          PageViewModel(
            image: Image.asset('assets/images/ex1.1.gif'),
            title: 'วิธีการใช้งานฟังก์ชันกราฟน้ำหนัก',
            bodyWidget: Column(
              children: [
                Text(
                  'คุณจำเป็นต้องกรอกน้ำหนักของคุณในทุกๆวันก่อนใช้งานกราฟแสดงน้ำหนัก',
                  style: TextStyle(
                    fontSize: 20
                  ),
                )
              ],
            ),
            
          ),
          PageViewModel(
            image: Image.asset('assets/images/ex1.2.gif'),
            title: 'วิธีการใช้งานฟังก์ชันกราฟน้ำหนัก',
            bodyWidget: Column(
              children: [
                Text(
                  'กดปุ่มกราฟแสดงน้ำหนักเพื่อเข้าดูกราฟน้ำหนักของคุณ',
                  style: TextStyle(
                    fontSize: 20
                  ),
                )
              ],
            ),
          ),
          PageViewModel(
            image: Image.asset('assets/images/ex1.3.gif'),
            title: 'วิธีการใช้งานฟังก์ชันกราฟน้ำหนัก',
            bodyWidget: Column(
              children: [
                Text(
                  'เมื่อกดเข้ามาแล้วคุณจะสามารถดูกราฟที่แสดงน้ำหนักของคุณในแต่ละวันได้',
                  style: TextStyle(
                    fontSize: 20
                  ),
                )
              ],
            ),
          ),
          PageViewModel(
            image: Image.asset('assets/images/ex1.4.gif'),
            title: 'วิธีการใช้งานฟังก์ชันกราฟน้ำหนัก',
            bodyWidget: Column(
              children: [
                Text(
                  'คุณสามารถเลือกดูกราฟน้ำหนักในวันก่อนได้จากการกดปุ่มตามรูป',
                  style: TextStyle(
                    fontSize: 20
                  ),
                )
              ],
            ),
          ),
        ],
        done: Text(
          'Done',
          style: TextStyle(color: Color(0xFF1E3A8A)),
        ),
        onDone: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const userManual()),
          );
        },
        showSkipButton: false,
        skip: Text(
          'Skip',
          style: TextStyle(color: Color(0xFF1E3A8A)),
        ),
        onSkip: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const userManual()),
          );
        },
        next: Icon(Icons.arrow_forward_outlined),
        showNextButton: true,
      ),
    ));
  }
}

