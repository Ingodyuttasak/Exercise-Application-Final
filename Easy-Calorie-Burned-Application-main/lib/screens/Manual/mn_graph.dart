import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:mobile_final/screens/user_manual_screen.dart';

class graphExcer extends StatefulWidget {
  const graphExcer({ Key? key }) : super(key: key);

  @override
  State<graphExcer> createState() => _graphExcerState();
}

class _graphExcerState extends State<graphExcer> {
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
            image: Image.asset('assets/images/ex5.1.gif'),
            title: 'วิธีการใช้งานกราฟการออกกำลังกาย',
            bodyWidget: Column(
              children: [
                Text(
                  'คุณสามารถดูกราฟการออกกำลังกายของคุณจากการกดปุ่ม "แสดงกราฟ" ในหน้าหลัก',
                  style: TextStyle(
                    fontSize: 16
                  ),
                ),
              ],
            ),
            
          ),
          PageViewModel(
            image: Image.asset('assets/images/ex5.2.gif'),
            title: 'วิธีการใช้งานกราฟการออกกำลังกาย',
            bodyWidget: Column(
              children: [
                Text(
                  'เมื่อคุณกดเข้ามาแล้วคุณจะสามารถเลื่อนดูกราฟการออกกำลังในรายวันได้',
                  style: TextStyle(
                    fontSize: 16
                  ),
                ),
              ],
            ),
          ),
          PageViewModel(
            image: Image.asset('assets/images/ex5.3.gif'),
            title: 'วิธีการใช้งานกราฟการออกกำลังกาย',
            bodyWidget: Column(
              children: [
                Text(
                  'คุณสามารถเลือกดูเป็นรายเดือนได้ จากการกดปุ่ม "รายเดือน" ด้านบน',
                  style: TextStyle(
                    fontSize: 16
                  ),
                )
              ],
            ),
          ),
          PageViewModel(
            image: Image.asset('assets/images/ex5.4.gif'),
            title: 'วิธีการใช้งานกราฟการออกกำลังกาย',
            bodyWidget: Column(
              children: [
                Text(
                  'เมื่อคุณกดเข้ามาแล้วคุณจะสามารถเลื่อนดูกราฟการออกกำลังในรายเดือนได้',
                  style: TextStyle(
                    fontSize: 16
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