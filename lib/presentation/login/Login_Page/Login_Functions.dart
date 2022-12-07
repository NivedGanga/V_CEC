import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v_cec_firebse1/domain/uploadUserImage.dart';

import 'package:v_cec_firebse1/presentation/home/home.dart';

import 'package:v_cec_firebse1/presentation/login/Login_Page/loginscreen.dart';


logincheck(BuildContext context) async {
  final sharedprefs = await SharedPreferences.getInstance();
  String? savedvalue = sharedprefs.getString('email');
  username = sharedprefs.getString('username') ?? 'username';
  profilepiclink.value = sharedprefs.getString('profilepic') ?? '';

  if (savedvalue != null) {
    email = savedvalue;
    ktuidcheck();

    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (ctx) => HomeScreen()));
  } else {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => const LoginScreen()));
  }
}

logout(BuildContext context) async {
  final sharedpref = await SharedPreferences.getInstance();
  sharedpref.remove('email');

  sharedpref.remove('profilepic');
  sharedpref.remove('username');
  Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (ctx) => const LoginScreen()));
}

// function to implement the google signin

// creating firebase instance
final FirebaseAuth auth = FirebaseAuth.instance;

signup() async {
  final googleSignIn = GoogleSignIn();
  final googleUser = await googleSignIn.signIn();
  if (googleUser != null) {
    final googleAuth = await googleUser.authentication;
    if (googleAuth.idToken != null) {
      final userCrediential = await auth.signInWithCredential(
        GoogleAuthProvider.credential(
            idToken: googleAuth.idToken, accessToken: googleAuth.accessToken),
      );
      return userCrediential.user;
    } else {
      throw FirebaseAuthException(
        message: "Sign in aborted by user",
        code: "ERROR_ABORTED_BY_USER",
      );
    }
  }
}

late String email;
late String ktuid;

ktuidcheck() {
  String temp = email.substring(0, 3);

  String char = email[0];
  int length = 0;

  if (temp == 'chn' || temp == 'CHN') {
    while (char != '@') {
      char = email[length];

      length++;
    }
    ktuid = email.substring(0, length - 1).toUpperCase();
  } else {
    ktuid = '';
  }
}
