import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_application_1/globalVarialble.dart';
import 'package:flutter_application_1/model/users.dart';


class FirebaseHelper {
  //Attributs
  final auth = FirebaseAuth.instance;
  final fire_user = FirebaseFirestore.instance.collection("utilisateur");
  final fire_message = FirebaseFirestore.instance.collection("message");
  final fire_conversation = FirebaseFirestore.instance.collection("conversation");
  final fire_userContact = FirebaseFirestore.instance.collection("contactUser");
  final fireStorage = FirebaseStorage.instance;



  //Methode
  Future Signup({required String email, required String password, required String prenom, required String nom}) async {
    UserCredential result = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    User? user = result.user;
    String uid = user!.uid;
    Map<String, dynamic> map = {
      "NOM": nom,
      "PRENOM": prenom,
      "MAIL": email,
    };
    addUser(uid, map);
  }

  Future creationMessage(
      {required DateTime timestamp, required String message, required String uidFrom, required String uidTo, required String conversation}) async {
    Map<String, dynamic> map = {
      "DATE": timestamp,
      "MESSAGE": message,
      "UIDFROM": uidFrom,
      "UIDTO": uidTo,
    };
    addConversationUser(uidFrom + uidTo, map);
  }

  Future addConversationMessage(
      {required DateTime timestamp, required String message, required String uidFrom, required String uidTo, required String conversation}) async {
    Map<String, dynamic> map = {
      "DATE": timestamp,
      "MESSAGE": message,
      "UIDFROM": uidFrom,
      "UIDTO": uidTo,
      "CONVERSATIONID": conversation,
    };
    addMessage(randomId, map);
  }

  Future addContactToUser(
      {required String prenom, required String nom, required String idContact, required String idContactUser, required String email}
      ) async {
    Map<String, dynamic> map = {
      "IDCONTACTUSER": idContactUser,
      "PRENOM": prenom,
      "NOM": nom,
      "IDCONTACT": idContact,
      "EMAIL": email,
    };
    addContact(randomIdContact, map);
  }

  addContact(String uidContact, Map<String, dynamic> map) {
    fire_userContact.doc(uidContact).set(map);
  }

  addMessage(String uid, Map<String, dynamic> map) {
    fire_message.doc(uid).set(map);
  }

  addConversationUser(String uid, Map<String, dynamic> map) {
    fire_conversation.doc(uid).set(map);
  }

  Future connect({required String email, required String password}) async {
    UserCredential result = await auth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  addUser(String uid, Map<String, dynamic> map) {
    fire_user.doc(uid).set(map);
  }

  updateUser(String uid, Map<String, dynamic> map) {
    fire_user.doc(uid).update(map);
  }

  /*
  deleteUser(String uid, Map<String, dynamic> map) {
    fire_user.doc(uid).delete(map);
  }
   */
  //recup??rer l'uid de la partie authentification
  Future <String> getUid() async{
    String id = auth.currentUser!.uid;
    return id;
  }

  //recup??rer l'uid de la partie authentification
  Future <Users> getUser(String uid) async {
    DocumentSnapshot snapshot = await fire_user.doc(uid).get();

    return Users(snapshot);
  }


  //stockage d'une image
  Future <String> saveImage(String name, Uint8List data) async {
    //Stocke l'image dans la base de donn??e
    TaskSnapshot download = await fireStorage.ref("image/$name").putData(data);
    //recup??re le lien de l'image stock??e
    String urlImage = await download.ref.getDownloadURL();
    return urlImage;
  }

}