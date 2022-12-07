import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class faqpage extends StatelessWidget {
  const faqpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:const Color.fromARGB(255, 0, 115, 133),
        title:const Text('FAQ',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 30,
            )),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(20),
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('faq').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          DocumentSnapshot faq = snapshot.data!.docs[index];

                          return Column(
                            children: [
                              ListTile(
                                title: Text(
                                  faq['question'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color:const Color.fromARGB(255, 9, 48, 58),
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            .025,
                                  ),
                                ),
                              ),
                              ListTile(
                                title: Text(
                                  faq['ans'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color:const Color.fromARGB(255, 9, 48, 58),
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            .02,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider(
                            height: 2,
                          );
                        },
                        itemCount: snapshot.data!.docs.length,
                      ),
                    );
                  }
                },
              ))),
    );
  }
}
