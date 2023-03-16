import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:todo/core/colors/colors.dart';
import 'package:todo/core/constants/constants.dart';
import 'package:todo/presentation/common_widgets/Icon_and_field.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Welcome Back..",
                style: TextStyle(
                  fontSize: 35,
                  color: primaryColor,
                  fontWeight: FontWeight.w300,
                ),
              ),
              kheight30,
              kheight30,
              kheight30,
              IconAndField(
                  size: size,
                  controller: emailController,
                  iconData: Icons.mail_outline_outlined,
                  text: 'Email'),
              IconAndField(
                size: size,
                controller: passwordController,
                isPass: true,
                iconData: Icons.lock_outline_sharp,
                text: 'Password',
              ),
              kheight30,
              SizedBox(
                width: size.width * 0.8,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Login'),
                ),
              ),
              kheight30,
              kheight30,
            ],
          ),
        ),
      ),
    );
  }
}
