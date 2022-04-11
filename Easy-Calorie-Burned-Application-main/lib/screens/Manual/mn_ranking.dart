import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:mobile_final/screens/user_manual_screen.dart';

class rankingMn extends StatefulWidget {
  const rankingMn({ Key? key }) : super(key: key);

  @override
  State<rankingMn> createState() => _rankingMnState();
}

class _rankingMnState extends State<rankingMn> {
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
            image: Image.asset('assets/images/ex4.1.gif'),
            title: 'วิธีการใช้งานฟังก์ชันอันดับการแข่งขัน',
            bodyWidget: Column(
              children: [
                Text(
                  'เมื่อคุณออกกำลังกายเสร็จ คุณอยากรู้ว่าตอนนี้คุณอยู่ในอันดับไหนของการแข่งขัน',
                  style: TextStyle(
                    fontSize: 16
                  ),
                ),
                Text(
                  'คุณลองกดปุ่ม "จัดอันดับการแข่งขัน" ดูซิ',
                  style: TextStyle(
                    fontSize: 16
                  ),
                ),
              ],
            ),
            
          ),
          PageViewModel(
            image: Image.asset('assets/images/ex4.2.gif'),
            title: 'วิธีการใช้งานฟังก์ชันอันดับการแข่งขัน',
            bodyWidget: Column(
              children: [
                Text(
                  'เมื่อคุณกดเข้ามาแล้วคุณจะสามารถเลือกดู การจัดอันดับในแต่ละระดับการออกกำลังกายได้',
                  style: TextStyle(
                    fontSize: 16
                  ),
                ),
                Text(
                  'ซึ่งหน้าที่คุณอยู่ตอนนี้เป็นการจัดอันดับการแข่งขันกับผู้เล่นเกมออกกำลังกายทั้งหมดเลยนะ',
                  style: TextStyle(
                    fontSize: 16
                  ),
                ),
              ],
            ),
          ),
          PageViewModel(
            image: Image.asset('assets/images/ex4.3.gif'),
            title: 'วิธีการใช้งานฟังก์ชันอันดับการแข่งขัน',
            bodyWidget: Column(
              children: [
                Text(
                  'ถ้าหากคุณต้องการอยากทราบอันดับการแข่งขันของคุณกับเพื่อนของคุณ คุณสามารถกดปุ่มนี้ได้เลย',
                  style: TextStyle(
                    fontSize: 16
                  ),
                )
              ],
            ),
          ),
          PageViewModel(
            image: Image.asset('assets/images/ex4.4.gif'),
            title: 'วิธีการใช้งานฟังก์ชันอันดับการแข่งขัน',
            bodyWidget: Column(
              children: [
                Text(
                  'เมื่อกดเข้ามาแล้วคุณจะสามารถดูอันดับของคุณกับเพื่อนคุณได้เลย',
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