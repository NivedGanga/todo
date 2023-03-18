import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/infrastructure/user/model/user_model.dart';
import 'package:todo/presentation/homepage/homepage.dart';

class Login {
  Login._internal();
  static Login instance = Login._internal();
  factory Login() {
    return instance;
  }
  final ValueNotifier<bool> loadingNotifier = ValueNotifier(false);
  Future<void> signInWithEmailAndPassword(
      {required String email,
      required String password,
      required context}) async {
    loadingNotifier.value = true;
    loadingNotifier.notifyListeners();
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      loadingNotifier.value = false;
      loadingNotifier.notifyListeners();
      User user = userCredential.user!;
      UserModel.instance.uid = user.uid;
      log('Signed in user: ${user.uid}');
      final Sharedprefs = await SharedPreferences.getInstance();
      Sharedprefs.setString('uid', user.uid);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
          (route) => false);
    } on FirebaseAuthException catch (e) {
      final String rspo;
      if (e.code == 'user-not-found') {
        rspo = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        rspo = 'Wrong password provided for that user.';
      } else {
        rspo = 'Error signing in: ${e.message}';
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(rspo)));
    } catch (e) {
      print('Error signing in: $e');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error signing in: $e')));
    }
    loadingNotifier.value = false;
    loadingNotifier.notifyListeners();
  }
}
