import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

Future<void> launchmail(String email, String body) async {
  final Uri uri = Uri(
    scheme: "mailto",
    path: email,
    query: 'subject=subject&body=$body',
  );
  if (!await launchUrl(
    uri,
    mode: LaunchMode.externalNonBrowserApplication,
  )) {
    throw 'Could not launch ';
  }
}

Future<void> launchcall(String num) async {
  final Uri uri = Uri(
    scheme: "tel",
    host: num,
    path: '',
  );
  if (!await launchUrl(
    uri,
    mode: LaunchMode.externalNonBrowserApplication,
  )) {
    throw 'Could not launch ';
  }
}

TextEditingController body = TextEditingController();

class Help extends StatelessWidget {
  const Help({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 228, 236, 255),
      appBar: AppBar(
        title: Text('HELP'),
        backgroundColor: Color.fromARGB(255, 0, 115, 133),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Address',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
            ),
            Center(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 5,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'College of Engineering Chengannur',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          'Chengannur P.O',
                          style: TextStyle(fontSize: 17),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          'Alapuzha District',
                          style: TextStyle(fontSize: 17),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          'Kerala',
                          style: TextStyle(fontSize: 17),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          'PIN 689121',
                          style: TextStyle(fontSize: 17),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Contact',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
            ),
            Center(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 5,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'OFFICE',
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Row(
                          children: [
                            const Text(
                              'reception :',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            GestureDetector(
                                onTap: () {
                                  launchcall('+91-479- 2455125');
                                },
                                child: const Text(
                                  '+91-479- 2455125',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w400),
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Row(
                          children: [
                            const Text(
                              'office :',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w300),
                            ),
                            GestureDetector(
                                onTap: () {
                                  launchcall('+91-479-2454125');
                                },
                                child: const Text(
                                  '+91-479-2454125',
                                  style: TextStyle(color: Colors.blue),
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        GestureDetector(
                            onTap: () {
                              launchmail('principal@ceconline.edu', '');
                            },
                            onLongPress: () {},
                            child: const Text(
                              'principal@ceconline.edu',
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            )),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 5,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'PRODDEC',
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Row(
                          children: [
                            const Text(
                              'PH No:',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w300),
                            ),
                            GestureDetector(
                                onTap: () {
                                  launchcall('+91 81388 49120');
                                },
                                child: const Text(
                                  '+91-813-8849120',
                                  style: TextStyle(color: Colors.blue),
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        GestureDetector(
                            onTap: () {
                              launchmail('proddec@ceconline.edu', '');
                            },
                            child: const Text(
                              'proddec@ceconline.edu',
                              style: TextStyle(color: Colors.blue),
                            )),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 5,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Write your feedbacks to..',
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        TextField(
                          minLines: 1,
                          maxLines: 100,
                          controller: body,
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              launchmail(
                                  'proddecappfeedback@gmail.com', body.text);
                            },
                            child: const Text(
                              'Submit',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255)),
                            )),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
