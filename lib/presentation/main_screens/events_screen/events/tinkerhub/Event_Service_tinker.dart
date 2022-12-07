import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

Future<int> length() {
  return FirebaseFirestore.instance.collection('etinkerhub').snapshots().length;
}

class EventServicetinker {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String ref = 'etinkerhub';

  uploadDetails(
      {required String eventName,
      required String details,
      required String quote,
      required String date,
      required String time,
      required String image,
      required String link1,
      required int length}) {
    var id =const Uuid();
    String pEventId = id.v1();
    _firestore.collection(ref).doc(pEventId).set({
      'name': eventName,
      'id': pEventId,
      'details': details,
      'Quote': quote,
      'date': date,
      'time': time,
      'image': image,
      'link1': link1,
      'no': length,
    });
  }
}
