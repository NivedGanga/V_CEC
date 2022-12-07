import 'dart:io';
import 'Event_Service_proddec.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class addeventprod extends StatefulWidget {
  const addeventprod({super.key});

  @override
  State<addeventprod> createState() => _addeventprodState();
}

// Future<void> Size() async {
//   size = await FirebaseFirestore.instance
//       .collection('eproddec')
//       .snapshots()
//       .length;
// }

//GlobalKey<FormState> _formkey = GlobalKey<FormState>();
//bool isLoading = false;
EventService eventService = EventService();
//var pickedImage = ImagePicker().pickImage(source: ImageSource.gallery);

TextEditingController eventNameController = TextEditingController();
TextEditingController eventDetailsController = TextEditingController();
TextEditingController eventQuoteController = TextEditingController();
TextEditingController eventDateController = TextEditingController();
TextEditingController eventLink1Controller = TextEditingController();
TextEditingController eventTimeController = TextEditingController();

class _addeventprodState extends State<addeventprod> {
  File? _image;
  var size;
  void countDocuments() async {
    QuerySnapshot doc =
        await FirebaseFirestore.instance.collection('eproddec').get();

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
          storage.child('V-CEC_2.0.0/PRODDEC/$picture').putFile(_image!);
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
        backgroundColor:const Color.fromARGB(255, 3, 141, 162),
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
                            :const Center(child: Icon(Icons.add)))),
                SizedBox(
                  height: MediaQuery.of(context).size.width * .03,
                ),
                TextFormField(
                  minLines: 1,
                  maxLines: 100,
                  controller: eventNameController,
                  decoration: InputDecoration(
                    focusedBorder:const OutlineInputBorder(),
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
                      focusedBorder:const OutlineInputBorder(),
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
                    focusedBorder:const OutlineInputBorder(),
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
                      focusedBorder:const OutlineInputBorder(),
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
                      focusedBorder:const OutlineInputBorder(),
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
                                          await validateAndUpload();
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








































































// import 'dart:io';
// import 'dart:ui';
// import 'Event_Service.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter_native_image/flutter_native_image.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// class addeventprod extends StatefulWidget {
//   const addeventprod({super.key});

//   @override
//   State<addeventprod> createState() => _addeventprodState();
// }

// EventService eventService = EventService();
// //var pickedImage = ImagePicker().pickImage(source: ImageSource.gallery);

// TextEditingController eventNameController = TextEditingController();
// TextEditingController eventDetailsController = TextEditingController();
// TextEditingController eventQuoteController = TextEditingController();
// TextEditingController eventDateController = TextEditingController();
// TextEditingController eventLink1Controller = TextEditingController();
// TextEditingController eventTimeController = TextEditingController();

// class _addeventprodState extends State<addeventprod> {
  
// File? _image;

//   void validateAndUpload() {
//     // if (_formkey.currentState!.validate()) {
//     //   setState(() {
//     //     isLoading = true;
//     //   });
//     if (_image != null) {
//       String imageUrl;
//       final storage = FirebaseStorage.instance.ref();
//       final String picture =
//           "${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
//       UploadTask task =
//           storage.child('V-CEC_2.0.0/PRODDEC/$picture').putFile(_image!);
//       task.then((snapshot) async {
//         imageUrl = await snapshot.ref.getDownloadURL();
//         String imageL = imageUrl;
//         eventService.uploadDetails(
//             eventName: eventNameController.text,
//             details: eventDetailsController.text,
//             quote: eventQuoteController.text,
//             date: eventDateController.text,
//             time: eventTimeController.text,
//             link1: eventLink1Controller.text,
//             image: imageL);
//         //       _formkey.currentState!.reset();
//         //       setState(() => isLoading = false);
//         //       Fluttertoast.showToast(msg: 'Event added');
//         //       //Navigator.of(context).pop();
//         //     });
//         //   }
//         // } else {
//         //   setState(() => isLoading = false);
//         //   Fluttertoast.showToast(msg: 'Image must be provided');
//       });
//     }
//   }

//   Future getImage() async {
//     final pickedImage =
//         await ImagePicker().pickImage(source: ImageSource.gallery);
//     //File result =
//     //await FlutterNativeImage.compressImage(pickedImage.path, quality: 10);
//     setState(() {
//       if (pickedImage != null) {
//         _image = File(pickedImage.path);
//       } else {
//         print('No image selected.');
//       }
//     });
//   }



//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: SafeArea(
//           child: SingleChildScrollView(
//         child: Center(
//           child: SizedBox(
//             width: MediaQuery.of(context).size.width * .9,
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: MediaQuery.of(context).size.width * .02,
//                 ),
//                 SizedBox(
//                     height: MediaQuery.of(context).size.width * .8,
//                     width: MediaQuery.of(context).size.width * .8,
//                     child: OutlinedButton(
//                         onPressed: () {
//                           getImage();
//                         },
//                         child: (_image != null)
//                             ? Image.file(
//                                 _image!,
//                                 fit: BoxFit.cover,
//                               )
//                             : Center(child: Icon(Icons.add)))),
//                 SizedBox(
//                   height: MediaQuery.of(context).size.width * .03,
//                 ),
//                 TextFormField(
//                   //    controller: eventDetailsController,
//                   decoration: InputDecoration(
//                     focusedBorder: OutlineInputBorder(),
//                     enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15)),
//                     //    hintText: '"xxxxxxx"  -xx',
//                     labelText: 'Title*',
//                   ),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'You must enter some words';
//                     }
//                     if (value.length > 40) {
//                       return 'Should be less than 40 characters';
//                     }
//                   },
//                 ),
//                 SizedBox(
//                   height: MediaQuery.of(context).size.width * .02,
//                 ),
//                 TextFormField(
//                   minLines: 1,
//                   maxLines: 100,
//                                 controller: eventQuoteController,
//                   decoration: InputDecoration(
//                     focusedBorder: OutlineInputBorder(),
//                     enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20)),
//                     //    hintText: '"xxxxxxx"  -xx',
//                     labelText: 'Quote',
//                      hintText: "(Optional)"),
//                   ),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'You must enter some words';
//                     }
//                     if (value.length > 40) {
//                       return 'Should be less than 40 characters';
//                     }
//                   },
//                 ),
//                 SizedBox(
//                   height: MediaQuery.of(context).size.width * .02,
//                 ),
//                 SizedBox(
//                   child: TextFormField(
//                     minLines: 1,
//                     maxLines: 100,
//                     controller: eventDetailsController,
//                     decoration: InputDecoration(
//                       focusedBorder: OutlineInputBorder(),
//                       enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(20)),
//                       //    hintText: '"xxxxxxx"  -xx',
//                       labelText: 'Details*',
//                     ),
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return 'You must enter some words';
//                       }
//                       if (value.length > 40) {
//                         return 'Should be less than 40 characters';
//                       }
//                     },
//                   ),
//                 ),
//                 SizedBox(
//                   height: MediaQuery.of(context).size.width * .02,
//                 ),
//                 TextFormField(
//                 controller: eventDateController,
//                   decoration: InputDecoration(
//                     focusedBorder: OutlineInputBorder(),
//                     enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20)),
//                     //    hintText: '"xxxxxxx"  -xx',
//                     labelText: 'Date',
//                      hintText: "(Optional)"),
//                   ),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'You must enter some words';
//                     }
//                     if (value.length > 40) {
//                       return 'Should be less than 40 characters';
//                     }
//                   },
//                 ),
//                 SizedBox(
//                   height: MediaQuery.of(context).size.width * .02,
//                 ),
//                 TextFormField(
//                   controller: eventTimeController,
//                   decoration: InputDecoration(
//                     focusedBorder: OutlineInputBorder(),
//                     enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20)),
//                     //    hintText: '"xxxxxxx"  -xx',
//                     labelText: 'Time',
//                         hintText: "(Optional)"),
//                   ),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'You must enter some words';
//                     }
//                     if (value.length > 40) {
//                       return 'Should be less than 40 characters';
//                     }
//                   },
//                 ),
//                 SizedBox(
//                   height: MediaQuery.of(context).size.width * .02,
//                 ),
//                 TextFormField(
// minLines: 1,
//                   maxLines: 10,
//                   controller: eventLink1Controller,                  decoration: InputDecoration(
//                     focusedBorder: OutlineInputBorder(),
//                     enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20)),
//                     //    hintText: '"xxxxxxx"  -xx',
//                     labelText: 'Link',
//                            hintText: "(Optional)"),
//                   ),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'You must enter some words';
//                     }
//                     if (value.length > 40) {
//                       return 'Should be less than 40 characters';
//                     }
//                   },
//                 ),
//                 SizedBox(
//                   height: MediaQuery.of(context).size.width * .02,
//                 ),
//                 ElevatedButton(
//                     onPressed: () {
//                       validateAndUpload();
//                       Navigator.of(context).pop();
//                     },
//                     child: Text("Submit"))
//               ],
//             ),
//           ),
//         ),
//       )),
//     );
//   }
// }



























































// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter_native_image/flutter_native_image.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'dart:io';

// import 'package:v_cec_firebse1/events/proddec/Event_Service.dart';

// bool isLoading = false;
// TextEditingController eventNameController = TextEditingController();
// TextEditingController eventDetailsController = TextEditingController();
// TextEditingController eventDateController = TextEditingController();

// TextEditingController eventLink1Controller = TextEditingController();

// late File _image;
// GlobalKey<FormState> _formKey = GlobalKey<FormState>();

// class addeventprod extends StatefulWidget {
//   @override
//   State<addeventprod> createState() => _addeventprodState();

//   EventService eventService = EventService();

//   void build(BuildContext context) {
//     if (_formKey.currentState!.validate()) {
//       setState() => isLoading = true;
//       if (_image != null) {
//         String imageUrl;
//         final storage = FirebaseStorage.instance
//             .ref('gs://proddec-cec.appspot.com/V-CEC_2.0.0/PRODDEC');
//         final String picture =
//             "${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
//         UploadTask task = storage.child(picture).putFile(_image);
//         task.then((snapshot) async {
//           imageUrl = await snapshot.ref.getDownloadURL();
//           String imageL = imageUrl;
//           eventService.uploadDetails(
//               eventName: eventNameController.text,
//               details: eventDetailsController.text,
//               date: eventDateController.text,
//               link1: eventLink1Controller.text,
//               image: imageL);
//           _formKey.currentState!.reset();
//           setState() => isLoading = false;
//           Fluttertoast.showToast(
//               msg: 'Event added',
//               toastLength: Toast.LENGTH_LONG,
//               gravity: ToastGravity.CENTER,
//               backgroundColor: Colors.blue[300],
//               textColor: Colors.white,
//               fontSize: 16.0);
//           Navigator.of(context).pop();
//           // Navigator.pop(context);
//         });
//       } else {
//         setState() => isLoading = false;
//         Fluttertoast.showToast(msg: 'image must be provided');
//       }
//     }
//   }
// }

// class _addeventprodState extends State<addeventprod> {
//   Future getImage() async {
//     var image =
//         await ImagePicker.platform.pickImage(source: ImageSource.gallery);

//     File result =
//         await FlutterNativeImage.compressImage(image!.path, quality: 10);
//     // print(image.lengthSync());
//     print(result.lengthSync());

//     setState(() {
//       _image = result;
//       print('Image Path $_image');
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Event Upload'),
//       ),
//       body: Form(
//         key: _formKey,
//         child: Container(
//           child: isLoading
//               ? Center(child: CircularProgressIndicator())
//               : ListView(
//                   children: <Widget>[
//                     Padding(
//                       padding: EdgeInsets.only(
//                           top: MediaQuery.of(context).size.height * .02),
//                       child: Align(
//                         alignment: Alignment.center,
//                         child: TextButton(
//                           child: Container(
//                             width: MediaQuery.of(context).size.width * .5,
//                             height: MediaQuery.of(context).size.width * .6,
//                             child: (_image != null)
//                                 ? Image.file(
//                                     _image,
//                                     fit: BoxFit.fill,
//                                   )
//                                 : Icon(
//                                     Icons.add,
//                                     color: Colors.grey,
//                                   ),
//                           ),
//                           onPressed: () {
//                             getImage();
//                           },
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(
//                           top: MediaQuery.of(context).size.width * .1),
//                       child: TextFormField(
//                         controller: eventNameController,
//                         decoration: InputDecoration(
//                           icon: Icon(Icons.person),
//                           hintText: 'Event name',
//                           labelText: 'Event name',
//                         ),
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return 'You must enter the Event name';
//                           }
//                           if (value.length > 24) {
//                             return 'Should be less than 24 characters';
//                           }
//                         },
//                       ),
//                     ),
//                     TextFormField(
//                       controller: eventDetailsController,
//                       decoration: InputDecoration(
//                         icon: Icon(Icons.person),
//                         hintText: 'Short words',
//                         labelText: 'Short Words',
//                       ),
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'You must enter some words';
//                         }
//                         if (value.length > 40) {
//                           return 'Should be less than 40 characters';
//                         }
//                       },
//                     ),
//                     TextFormField(
//                       controller: eventDateController,
//                       decoration: InputDecoration(
//                         icon: Icon(Icons.person),
//                         hintText: 'Date (DD/MM/YYYY)',
//                         labelText: 'Date (DD/MM/YYYY)',
//                       ),
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'You must enter the date';
//                         }
//                       },
//                     ),
//                     TextFormField(
//                       controller: eventLink1Controller,
//                       decoration: InputDecoration(
//                         icon: Icon(Icons.person),
//                         labelText: 'Link',
//                         hintText: 'eg: https://www.google.com',
//                       ),
//                     ),
//                     SizedBox(
//                       height: MediaQuery.of(context).size.width * .1,
//                     ),
//                     ElevatedButton(
//                       onPressed: () {},
//                       child: Text(
//                         'Submit',
//                         style: TextStyle(color: Colors.white, fontSize: 16.0),
//                       ),
//                     ),
//                   ],
//                 ),
//         ),
//       ),
//     );
//   }
// }
