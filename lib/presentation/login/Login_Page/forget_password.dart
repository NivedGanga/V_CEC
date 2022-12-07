import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'loginscreen.dart';

final firebaseAuth = FirebaseAuth.instance;

class Forgetpass extends StatelessWidget {
  Forgetpass({Key? key}) : super(key: key);
  final forgetEmailcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromARGB(255, 0, 115, 133),
          Color.fromARGB(255, 225, 255, 239),
        ], begin: Alignment.topRight, end: Alignment.bottomLeft)),
        child: SafeArea(
            child: Center(
          child: Card(
            color: const Color.fromARGB(255, 235, 251, 255),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.95,
              height: MediaQuery.of(context).size.height * 0.28,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: Text(
                      'Are you having trouble signing in?',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 26,
                          color: Color.fromRGBO(26, 113, 130, 1),
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: forgetEmailcontroller,
                      decoration: const InputDecoration(
                        hintText: 'email@ceconline.edu',
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: TextButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    const Color.fromRGBO(26, 113, 130, 1))),
                            onPressed: () {
                              if (forgetEmailcontroller.text.trim() == '') {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  backgroundColor: Colors.red,
                                  behavior: SnackBarBehavior.floating,
                                  margin: EdgeInsets.all(10),
                                  content: Text('Please fill the fields'),
                                ));
                              } else {
                                firebaseAuth
                                    .sendPasswordResetEmail(
                                        email:
                                            forgetEmailcontroller.text.trim())
                                    .then(
                                  (value) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      backgroundColor:
                                          Color.fromARGB(255, 54, 184, 244),
                                      behavior: SnackBarBehavior.floating,
                                      margin: EdgeInsets.all(10),
                                      content: Text(
                                          'Please do check your email spams'),
                                    ));
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (ctx) =>
                                                const LoginScreen()));
                                  },
                                ).onError(
                                  (error, stackTrace) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      backgroundColor: Colors.red,
                                      behavior: SnackBarBehavior.floating,
                                      margin: EdgeInsets.all(10),
                                      content: Text('Email id not registered'),
                                    ));
                                  },
                                );
                              }

                              // if (_status == AuthStatus.successful) {
                              // Navigator.of(context).pushReplacement(
                              //     MaterialPageRoute(builder: (ctx) => LoginScreen()));
                              // } else {
                              //   final error =
                              //       AuthExceptionHandler.generateErrorMessage(_status);
                              //   SnackBar(content: Text(error));
                              // }
                            },
                            child: const Text(
                              'Next',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            )),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}
