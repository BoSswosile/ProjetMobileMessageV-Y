import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String? id;
  String message = "";
  String uidFrom = "";
  String uidTo = "";
  Timestamp? date;

  Message.vide();

  Message(DocumentSnapshot snapshot) {
    id = snapshot.id;
    Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;
    message = map["MESSAGE"];
    uidFrom = map["UIDFROME"];
    uidTo = map["UIDTO"];
    date = map["DATE"];
  }
}