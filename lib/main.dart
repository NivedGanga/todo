import 'package:flutter/material.dart';
import 'package:todo/presentation/homepage/homepage.dart';
import 'package:todo/presentation/loginpage/loginpage.dart';
import 'package:todo/presentation/signuppage/signuppage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo',
      theme: ThemeData.dark(useMaterial3: true),
      home: SignupPage(),
    );
  }
}
