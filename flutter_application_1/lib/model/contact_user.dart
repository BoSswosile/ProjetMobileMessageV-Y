import 'package:cloud_firestore/cloud_firestore.dart';

class Contact {

  String idContact = "";
  String prenom = "";
  String? nom;
  String email = "";
  String idContactUser = "";
  String? avatar = "";


  Contact.vide();

  Contact(DocumentSnapshot snapshot) {
    Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;
    idContact = map["IDCONTACT"];
    idContactUser = map["IDCONTACTUSER"];
    prenom = map["PRENOM"];
    nom = map["NOM"];
    email = map["EMAIL"];
    avatar = map["AVATAR"];
  }
}