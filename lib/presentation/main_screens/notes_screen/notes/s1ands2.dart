import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Sem1andSem2 extends StatelessWidget {
  Sem1andSem2({super.key});
  late String? _host, _path;

  linkslice(String url) {
    int temp = 8, i = 8;
    while (url[i] != '/' && i < url.length) {
      i++;
    }

    _host = url.substring(temp, i);

    _path = url.substring(i + 1, url.length);
  }

  Future<void> launchnotes(String url) async {
    await linkslice(url);

    final Uri uri = Uri(
      scheme: "https",
      host: _host,
      path: _path,
    );
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch ';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 228, 236, 255),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 115, 133),
      ),
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('S1&S2')
                    .orderBy('no', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: Text('Notes will be uploaded soon'),
                    );
                  } else {
                    return ListView.separated(
                        itemBuilder: (BuildContext context, index) {
                          DocumentSnapshot filedata =
                              snapshot.data!.docs[index];
                          return Card(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      width: 0.5,
                                      color: Color.fromARGB(255, 5, 147, 97)),
                                  borderRadius: BorderRadius.circular(20)),
                              onTap: () {
                                launchnotes(filedata['link']);
                              },
                              title: Text(subjects[index]),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 8,
                          );
                        },
                        itemCount: subjects.length);
                  }
                },
              ))),
    );
  }
}

const subjects = [
  'Linear Algebra and Calculus',
  'Engineering Physics',
  'Basics of mechanical Engineering',
  'Basics of Civil Engineering',
  'Engineering Mechanics',
  'Life Skills',
  'Vector Calculus, Differential Equations and Transforms',
  'Engineering Chemistry',
  'Basics of Electronics Engineering',
  'Basics of Electrical Engineering',
  'Engineering Graphics',
  'Programming in C',
  'Proffessional Communication',
];
