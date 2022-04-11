import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile_final/Auth/login_screen.dart';
import 'package:mobile_final/screens/contact_screen.dart';
import 'package:mobile_final/screens/user_manual_screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final storage = new FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.only(top: 70, left: 30, right: 30),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "ตั้งค่า",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                ),
                Expanded(child: Container()),
                IconButton(
                  icon: const Icon(
                    Icons.logout,
                    size: 20,
                    color: Colors.black,
                  ),
                  onPressed: () async => {
                    // logout(context)
                    await FirebaseAuth.instance.signOut(),
                    await storage.delete(key: "uid"),
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Login(),
                        ),
                        (route) => false)
                  },
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(300, 70),
                  primary: Colors.blue.shade300,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const userManual()),
                );
              },
              child: const Text(
                "คู่มือการใช้งาน",
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
            SizedBox(height: 40,),
            // ElevatedButton(
            //   style: ElevatedButton.styleFrom(
            //       minimumSize: const Size(300, 70),
            //       primary: Colors.green.shade300,
            //       shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(20))),
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => const contact()),
            //     );
            //   },
            //   child: const Text(
            //     "ติดต่อผู้ดูแลระบบ",
            //     style: TextStyle(
            //       fontSize: 25,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => Login()));
  }
}
