import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String? id;
  String message = "";
  String uidFrom = "";
  String uidTo = "";
  String conversationID = "";
  Timestamp? date;

  Message.vide();

  Message(DocumentSnapshot snapshot) {
    id = snapshot.id;
    Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;
    message = map["MESSAGE"];
    uidFrom = map["UIDFROM"];
    uidTo = map["UIDTO"];
    conversationID = map["CONVERSATIONID"];
    date = map["DATE"];

  }
}