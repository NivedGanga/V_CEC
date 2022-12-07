import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:v_cec_firebse1/presentation/login/Login_Page/loginscreen.dart';
class EventService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String ref = 'UserData';

  void uploadDetails({
    required String image,
  }) {
    _firestore.collection(ref).doc(getUid()).update({
      'Profile_Image': image,
    });
  }
}
