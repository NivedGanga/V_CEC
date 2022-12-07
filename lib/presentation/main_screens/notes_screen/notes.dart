import 'package:flutter/material.dart';
import 'package:v_cec_firebse1/presentation/main_screens/notes_screen/notes/s1ands2.dart';
import 'package:v_cec_firebse1/presentation/main_screens/notes_screen/notes/s3.dart';
import 'package:v_cec_firebse1/presentation/main_screens/notes_screen/notes/s4.dart';
import 'package:v_cec_firebse1/presentation/main_screens/notes_screen/notes/s5.dart';
import 'package:v_cec_firebse1/presentation/main_screens/notes_screen/notes/s6.dart';
import 'package:v_cec_firebse1/presentation/main_screens/notes_screen/notes/s7.dart';
import 'package:v_cec_firebse1/presentation/main_screens/notes_screen/notes/s8.dart';

class Notes extends StatelessWidget {
  const Notes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 228, 236, 255),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(38.0),
        child: ListView.separated(
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 15,
            );
          },
          itemCount: 7,
          itemBuilder: ((context, index) {
            return Card(
              shadowColor: Colors.black,
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return notespages[index];
                    },
                  ));
                },
                title: Text(
                  semesters[index],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 18),
                ),
                tileColor: const Color.fromARGB(255, 255, 255, 255),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                      width: 0.5, color: Color.fromARGB(255, 0, 119, 101)),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            );
          }),
        ),
      )),
    );
  }
}

final notespages = [
  Sem1andSem2(),
  const Semester3(),
  const Semester4(),
  const Semester5(),
  const Semester6(),
  const Semester7(),
  const Semester8(),
];
final semesters = [
  'SEMESTER 1&2',
  'SEMESTER 3',
  'SEMESTER 4',
  'SEMESTER 5',
  'SEMESTER 6',
  'SEMESTER 7',
  'SEMESTER 8',
];
