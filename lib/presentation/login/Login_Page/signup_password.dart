import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:v_cec_firebse1/presentation/login/Login_Page/Login_Functions.dart';
import 'package:v_cec_firebse1/presentation/login/Login_Page/loginscreen.dart';
import 'signup_mail.dart';
import 'package:v_cec_firebse1/presentation/home/home.dart';

enum AuthStatus {
  successful,
  wrongPassword,
  emailAlreadyExists,
  invalidEmail,
  weakPassword,
  unknown,
}

class AuthExceptionHandler {
  static handleAuthException(FirebaseAuthException e) {
    AuthStatus status;
    switch (e.code) {
      case "invalid-email":
        status = AuthStatus.invalidEmail;
        break;
      case "wrong-password":
        status = AuthStatus.wrongPassword;
        break;
      case "weak-password":
        status = AuthStatus.weakPassword;
        break;
      case "email-already-in-use":
        status = AuthStatus.emailAlreadyExists;
        break;
      default:
        status = AuthStatus.unknown;
    }
    return status;
  }

  static String generateErrorMessage(error) {
    String errorMessage;
    switch (error) {
      case AuthStatus.invalidEmail:
        errorMessage = "Your email address appears to be malformed.";
        break;
      case AuthStatus.weakPassword:
        errorMessage = "Your password should be at least 6 characters.";
        break;
      case AuthStatus.wrongPassword:
        errorMessage = "Your email or password is wrong.";
        break;
      case AuthStatus.emailAlreadyExists:
        errorMessage =
            "The email address is already in use by another account.";
        break;
      default:
        errorMessage = "An error occured. Please try again later.";
    }
    return errorMessage;
  }
}

class Signup_password extends StatelessWidget {
  Signup_password({Key? key}) : super(key: key);
  final passwordconroller = TextEditingController();
  final repasswordconroller = TextEditingController();
  final usernamecontroller = TextEditingController();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    //     });
    //     _firebaseAuth.currentUser!.updateDisplayName(name);
    //     _status = AuthStatus.successful;
    //   } on FirebaseAuthException catch (e) {
    //     _status = AuthExceptionHandler.handleAuthException(e);
    //   }
    //   return _status;
    // }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromARGB(255, 0, 115, 133),
          Color.fromARGB(255, 225, 255, 239),
        ], begin: Alignment.topRight, end: Alignment.bottomLeft)),
        child: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              height: 5,
            ),
            const Center(
              child: Text(
                'SIGN UP',
                style: TextStyle(
                    shadows: [
                      Shadow(
                        offset: Offset(3.0, 2.0),
                        blurRadius: 8.0,
                        color: Color.fromARGB(255, 1, 76, 35),
                      ),
                    ],
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    color: Color.fromARGB(255, 240, 253, 255)),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Center(
              child: Card(
                color: const Color.fromARGB(255, 235, 251, 255),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Create a password',
                          style: TextStyle(
                              fontSize: 30,
                              color: Color.fromRGBO(26, 113, 130, 1),
                              fontWeight: FontWeight.w700),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                            controller: usernamecontroller,
                            decoration: const InputDecoration(
                              labelText: 'Full Name',
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                            obscureText: true,
                            controller: passwordconroller,
                            decoration: const InputDecoration(
                              labelText: 'Enter password',
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                            controller: repasswordconroller,
                            decoration: const InputDecoration(
                              labelText: 'Confirm password',
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: TextButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              const Color.fromRGBO(
                                                  26, 113, 130, 1))),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    'Back',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  )),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 30),
                              child: TextButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              const Color.fromRGBO(
                                                  26, 113, 130, 1))),
                                  onPressed: () async {
                                    if (passwordconroller.text.trim() == null ||
                                        passwordconroller.text.trim() == '' ||
                                        repasswordconroller.text.trim() ==
                                            null ||
                                        repasswordconroller.text.trim() == '') {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        backgroundColor: Colors.red,
                                        behavior: SnackBarBehavior.floating,
                                        margin: EdgeInsets.all(10),
                                        content: Text('Please fill the fields'),
                                      ));
                                    } else if (passwordconroller.text.trim() ==
                                        repasswordconroller.text.trim()) {
                                      _firebaseAuth
                                          .createUserWithEmailAndPassword(
                                              email:
                                                  emailcontroller.text.trim(),
                                              password: repasswordconroller.text
                                                  .trim())
                                          .then((value) async {
                                        FirebaseFirestore.instance
                                            .collection('UserData')
                                            .doc(value.user!.uid)
                                            .set({
                                          "email": value.user!.email,
                                          "Username": usernamecontroller.text
                                              .trim()
                                              .toUpperCase(),
                                          "Profile_Image": ''
                                          // "Profile Pic": value.user!.photoURL
                                        });
                                        email = emailcontroller.text.trim();
                                        ktuidcheck();
                                        username = usernamecontroller.text
                                            .trim()
                                            .toUpperCase();

                                        final sharedpref =
                                            await SharedPreferences
                                                .getInstance();
                                        sharedpref.setString(
                                            'username',
                                            usernamecontroller.text
                                                .trim()
                                                .toUpperCase());
                                        sharedpref.setString('email',
                                            emailcontroller.text.trim());
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        HomeScreen()),
                                                (route) => false);
                                      });
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        backgroundColor: Colors.red,
                                        behavior: SnackBarBehavior.floating,
                                        margin: EdgeInsets.all(10),
                                        content:
                                            Text("The passwords doesn't match"),
                                      ));
                                    }
                                  },
                                  child: const Text(
                                    'next',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  )),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
            )
          ],
        )),
      ),
    );
  }
}
