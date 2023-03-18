import 'package:flutter/material.dart';
import 'package:todo/core/colors/colors.dart';
import 'package:todo/core/constants/constants.dart';
import 'package:todo/domain/login/login.dart';
import 'package:todo/presentation/common_widgets/Icon_and_field.dart';
import 'package:todo/presentation/signuppage/signuppage.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
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
                    text: 'Email',
                  ),
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
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        Login.instance.signInWithEmailAndPassword(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                            context: context);
                      },
                      child: Text('Login'),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Not registered yet?'),
                      TextButton(
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => SignupPage(),
                            ));
                          },
                          child: Text('Signup'))
                    ],
                  ),
                  kheight30,
                  kheight30,
                ],
              ),
            ),
          ),
          ValueListenableBuilder(
              valueListenable: Login.instance.loadingNotifier,
              builder: (context, newVal, _) {
                return newVal
                    ? Container(
                        color: Colors.black.withOpacity(0.5),
                        width: double.infinity,
                        height: double.infinity,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : SizedBox();
              })
        ],
      ),
    );
  }
}
