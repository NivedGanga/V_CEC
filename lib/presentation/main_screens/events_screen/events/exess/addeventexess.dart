import 'dart:io';

import 'package:v_cec_firebse1/presentation/main_screens/events_screen/events/exess/Event_Service_exess.dart';
import 'package:v_cec_firebse1/presentation/main_screens/events_screen/events/exess/exess.dart';
import 'package:v_cec_firebse1/presentation/main_screens/events_screen/events/proddec/proddec.dart';
import 'package:v_cec_firebse1/presentation/home/home.dart';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class addeventexess extends StatefulWidget {
  const addeventexess({super.key});

  @override
  State<addeventexess> createState() => _addeventexessState();
}

// Future<void> Size() async {
//   size = await FirebaseFirestore.instance
//       .collection('eproddec')
//       .snapshots()
//       .length;
// }

//GlobalKey<FormState> _formkey = GlobalKey<FormState>();
//bool isLoading = false;
EventServiceexess eventService = EventServiceexess();
//var pickedImage = ImagePicker().pickImage(source: ImageSource.gallery);

TextEditingController eventNameController = TextEditingController();
TextEditingController eventDetailsController = TextEditingController();
TextEditingController eventQuoteController = TextEditingController();
TextEditingController eventDateController = TextEditingController();
TextEditingController eventLink1Controller = TextEditingController();
TextEditingController eventTimeController = TextEditingController();

class _addeventexessState extends State<addeventexess> {
  File? _image;
  var size;
  void countDocuments() async {
    QuerySnapshot doc =
        await FirebaseFirestore.instance.collection('eExess').get();

    List<DocumentSnapshot> docCount = doc.docs;

    size = docCount.length;
    //size++;
  }

  validateAndUpload() {
    // if (_formkey.currentState!.validate()) {
    //   setState(() {
    //     isLoading = true;
    //   });
    countDocuments();
    if (_image != null) {
      String imageUrl;
      final storage = FirebaseStorage.instance.ref();
      final String picture =
          "${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
      UploadTask task =
          storage.child('V-CEC_2.0.0/EXESS/$picture').putFile(_image!);
      task.then((snapshot) async {
        imageUrl = await snapshot.ref.getDownloadURL();

        String imageL = imageUrl;
        //countDocuments();
        await eventService.uploadDetails(
            eventName: eventNameController.text,
            details: eventDetailsController.text,
            quote: eventQuoteController.text,
            date: eventDateController.text,
            time: eventTimeController.text,
            image: imageL,
            link1: eventLink1Controller.text,
            length: size++);

        eventNameController.clear();
        eventQuoteController.clear();
        eventDetailsController.clear();
        eventDateController.clear();
        eventTimeController.clear();
        eventLink1Controller.clear();
        //       _formkey.currentState!.reset();
        //       setState(() => isLoading = false);
        //       Fluttertoast.showToast(msg: 'Event added');
        //       //Navigator.of(context).pop();
        //     });
        //   }
        // } else {
        //   setState(() => isLoading = false);
        //   Fluttertoast.showToast(msg: 'Image must be provided');
      });
    }
  }

  Future getImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    //File result =
    //await FlutterNativeImage.compressImage(pickedImage.path, quality: 10);
    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 3, 141, 162),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * .9,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.width * .02,
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.width * .8,
                    width: MediaQuery.of(context).size.width * .8,
                    child: OutlinedButton(
                        onPressed: () {
                          getImage();
                        },
                        child: (_image != null)
                            ? Image.file(
                                _image!,
                                fit: BoxFit.cover,
                              )
                            : Center(child: Icon(Icons.add)))),
                SizedBox(
                  height: MediaQuery.of(context).size.width * .03,
                ),
                TextFormField(
                  minLines: 1,
                  maxLines: 100,
                  controller: eventNameController,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    //    hintText: '"xxxxxxx"  -xx',
                    labelText: 'Title*',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'You must enter some words';
                    }
                    if (value.length > 40) {
                      return 'Should be less than 40 characters';
                    }
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * .02,
                ),
                TextFormField(
                  minLines: 1,
                  maxLines: 100,
                  controller: eventQuoteController,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      //    hintText: '"xxxxxxx"  -xx',
                      labelText: 'Quote',
                      hintText: "(Optional)"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'You must enter some words';
                    }
                    if (value.length > 40) {
                      return 'Should be less than 40 characters';
                    }
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * .02,
                ),
                TextFormField(
                  minLines: 1,
                  maxLines: 100,
                  controller: eventDetailsController,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    //    hintText: '"xxxxxxx"  -xx',
                    labelText: 'Details*',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'You must enter some words';
                    }
                    if (value.length > 40) {
                      return 'Should be less than 40 characters';
                    }
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * .02,
                ),
                TextFormField(
                  controller: eventDateController,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      //    hintText: '"xxxxxxx"  -xx',
                      labelText: 'Date',
                      hintText: "DD/MM/YYYY"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'You must enter some words';
                    }
                    if (value.length > 40) {
                      return 'Should be less than 40 characters';
                    }
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * .02,
                ),
                TextFormField(
                  controller: eventTimeController,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      //    hintText: '"xxxxxxx"  -xx',
                      labelText: 'Time',
                      hintText: "(Optional)"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'You must enter some words';
                    }
                    if (value.length > 40) {
                      return 'Should be less than 40 characters';
                    }
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * .02,
                ),
                TextFormField(
                  minLines: 1,
                  maxLines: 10,
                  controller: eventLink1Controller,
                  decoration: InputDecoration(
                      focusedBorder:const OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      //    hintText: '"xxxxxxx"  -xx',
                      labelText: 'Link',
                      hintText: "(Optional) In https or http format"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'You must enter some words';
                    }
                    if (value.length > 40) {
                      return 'Should be less than 40 characters';
                    }
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * .02,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (
                          eventNameController.text.trim() == '' ||
                          eventDetailsController.text.trim() == '' ||
                          _image == null ||
                          _image == '') {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          backgroundColor: Colors.red,
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.all(10),
                          content: Text(
                              'Image,Title & Details are mandatory fields'),
                        ));
                      } else {
                        showDialog(
                            context: context,
                            builder: ((context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)),
                                title:const Text(
                                  'Are you sure to submit?',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0)),
                                ),
                                content: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'Cancel'),
                                        child:const Text(
                                          'Cancel',
                                          style: TextStyle(color: Colors.red),
                                        )),
                                    ElevatedButton(
                                        onPressed: () async {
                                          validateAndUpload();
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                        child:const Text('Confirm')),
                                  ],
                                ),
                              );
                            }));
                      }
                      ;
                    },
                    child:const Text("Submit"))
              ],
            ),
          ),
        ),
      )),
    );
  }
}
