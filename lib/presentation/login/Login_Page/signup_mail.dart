import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:v_cec_firebse1/presentation/login/Login_Page/signup_verify.dart';
import 'package:email_auth/email_auth.dart';

EmailAuth emailAuth = EmailAuth(sessionName: "V-CEC");
final TextEditingController emailcontroller = TextEditingController();

class Signup_mail extends StatefulWidget {
  const Signup_mail({Key? key}) : super(key: key);

  @override
  State<Signup_mail> createState() => _Signup_mailState();
}

class _Signup_mailState extends State<Signup_mail> {
  var submitValid;

  EmailAuth emailAuth = EmailAuth(sessionName: "V-CEC");

  @protected
  void sendOtp() async {
    bool result = await emailAuth.sendOtp(
        recipientMail: emailcontroller.value.text.trim(), otpLength: 6);
    if (result) {
      // using a void function because i am using a
      // stateful widget and seting the state from here.
      setState(() {
        submitValid = true;
      });
    }
  }

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
          child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
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
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.18,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                color: const Color.fromARGB(255, 235, 251, 255),
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: SizedBox(
                  height: MediaQuery.of(context).size.width * 0.5,
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        'Enter your email',
                        style: TextStyle(
                            fontSize: 30,
                            color: Color.fromRGBO(26, 113, 130, 1),
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              // validator: ((value) {
                              //   if (value == null && value == '') {
                              //     return 'inavlid email id';
                              //   } else {}
                              // }),
                              controller: emailcontroller,
                              decoration: const InputDecoration(
                                hintText: 'email@ceconline.edu',
                              ),
                            ),
                            // Visibility(
                            //   visible: !_isvalide,
                            //   child: Text(
                            //     'invalid email id',
                            //     style: TextStyle(color: Colors.red, fontSize: 15),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * .75),
                        child: Row(
                          children: [
                            TextButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        const Color.fromRGBO(26, 113, 130, 1))),
                                onPressed: () {
                                  checklogin(context);
                                  // () {
                                  //   _formkey.currentstate
                                  // };
                                },
                                child: const Text(
                                  'Next',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      )),
    ));
  }

  checkIfEmailInUse(String emailAddress) async {
    //try {
    // Fetch sign-in methods for the email address
    final list =
        await FirebaseAuth.instance.fetchSignInMethodsForEmail(emailAddress);

    // In case list is not empty
    if (list.isNotEmpty) {
      // Return true because there is an existing
      // user using the email address
      return 0;
    } else {
      // Return false because email adress is not in use
      return 1;
    }
    // } catch (error) {
    //   // Handle error
    //   // ...
    //   return 0;
    // }
  }

  void checklogin(BuildContext ctx) async {
    final mail = emailcontroller.text.trim();
    //int check = );
    if (mail == null || mail == '') {
      //snackbar
      ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(10),
        content: Text('Please enter a email id'),
      ));
    } else if (await checkIfEmailInUse(emailcontroller.text.trim()) == 0) {
      ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(10),
        content: Text('The mail is already in use.'),
      ));
    } else {
      sendOtp();
      Navigator.push(
          context, MaterialPageRoute(builder: ((ctx) => Signup_verify())));
    }
    // if (submitValid == true) {
    // Navigator.push(
    //     context, MaterialPageRoute(builder: ((ctx) => Signup_verify())));
    // } else {
    //   ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
    //     backgroundColor: Colors.red,
    //     behavior: SnackBarBehavior.floating,
    //     margin: EdgeInsets.all(10),
    //     content: Text('Invalid email id'),
    //   ));
    // }
    //}
  }
}
