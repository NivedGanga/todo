import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:todo/core/colors/colors.dart';
import 'package:todo/core/constants/constants.dart';
import 'package:todo/presentation/common_widgets/Icon_and_field.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
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
            children: [
              Text(
                "Welcome..",
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
                  controller: usernameController,
                  text: 'Username',
                  iconData: Icons.person_3_outlined),
              IconAndField(
                size: size,
                controller: passwordController,
                isPass: true,
                iconData: Icons.lock_outline_sharp,
                text: 'Password',
              ),
              kheight30,
              kheight30,
              kheight30,
            ],
          ),
        ),
      ),
    );
  }
}
