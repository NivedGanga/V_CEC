import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

isstart(BuildContext context, int index) {
  if (index == 0) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.03,
    );
  } else {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.0,
    );
  }
}

isend(BuildContext context, int index, int end) {
  if (index == end - 1) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.04,
    );
  } else {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.0,
    );
  }
}

alertstyle(BuildContext context, index, DocumentSnapshot<Object?> collegestaff,
    int end) {
  return Padding(
    padding: const EdgeInsets.only(left: 0, right: 0),
    child: Column(
      children: [
        isstart(context, index),
        SizedBox(
          width: double.infinity,
          height: 60,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: const Color.fromARGB(255, 219, 218, 234),
            ),
            child: TextButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    const RoundedRectangleBorder(
                  side: BorderSide(
                    color: Color.fromARGB(255, 0, 0, 0),
                    width: 1.2,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(200),
                  ),
                )),
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        title: Text(
                          collegestaff['name'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                        content: SizedBox(
                          height: MediaQuery.of(context).size.height * .24,
                          child: details(collegestaff, context),
                        ),
                      );
                    });
              },
              child: Row(
                children: [
                  Expanded(
                    flex: 18,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.05,
                        ),
                        Text(
                          collegestaff['name'],
                          textAlign: TextAlign.center,
                          style:const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 3, 113, 113),
                          ),
                        ),
                      ],
                    ),
                  ),
                const  Expanded(
                    flex: 2,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        isend(context, index, end),
      ],
    ),
  );
}

details(DocumentSnapshot<Object?> collegestaff, BuildContext context) {
  return Column(
    children: [
     const Expanded(
        flex: 1,
        child: SizedBox(),
      ),
      Expanded(
        flex: 3,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 1, top: 2, bottom: 2),
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration:
                    const  BoxDecoration(color: Color.fromARGB(255, 181, 223, 202)),
                  child:const Center(
                    child: Text(
                      'Designation',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(left: 1, top: 2, bottom: 2),
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration:const BoxDecoration(
                    color: Color.fromARGB(255, 219, 218, 234),
                  ),
                  child: Center(
                    child: Text(
                      collegestaff['designation'],
                      textAlign: TextAlign.center,
                      style:const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
     const Expanded(
        flex: 1,
        child: SizedBox(),
      ),
      Expanded(
        flex: 3,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 1, top: 2, bottom: 2),
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration:
                     const BoxDecoration(color: Color.fromARGB(255, 181, 223, 202)),
                  child:const Center(
                    child: Text(
                      'E mail',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: TextButton(
                  onLongPress: () {
                    Clipboard.setData(
                      ClipboardData(text: collegestaff['email']),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: Color.fromARGB(255, 114, 114, 114),
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.all(10),
                      content: Text(
                        'email copied to clipboard',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                    ));
                  },
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(1),
                    backgroundColor: MaterialStateProperty.all(const
                      Color.fromARGB(255, 219, 218, 234),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    collegestaff['email'],
                    style:const TextStyle(
                        color: Color.fromARGB(255, 24, 35, 54), fontSize: 13),
                  )),
            ),
          ],
        ),
      ),
     const Expanded(
        flex: 1,
        child: SizedBox(),
      ),
      Expanded(
        flex: 3,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 1, top: 2, bottom: 2),
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration:
                     const BoxDecoration(color: Color.fromARGB(255, 181, 223, 202)),
                  child:const Center(
                    child: Text(
                      'Room No',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(left: 1, top: 2, bottom: 2),
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration:const BoxDecoration(
                    color: Color.fromARGB(255, 219, 218, 234),
                  ),
                  child: Center(
                    child: Text(
                      collegestaff['room'],
                      textAlign: TextAlign.center,
                      style:const TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
     const Expanded(
        flex: 2,
        child: SizedBox(),
      ),
    ],
  );
}
