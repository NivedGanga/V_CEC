import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

//final Uri _url = Uri.parse('https://flutter.dev');
late String? _scheme, _host, _path;
linkslice(String url) {
  if (url.substring(0, 5) == 'https') {
    int temp = 8, i = 8;
    while (url[i] != '/' && i < url.length) {
      i++;
    }

    _host = url.substring(temp, i);

    _path = url.substring(i + 1, url.length);
  } else if (url.substring(0, 4) == 'http' && url[4] != 's') {
    int temp = 7, i = 7;
    while (url[i] != '/' && i < url.length) {
      i++;
    }

    _host = url.substring(temp, i);

    _path = url.substring(i + 1, url.length);
  } else {
    int temp = 0, i = 0;
    while (url[i] != '/' && i < url.length) {
      i++;
    }
    _host = url.substring(temp, i);

    _path = '';
    print(_host);
    print(_path);
    // _path = url.substring(i + 1, url.length);
  }
}

Future<void> launchRegister(String url) async {
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

class detailed extends StatefulWidget {
  final DocumentSnapshot event;
  const detailed({required this.event});

  @override
  State<detailed> createState() => _detailedState();
}

class _detailedState extends State<detailed> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('bProddec')
            .orderBy('no', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Scaffold(
                backgroundColor: const Color.fromARGB(255, 228, 236, 255),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
                floatingActionButton: (widget.event['link1'] != '')
                    ? TextButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(400)),
                            )),
                            fixedSize:
                                MaterialStateProperty.all(const Size(150, 65)),
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 8, 120, 137))),
                        onPressed: () {
                          launchRegister(widget.event['link1']);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "Register",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            )
                          ],
                        ),
                      )
                    : Container(),
                body: SafeArea(
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.95,
                                  height:
                                      MediaQuery.of(context).size.width * 0.95,
                                  child: CachedNetworkImage(
                                    imageUrl: widget.event['image'],
                                    imageBuilder: (context, ImageProvider) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          image: DecorationImage(
                                            image: ImageProvider,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.03,
                                    ),
                                    Text(
                                      widget.event['Quote'],
                                      style: const TextStyle(
                                        //fontStyle: FontStyle.italic,
                                        fontSize: 21,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                    ),
                                    SizedBox(
                                        child: Text(
                                      widget.event['details'],
                                      style: const TextStyle(
                                        fontSize: 18,
                                      ),
                                      textAlign: TextAlign.left,
                                    )),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                    ),
                                    (widget.event['date'] != '')
                                        ? Row(
                                            children: [
                                              const Icon(Icons.calendar_month),
                                              Text(
                                                '''Date:   ${widget.event['date']} ''',
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          )
                                        : Container(),
                                    (widget.event['time'] != '')
                                        ? Row(
                                            children: [
                                              const Icon(Icons.timer_sharp),
                                              Text(
                                                '''Time:   ${widget.event['time']} ''',
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          )
                                        : Container(),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.12,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ));
          }
        });
  }
}
