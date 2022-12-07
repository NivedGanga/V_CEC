import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v_cec_firebse1/domain/uploadUserImage.dart';
import 'package:v_cec_firebse1/presentation/home/home.dart';
import 'package:v_cec_firebse1/presentation/login/Login_Page/Login_Functions.dart';
import 'package:v_cec_firebse1/presentation/login/Login_Page/loginscreen.dart';
import 'package:v_cec_firebse1/presentation/screens/account_screen/widgets/profilepic.dart';

String photoURL = '';

Future getUserPhoto() async {
  DocumentSnapshot doc = await FirebaseFirestore.instance
      .collection("UserData")
      .doc(getUid())
      .get();
  if (doc["Profile_Image"] != null || doc["Profile_Image"] != '') {
    var data = doc;
    photoURL = await data["Profile_Image"];
    SharedPreferences sharedprefs = await SharedPreferences.getInstance();
    sharedprefs.setString('profilepic', photoURL);
    profilepiclink.value = photoURL;
    profilepiclink.notifyListeners();
  } else {
    dp = ProfilePicture(
        name: username.substring(0, 3), radius: 30, fontsize: 21);
  }
}
