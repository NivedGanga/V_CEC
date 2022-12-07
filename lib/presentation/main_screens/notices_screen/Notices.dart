import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:readmore/readmore.dart';

class Notices extends StatelessWidget {
  Notices({Key? key}) : super(key: key);

  late String? _host, _path;
  linkslice(String url) {
    int temp = 8, i = 8;
    while (url[i] != '/' && i < url.length) {
      i++;
    }

    _host = url.substring(temp, i);

    _path = url.substring(i + 1, url.length);
  }

  Future<void> launchnotice(String url) async {
    await linkslice(url);

    final Uri uri = Uri(
      scheme: "https",
      host: _host,
      path: _path,
    );
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalNonBrowserApplication,
    )) {
      throw 'Could not launch ';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
              color: const Color.fromARGB(255, 228, 236, 255),
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('eNotification')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ListView.separated(
                      itemBuilder: (BuildContext context, index) {
                        DocumentSnapshot notice = snapshot.data!.docs[index];
                        return Padding(
                          padding: const EdgeInsets.only(left: 25, right: 25),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        color: Color.fromARGB(255, 0, 86, 99),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                        )),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5, bottom: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            notice['title'],
                                            style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, top: 20, bottom: 2),
                                    child: ReadMoreText(
                                      notice['details'],
                                      postDataTextStyle: const TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 0, 37, 245),
                                      ),
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300),
                                      lessStyle: TextStyle(
                                        color: Colors.teal[900],
                                        fontSize: 13,
                                      ),
                                      trimLines: 2,
                                      trimMode: TrimMode.Line,
                                      trimCollapsedText: 'Show more',
                                      trimExpandedText: 'Show less',
                                      moreStyle: TextStyle(
                                        color: Colors.teal[900],
                                        fontSize: 13,
                                      ),
                                    )),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.78,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        notice['date'],
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color:
                                              Color.fromARGB(255, 126, 32, 32),
                                        ),
                                      ),
                                      (notice['link1'] != '')
                                          ? TextButton(
                                              onPressed: () {
                                                launchnotice(notice['link1']);
                                              },
                                              child: const Text(
                                                'LINK',
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    color: Color.fromARGB(
                                                        255, 126, 32, 32)),
                                              ),
                                            )
                                          : Container(),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext, index) {
                        return SizedBox(height: 20);
                      },
                      itemCount: snapshot.data!.docs.length,
                    );
                  }
                },
              ))),
    );
  }
}
