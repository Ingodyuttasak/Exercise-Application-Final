import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:mobile_final/screens/user_manual_screen.dart';

class howtoPlay extends StatefulWidget {
  const howtoPlay({Key? key}) : super(key: key);

  @override
  State<howtoPlay> createState() => _howtoPlayState();
}

class _howtoPlayState extends State<howtoPlay> {
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
          image: Image.asset('assets/images/ex2.1.gif'),
          title: 'วิธีการเล่นเกมออกกำลังกาย',
          bodyWidget: Column(
            children: [
              Text(
                'คุณสามารถกดปุ่มเข้าเล่นเกมจากหน้าหลัก',
                style: TextStyle(fontSize: 20),
              )
            ],
          ),
        ),
        PageViewModel(
          image: Image.asset('assets/images/ex2.2.gif'),
          title: 'วิธีการเล่นเกมออกกำลังกาย',
          bodyWidget: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'คุณสามารถเลือกระดับการออกกำลังกายได้ โดยจะแบ่งเป็น 3 ระดับ',
                style: TextStyle(fontSize: 20),
              ),
              Text("♦ ระดับ Mild เหมาะกับผู้เล่นมือใหม่ในการออกกำลังกาย"),
              Text(
                  "♦ ระดับ Moderate เหมาะกับผู้เล่นที่มีพื้นฐานการออกกำลังกายระดับนึง"),
              Text(
                  "♦ ระดับ Strenuous เหมาะกับผู้เล่นที่มีพื้นฐานและออกกำลังกายเป็นประจำ"),
            ],
          ),
        ),
        PageViewModel(
          image: Image.asset('assets/images/ex2.3.gif'),
          title: 'วิธีการเล่นเกมออกกำลังกาย',
          bodyWidget: Column(
            children: [
              Text(
                'หลังจากเลือกระดับแล้วคุณสามารถดูตัวอย่างท่าออกกำลังกายได้',
                style: TextStyle(fontSize: 20),
              )
            ],
          ),
        ),
        PageViewModel(
          image: Image.asset('assets/images/ex2.4.gif'),
          title: 'วิธีการเล่นเกมออกกำลังกาย',
          bodyWidget: Column(
            children: [
              Text(
                'เมื่อคุณพร้อมแล้วกดเริ่มเกม เพื่อออกกำลังกายกันได้เลย',
                style: TextStyle(fontSize: 20),
              )
            ],
          ),
        ),
        PageViewModel(
          image: Image.asset('assets/images/ex2.5.gif'),
          title: 'วิธีการเล่นเกมออกกำลังกาย',
          bodyWidget: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'นี่เป็นหน้าที่เมื่อคุณกดเริ่มเกมแล้ว',
              ),
              Text(
                'ซึ่งในนั้นจะประกอบไปด้วยชื่อท่า,ชื่อข้างที่กำลังทำอยู่,ความถูกต้องของท่า,เวลาที่ทำ และจำนวนครั้งที่ทำ',
              ),
            ],
          ),
        ),
        PageViewModel(
          image: Image.asset('assets/images/ex2.6.gif'),
          title: 'วิธีการเล่นเกมออกกำลังกาย',
          bodyWidget: Column(
            children: [
              Text(
                'หลังจากออกกำลังกายเสร็จ จะแสดงคะแนนของคุณ',
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
    )));
  }
}
