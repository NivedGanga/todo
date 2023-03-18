import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/infrastructure/user/model/user_model.dart';
import 'package:todo/presentation/homepage/homepage.dart';
import 'package:todo/presentation/loginpage/loginpage.dart';
import 'package:checkmark/checkmark.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool checked = false;
  @override
  void initState() {
    _splashhelper(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        checked = true;
      });
    });
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 70,
              width: 70,
              child: Transform.rotate(
                angle: -pi / 19,
                child: CheckMark(
                  strokeWidth: 10,
                  activeColor: Colors.deepPurpleAccent,
                  active: checked,
                  curve: Curves.decelerate,
                  duration: const Duration(seconds: 1),
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              'Todo',
              style: TextStyle(
                fontSize: 58,
                fontWeight: FontWeight.w900,
                color: Colors.deepPurpleAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

_splashhelper(context) async {
  final page = await _splashfunction();
  await Future.delayed(const Duration(seconds: 2));
  Navigator.of(context).pushReplacement(MaterialPageRoute(
    builder: (context) => page,
  ));
}

Future<Widget> _splashfunction() async {
  final sharedprefs = await SharedPreferences.getInstance();
  final uid = sharedprefs.getString('uid');
  if (uid == null) {
    return LoginPage();
  } else {
    UserModel.instance.uid = uid;
    return HomePage();
  }
}
