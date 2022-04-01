
import 'package:cloud_firestore/cloud_firestore.dart';

class Users{
  //Attributs
  String id = "";
  String prenom = "";
  String? nom;
  String email = "";
  DateTime? birthday;
  String? avatar;

  //Constructeur
  Users.vide();

  Users(DocumentSnapshot snapshot){
    id = snapshot.id;
    Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;
    prenom = map["PRENOM"];
    nom = map["NOM"];
    email = map["MAIL"];
    birthday = map["BIRTHDAY"];
    avatar = map["AVATAR"];
  }

  //Methodes

}