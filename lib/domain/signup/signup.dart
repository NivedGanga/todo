import 'dart:math' as math;
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/core/keys/keys.dart';
import 'package:todo/infrastructure/list/list_repo.dart';
import 'package:todo/infrastructure/list/model/list_model.dart';
import 'package:todo/infrastructure/user/model/user_model.dart';
import 'package:todo/presentation/homepage/homepage.dart';

class SignUp {
  SignUp._internal();
  static SignUp instance = SignUp._internal();
  factory SignUp() {
    return instance;
  }
  final ValueNotifier<bool> loadingNotifier = ValueNotifier(false);
  final ValueNotifier<bool> emailVerifyNotifier = ValueNotifier(false);
  final ValueNotifier<bool> otpSendNotifier = ValueNotifier(false);
  Future<void> signUpWithEmailAndPassword(
      {required String email,
      required String username,
      required String password,
      required BuildContext context}) async {
    loadingNotifier.value = true;
    instance.loadingNotifier.notifyListeners();
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await userCredential.user!.updateDisplayName(username);
      User user = userCredential.user!;
      UserModel.instance.uid = user.uid;
      final Sharedprefs = await SharedPreferences.getInstance();
      Sharedprefs.setString('uid', user.uid);
      await ListRepo.instance
          .addNewList(list: ListModel(id: '0', title: 'MyTask'));
      await ListRepo.instance.getLists();
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
          (route) => false);
      loadingNotifier.value = false;
      instance.loadingNotifier.notifyListeners();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('The password provided is too weak.')),
        );
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('The account already exists for that email.')),
        );
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An unknown error occurred.')),
      );
    }
    loadingNotifier.value = false;
    loadingNotifier.notifyListeners();
  }

  late String? otp;
  sentOtp({required String emailid, context}) async {
    loadingNotifier.value = true;
    instance.loadingNotifier.notifyListeners();
    final String username = Keys.username;
    final String password = Keys.password;
    var rndnumber = "";
    var rnd = new math.Random();
    for (var i = 0; i < 6; i++) {
      rndnumber = rndnumber + rnd.nextInt(9).toString();
    }
    otp = rndnumber;
    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'Tasks')
      ..recipients.add(emailid)
      ..subject = 'OTP for Tasks'
      ..html = '''<!DOCTYPE html>
<html lang="en">
<head>

</head>
<body>
    <div style="background-color: #202020; padding: 20px;">
		<div style="max-width: 600px; margin: 0 auto; background-color: #1c1c1c; padding: 20px;color: white;">
			<h2 style="text-align: center;color: white;font-weight: 100;">Tasks - OTP Verification</h2>
			<p style="font-weight: 100;">Hello,</p>
			<p style="font-weight: lighter;">Please use the following One-Time Password (OTP) to verify your account on the Tasks app:</p>
			<div style="text-align: center; font-size: 24px; padding: 10px; background-color: #3b3b3b;color: rgb(116, 85, 255);font-weight: 900;">
				$otp
			</div>
			<p>If you did not request this verification, please ignore this email.</p>
			<p>Thank you for using Tasks!</p>
		</div>
	</div>
</body>
</html>''';

    try {
      final sendReport = await send(message, smtpServer);
      log('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      log('Message not sent.');
      for (var p in e.problems) {
        log('Problem: ${p.code}: ${p.msg}');
      }
    }

    var connection = PersistentConnection(smtpServer);
    await connection.send(message);

    await connection.close();

    loadingNotifier.value = false;
    instance.loadingNotifier.notifyListeners();
  }

  verifyOtp({required String otp, context}) async {
    if (otp == this.otp) {
      emailVerifyNotifier.value = true;
      emailVerifyNotifier.notifyListeners();
      log('success');
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Invalid Otp')));
    }
  }
}
