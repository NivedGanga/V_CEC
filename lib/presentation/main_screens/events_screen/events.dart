import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:v_cec_firebse1/presentation/main_screens/events_screen/events/detailed.dart';

import 'package:v_cec_firebse1/core/constants/constants.dart';

class events extends StatefulWidget {
  const events({Key? key}) : super(key: key);

  @override
  State<events> createState() => _eventsState();
}

class _eventsState extends State<events> {
  seemore(BuildContext context, index) {
    if (index == forum.length - 1) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.03,
      );
    } else {
      return ListTile(
        title: Row(
          children: [
            Text(
              forum[index],
              style: const TextStyle(
                  fontFamily: 'cascadia',
                  fontSize: 25,
                  color: Color.fromARGB(255, 0, 86, 99),
                  decorationStyle: TextDecorationStyle.solid,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
        trailing: TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => forum_pages[index])));
            },
            child: const Text(
              "see more",
              style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
            )),
      );
    }
  }

  final _pagecontroller = PageController();
  final forum_firebase = [
    FirebaseFirestore.instance
        .collection('eproddec')
        .orderBy('no', descending: true)
        .snapshots(),
    FirebaseFirestore.instance
        .collection('eIeee')
        .orderBy('no', descending: true)
        .snapshots(),
    FirebaseFirestore.instance
        .collection('eIedc')
        .orderBy('no', descending: true)
        .snapshots(),

    FirebaseFirestore.instance
        .collection('etinkerhub')
        .orderBy('no', descending: true)
        .snapshots(),
    FirebaseFirestore.instance
        .collection('eNss')
        .orderBy('no', descending: true)
        .snapshots(),
    FirebaseFirestore.instance
        .collection('eMediacell')
        .orderBy('no', descending: true)
        .snapshots(),

    FirebaseFirestore.instance
        .collection('eNcc')
        .orderBy('no', descending: true)
        .snapshots(),
    FirebaseFirestore.instance
        .collection('eArc')
        .orderBy('no', descending: true)
        .snapshots(),
    FirebaseFirestore.instance
        .collection('eExess')
        .orderBy('no', descending: true)
        .snapshots(),

    FirebaseFirestore.instance
        .collection('eFoces')
        .orderBy('no', descending: true)
        .snapshots(),
    FirebaseFirestore.instance
        .collection('eSurge')
        .orderBy('no', descending: true)
        .snapshots(),

    FirebaseFirestore.instance
        .collection('eEdclub')
        .orderBy('no', descending: true)
        .snapshots(),
    FirebaseFirestore.instance
        .collection('eCecify')
        .orderBy('no', descending: true)
        .snapshots(),
    FirebaseFirestore.instance
        .collection('eTpc')
        .orderBy('no', descending: true)
        .snapshots(),
    // FirebaseFirestore.instance.collection('bNull').snapshots(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 228, 236, 255),
        child: ListView.separated(
            itemBuilder: (BuildContext context, index) {
              return seemore(context, index);
            },
            separatorBuilder: (BuildContext context, index) {
              return Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(100)),
                  height: MediaQuery.of(context).size.height * 0.40,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: forum_firebase[index],
                    builder: (BuildContext context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return PageView.builder(
                            itemCount: snapshot.data!.docs.length,
                            controller: _pagecontroller,
                            pageSnapping: false,
                            onPageChanged: (value) {},
                            itemBuilder: (context, imageposition) {
                              DocumentSnapshot eventpic =
                                  snapshot.data!.docs[imageposition];
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: SizedBox.fromSize(
                                    size: const Size.fromRadius(
                                        80), // Image radius
                                    child: TextButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(builder: (ctx) {
                                            return detailed(
                                              event: eventpic,
                                            );
                                          }));
                                        },
                                        child: CachedNetworkImage(
                                          imageUrl: eventpic['image'],
                                          imageBuilder:
                                              (context, imageprovider) {
                                            return Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                image: DecorationImage(
                                                  image: imageprovider,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            );
                                          },
                                        ))),
                              );
                            });
                      }
                    },
                  ));
            },
            itemCount: forum.length),
      ),
    );
  }
}
