import 'package:flutter/material.dart';
import 'package:v_cec_firebse1/presentation/main_screens/departments_screen/branch_widgets/depclasses.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ComputerScience extends StatelessWidget {
  const ComputerScience({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 115, 133),
        automaticallyImplyLeading: false,
        title: const Text(
          'Computer Science',
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Container(
        color: const Color.fromARGB(255, 0, 86, 99),
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: SingleChildScrollView(
            child: Column(
              children: [
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('csStaff')
                      .snapshots(),
                  builder: (BuildContext context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, index) {
                          int end = snapshot.data!.docs.length;
                          DocumentSnapshot collegestaff =
                              snapshot.data!.docs[index];
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
                // Divider(
                //   color: Colors.white,
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Technical Staffs',
                      style: TextStyle(
                          fontSize: 25,
                          color: Color.fromARGB(255, 117, 219, 205)),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                const Divider(
                  color: Colors.white,
                ),
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('csLab')
                        .snapshots(),
                    builder: (BuildContext context, snapshot) {
                      if (!snapshot.hasData) {
                        return Container();
                      } else {
                        return ListView.separated(
                          shrinkWrap: true,
                          physics:const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, index) {
                            int end = snapshot.data!.docs.length;
                            DocumentSnapshot collegestaff =
                                snapshot.data!.docs[index];
                            return alertstyle(
                                context, index, collegestaff, end);
                          },
                          separatorBuilder: (BuildContext context, index) {
                            return SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            );
                          },
                          itemCount: snapshot.data!.docs.length,
                        );
                      }
                    }),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
