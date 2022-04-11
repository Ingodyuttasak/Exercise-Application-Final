import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:mobile_final/screens/user_manual_screen.dart';

class friendSystem extends StatefulWidget {
  const friendSystem({ Key? key }) : super(key: key);

  @override
  State<friendSystem> createState() => _friendSystemState();
}

class _friendSystemState extends State<friendSystem> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
        body: SafeArea(
            child: IntroductionScreen(
      globalBackgroundColor: Color(0xFFDBEAFE),
      dotsDecorator: DotsDecorator(
        size: Size(5,5),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        activeSize: const Size(10.0, 10.0),
      ),
      pages: [
        PageViewModel(
          image: Image.asset('assets/images/ex3.1.gif'),
          title: 'วิธีใช้งานระบบเพื่อน',
          bodyWidget: Column(
            children: [
              Text(
                'คุณสามารถกดปุ่มด้านล่างไปยังหน้าระบบเพื่อนของคุณ',
                style: TextStyle(fontSize: 20),
              )
            ],
          ),
        ),
        PageViewModel(
          image: Image.asset('assets/images/ex3.2.gif'),
          title: 'วิธีใช้งานระบบเพื่อน',
          bodyWidget: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'คุณสามารถดูรายชื่อเพื่อนของคุณที่มีภายในหน้านี้ได้',
                style: TextStyle(fontSize: 20),
              ),
              
            ],
          ),
        ),
        PageViewModel(
          image: Image.asset('assets/images/ex3.3.gif'),
          title: 'วิธีใช้งานระบบเพื่อน',
          bodyWidget: Column(
            children: [
              Text(
                'หากคุณต้องการเพิ่มเพื่อน คุณสามารถกดปุ่มเพิ่มเพื่อนได้',
                style: TextStyle(fontSize: 20),
              )
            ],
          ),
        ),
        PageViewModel(
          image: Image.asset('assets/images/ex3.4.gif'),
          title: 'วิธีใช้งานระบบเพื่อน',
          bodyWidget: Column(
            children: [
              Text(
                'คุณจำเป็นต้องใส่ Username ของเพื่อนคุณ',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'แล้วกดปุ่มแว่นขยาย คุณจะเจอรายชื่อเพื่อนของคุณขึ้นมา',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'คุณสามารถกดเพิ่มเพื่อน เพื่อเพิ่มเพื่อนได้เลย แต่คุณต้องรอเพื่อนของคุณตอบรับกลับด้วยนะ',
                style: TextStyle(fontSize: 16),
              )
            ],
          ),
        ),
        PageViewModel(
          image: Image.asset('assets/images/ex3.5.gif'),
          title: 'วิธีใช้งานระบบเพื่อน',
          bodyWidget: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ซึ่งถ้าหากคุณเป็นฝ่ายที่เพื่อนคุณเพิ่มมา',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'คุณสามารถกดปุ่ม คำขอเป็นเพื่อน เพื่อตอบรับคำขอเป็นเพื่อนของคุณ',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
        PageViewModel(
          image: Image.asset('assets/images/ex3.6.gif'),
          title: 'วิธีใช้งานระบบเพื่อน',
          bodyWidget: Column(
            children: [
              Text(
                'เมื่อคุณกดเข้ามาแล้ว คุณจะพบคำขอเป็นเพื่อนของคุณ',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'ซึ่งคุณเลือกที่ยอมรับคำขอนั้น หรือปฏิเสธมันก็ได้',
                style: TextStyle(fontSize: 16),
              ),
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
    )));
  }
}