import 'package:flutter/material.dart';

import 'package:v_cec_firebse1/presentation/login/Login_Page/signup_password.dart';
import 'signup_mail.dart';

class Signup_verify extends StatelessWidget {
  Signup_verify({Key? key}) : super(key: key);

  final TextEditingController otpcontroller = TextEditingController();
  final otpcontroller1 = List.generate(6, ((index) => TextEditingController()));

  // void verify(BuildContext context) {
  //   if (emailAuth.validateOtp(
  //       recipientMail: emailcontroller.value.text.trim(),
  //       userOtp: otpcontroller1.toString())) {
  //     Navigator.push(
  //         context, MaterialPageRoute(builder: ((ctx) => Signup_password())));
  //   } else {}
  //   const Center(
  //     child: CircularProgressIndicator(),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromARGB(255, 0, 115, 133),
          Color.fromARGB(255, 225, 255, 239),
        ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: SafeArea(
            child: ListView(
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: const Color.fromARGB(255, 235, 251, 255),
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: SizedBox(
                  // height: MediaQuery.of(context).size.width * 0.45,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        "Enter OTP",
                        style: TextStyle(
                            fontSize: 30,
                            color: Color.fromRGBO(26, 113, 130, 1),
                            fontWeight: FontWeight.w700),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: otpcontroller,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color.fromRGBO(26, 113, 130, 1))),
                              onPressed: () {
                                final otp = otpcontroller.text;
                                if (otp == null ||
                                    otp == '' ||
                                    otp.length != 6) {
                                  //snackbar
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    elevation: 0,
                                    backgroundColor:
                                        Color.fromARGB(0, 244, 67, 54),
                                    behavior: SnackBarBehavior.floating,
                                    margin: EdgeInsets.all(10),
                                    content: Text(
                                      'Please Enter OTP',
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 16),
                                      textAlign: TextAlign.center,
                                    ),
                                  ));
                                } else if (otpcontroller.text == randomNumber) {
                                  print(otpcontroller.text == randomNumber);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((ctx) =>
                                              Signup_password())));
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    elevation: 0,
                                    backgroundColor:
                                        Color.fromARGB(0, 244, 67, 54),
                                    behavior: SnackBarBehavior.floating,
                                    margin: EdgeInsets.all(10),
                                    content: Text(
                                      'Invalid OTP',
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 16),
                                      textAlign: TextAlign.center,
                                    ),
                                  ));
                                }
                              },
                              child: const Text(
                                "Verify",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              )),
                          const SizedBox(
                            width: 20,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
