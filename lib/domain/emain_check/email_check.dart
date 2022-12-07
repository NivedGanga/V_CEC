
import 'package:flutter/material.dart';
import 'package:v_cec_firebse1/presentation/login/Login_Page/Login_Functions.dart';
import 'package:v_cec_firebse1/presentation/screens/faq_screen/faq.dart';

ifcec(now, BuildContext context) {
  int temp = email.length;

  if (email.substring(temp - 13, temp) == "ceconline.edu") {
    return IconButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
            return const faqpage();
          }));
        },
        icon: const Icon(Icons.question_answer));
  } else {
    return Container();
  }
}