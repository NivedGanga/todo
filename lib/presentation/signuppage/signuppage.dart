import 'package:flutter/material.dart';
import 'package:todo/core/colors/colors.dart';
import 'package:todo/core/constants/constants.dart';
import 'package:todo/domain/signup/signup.dart';
import 'package:todo/presentation/common_widgets/Icon_and_field.dart';
import 'package:todo/presentation/loginpage/loginpage.dart';


class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  final emailController = TextEditingController();

  final otpController = TextEditingController();

  final passwordController = TextEditingController();

  final usernameController = TextEditingController();

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
                  _IconAndField(
                      size: size,
                      controller: emailController,
                      iconData: Icons.mail_outline_outlined,
                      text: 'Email'),
                  _IconAndField(
                    size: size,
                    controller: otpController,
                    text: 'OTP',
                    iconData: Icons.security_outlined,
                    isotp: true,
                  ),
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
                  SizedBox(
                    width: size.width * 0.8,
                    child: ValueListenableBuilder(
                        valueListenable: SignUp.instance.emailVerifyNotifier,
                        builder: (context, newVal, _) {
                          return AnimatedScale(
                            duration: Duration(milliseconds: 500),
                            scale: newVal ? 1 : 0,
                            child: ElevatedButton(
                              onPressed: () {FocusScope.of(context).unfocus();
                                SignUp.instance.signUpWithEmailAndPassword(
                                  email: emailController.text,
                                  username: usernameController.text,
                                  password: passwordController.text,
                                  context: context,
                                );
                                
                              },
                              child: Text('Login'),
                            ),
                          );
                        }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already registered?'),
                      TextButton(
                          onPressed: () {FocusScope.of(context).unfocus();
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ));
                          },
                          child: Text('Login'))
                    ],
                  ),
                  kheight30,
                ],
              ),
            ),
          ),
          ValueListenableBuilder(
              valueListenable: SignUp.instance.loadingNotifier,
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

class _IconAndField extends StatelessWidget {
  _IconAndField({
    required this.size,
    required this.controller,
    required this.text,
    required this.iconData,
    this.isotp = false,
  });
  final String text;
  final IconData iconData;
  final Size size;
  final TextEditingController controller;
  final bool isotp;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(iconData),
        kwidth20,
        SizedBox(
          width: size.width * 0.7,
          child: ValueListenableBuilder(
              valueListenable: SignUp.instance.otpSendNotifier,
              builder: (context, newVal, _) {
                return TextFormField(
                  enabled: isotp ? newVal : true,
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: text,
                    suffix: SizedBox(
                      height: 20,
                      child: ElevatedButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          if (controller.text == '') {
                            return;
                          }
                          if (isotp) {
                            SignUp.instance.verifyOtp(
                                otp: controller.text, context: context);
                          } else {
                            SignUp.instance.sentOtp(
                                emailid: controller.text, context: context);
                            SignUp.instance.otpSendNotifier.value = true;
                            SignUp.instance.otpSendNotifier.notifyListeners();
                          }
                        },
                        child: Text(isotp ? 'Verify' : 'Get otp'),
                      ),
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
