import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:v_cec_firebse1/presentation/main_screens/departments_screen/branch_widgets/depclasses.dart';

class AppliedSciece extends StatelessWidget {
  const AppliedSciece({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 115, 133),
        automaticallyImplyLeading: false,
        title: const Text(
          'Applied Science',
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Container(
        decoration: const BoxDecoration(color: Color.fromARGB(255, 0, 86, 99)),
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('aeStaff').snapshots(),
            builder: (BuildContext context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ListView.separated(
                  itemBuilder: (BuildContext context, index) {
                    int end = snapshot.data!.docs.length;
                    DocumentSnapshot collegestaff = snapshot.data!.docs[index];
                    return alertstyle(context, index, collegestaff, end);
                  },
                  separatorBuilder: (BuildContext context, index) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    );
                  },
                  itemCount: snapshot.data!.docs.length,
                );
              }
            },
          ),
        ),
      )),
    );
  }
}
