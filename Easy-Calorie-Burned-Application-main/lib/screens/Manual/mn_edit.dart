import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:mobile_final/screens/user_manual_screen.dart';

class editMn extends StatefulWidget {
  const editMn({Key? key}) : super(key: key);

  @override
  State<editMn> createState() => _editMnState();
}

class _editMnState extends State<editMn> {
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
            image: Image.asset('assets/images/ex6.1.gif'),
            title: 'วิธีการแก้ไขข้อมูลส่วนตัว',
            bodyWidget: Column(
              children: [
                Text(
                  'คุณสามารถกดปุ่มนี้จากด้านล่าง เพื่อเข้าสู่หน้าข้อมูลส่วนตัวของคุณ',
                  style: TextStyle(fontSize: 16),
                )
              ],
            ),
          ),
          PageViewModel(
            image: Image.asset('assets/images/ex6.2.gif'),
            title: 'วิธีการแก้ไขข้อมูลส่วนตัว',
            bodyWidget: Column(
              children: [
                Text(
                  'ถ้าหากคุณต้องการแก้ไขข้อมูลส่วนตัว คุณสามารถกดปุ่ม "แก้ไขข้อมูลส่วนตัว"',
                  style: TextStyle(fontSize: 16),
                )
              ],
            ),
          ),
          PageViewModel(
            image: Image.asset('assets/images/ex6.3.gif'),
            title: 'วิธีการแก้ไขข้อมูลส่วนตัว',
            bodyWidget: Column(
              children: [
                Text(
                  'คุณสามารถเริ่มแก้ไขข้อมูลส่วนตัวของคุณได้เลย เมื่อคุณแก้ไขเสร็จกดปุ่ม "ยืนยันการแก้ไข"',
                  style: TextStyle(fontSize: 16),
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
