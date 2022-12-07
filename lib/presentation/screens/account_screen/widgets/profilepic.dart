import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:v_cec_firebse1/domain/firebase_functions/fn_profilepic/fn_profilepic.dart';
import 'package:v_cec_firebse1/domain/uploadUserImage.dart';
import 'package:v_cec_firebse1/presentation/login/Login_Page/Login_Functions.dart';
import 'package:v_cec_firebse1/presentation/home/home.dart';

class ProfilePic extends StatefulWidget {
  const ProfilePic({super.key});

  @override
  State<ProfilePic> createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  String imageUrl = '';
  File? image;

  void validateAndUpload(BuildContext context) {
    if (image != null) {
      final storage = FirebaseStorage.instance.ref();
      final String picture =
          "${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
      UploadTask task =
          storage.child('V-CEC_2.0.0/Profile_Pic/$picture').putFile(image!);
      task.then((snapshot) async {
        imageUrl = await snapshot.ref.getDownloadURL();
        String imageL = imageUrl;
        eventService.uploadDetails(
          image: imageL,
        );
        getUserPhoto();
      });
    }
  }

  Future getImage(BuildContext context) async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      image = File(pickedImage.path);

      profilepiclink.value = 'loading';
      profilepiclink.notifyListeners();
      validateAndUpload(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Profile Picture'),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              onPressed: () {
                getImage(context);
              },
              icon: const Icon(Icons.edit))
        ],
      ),
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              child: ValueListenableBuilder(
                valueListenable: profilepiclink,
                builder: (context, String value, child) {
                  if (value == '') {
                    return const SizedBox();
                  } else if (value == 'loading') {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Image(
                      image: NetworkImage(value),
                      fit: BoxFit.fitWidth,
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
