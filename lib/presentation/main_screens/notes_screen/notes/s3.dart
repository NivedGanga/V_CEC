import 'package:flutter/material.dart';

class Semester3 extends StatelessWidget {
  const Semester3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:const Color.fromARGB(255, 0, 115, 133),
      ),
      body:const SafeArea(
          child: Center(
        child: Text('Notes will be uploaded soon'),
      )),
    );
  }
}
