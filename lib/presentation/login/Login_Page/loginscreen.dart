import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v_cec_firebse1/domain/firebase_functions/fn_profilepic/fn_profilepic.dart';
import 'package:v_cec_firebse1/presentation/login/Login_Page/Login_Functions.dart';

import 'package:v_cec_firebse1/presentation/login/Login_Page/fire_auth.dart';
import 'package:v_cec_firebse1/presentation/login/Login_Page/forget_password.dart';
import 'package:v_cec_firebse1/presentation/login/Login_Page/signup_mail.dart';

import 'package:v_cec_firebse1/presentation/home/home.dart';
import 'signup_password.dart';

String username = '';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
getUid() {
  if (firebaseAuth.currentUser!.uid != null) {
    return firebaseAuth.currentUser!.uid;
  }
}

getUserName() async {
  DocumentSnapshot? doc = await FirebaseFirestore.instance
      .collection("UserData")
      .doc(getUid())
      .get();
  if (doc != null) {
    final sharedpref = await SharedPreferences.getInstance();
    var data = doc;
    username = await data["Username"];
    sharedpref.setString('username', data["Username"]);
    print(data["Username"]);
  } else {
    return null;
  }
}

Future<AuthStatus> login({
  required String email,
  required String password,
}) async {
  var status;
  try {
    await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    status = AuthStatus.successful;
  } on FirebaseAuthException catch (e) {
    status = AuthExceptionHandler.handleAuthException(e);
  }
  return status;
}

Future<void> resetPassword(String email) async {
  await firebaseAuth.sendPasswordResetEmail(email: email);
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  var focusEmail, focuspassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromARGB(255, 0, 115, 133),
          Color.fromARGB(255, 225, 255, 239),
        ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        'V CEC',
                        style: TextStyle(
                            shadows: [
                              Shadow(
                                offset: Offset(3.0, 2.0),
                                blurRadius: 8.0,
                                color: Color.fromARGB(255, 0, 83, 39),
                              ),
                            ],
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w900,
                            fontSize: 45),
                      )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.12,
                  ),
                  Card(
                    color: const Color.fromARGB(255, 235, 251, 255),
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                            controller: _emailTextController,
                            focusNode: focusEmail,
                            validator: (value) =>
                                Validator.validateEmail(email: value!),
                            decoration: const InputDecoration(
                                // border: OutlineInputBorder(
                                //     borderRadius:
                                //         BorderRadius.all(Radius.circular(20))),
                                hintText: 'email@ceconline.edu',
                                labelText: 'Email'),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: TextFormField(
                            obscureText: true,
                            controller: _passwordTextController,
                            focusNode: focuspassword,
                            validator: (value) =>
                                Validator.validatePassword(password: value!),
                            decoration: const InputDecoration(
                              // border: OutlineInputBorder(
                              //     borderRadius:
                              //         BorderRadius.all(Radius.circular(20))),
                              labelText: 'Password',
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return Forgetpass();
                                }));
                              },
                              child: const Text(
                                'Forgot Password',
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ],
                        ),
                        Container(
                            height: 36,
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                  const Color.fromRGBO(26, 113, 130, 1),
                                )),
                                child: const Text(
                                  'Sign In',
                                  style: TextStyle(fontSize: 18),
                                ),
                                onPressed: () async {
                                  if (_emailTextController.text == '' ||
                                      _passwordTextController.text == '') {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      backgroundColor: Colors.red,
                                      behavior: SnackBarBehavior.floating,
                                      margin: EdgeInsets.all(10),
                                      content: Text('Please fill the fields'),
                                    ));
                                  } else {
                                    final sharedpref =
                                        await SharedPreferences.getInstance();
                                    await firebaseAuth
                                        .signInWithEmailAndPassword(
                                            email: _emailTextController.text
                                                .trim(),
                                            password: _passwordTextController
                                                .text
                                                .trim())
                                        .then((value) async {
                                      getUserName();

                                      email = _emailTextController.text.trim();
                                      ktuidcheck();
                                      await getUserPhoto();
                                      sharedpref.setString('email',
                                          _emailTextController.text.trim());
                                      //await Future.delayed(Duration(seconds: 3));
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const HomeScreen()),
                                          (route) => false);
                                    }).onError((error, stackTrace) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        backgroundColor: Colors.red,
                                        behavior: SnackBarBehavior.floating,
                                        margin: EdgeInsets.all(10),
                                        content: Text('Invalid credentials'),
                                      ));
                                    });
                                  }
                                })),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Do not have account?'),
                            TextButton(
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(fontSize: 20),
                              ),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const Signup_mail()),
                                ); //signup screen
                              },
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),

                        //GOOGLE SIGN IN

                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     TextButton(
                        //         style: ButtonStyle(
                        //             backgroundColor:
                        //                 MaterialStateProperty.all(Colors.tealAccent[400])),
                        //         onPressed: () {
                        //           signup();
                        //         },
                        //         child: Row(
                        //           children: [
                        //             Container(
                        //                 height: 30,
                        //                 width: 30,
                        //                 child:
                        //                     Image.asset('assets/images/google-logo.png')),
                        //             Text('Sign In With Google',
                        //                 style: TextStyle(
                        //                   color: Colors.white,
                        //                 ))
                        //           ],
                        //         )),
                        //   ],
                        // )
                      ],
                    ),
                  )
                ])),
      ),
    );
  }
}
