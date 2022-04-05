import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/functions/FirebaseHelper.dart';
import 'package:flutter_application_1/functions/string_extension.dart';
import 'package:flutter_application_1/globalVarialble.dart';
import 'package:random_string/random_string.dart';

import 'globalVarialble.dart';
import 'model/contact_user.dart';
import 'model/message.dart';

class messagePage extends StatefulWidget {
  late Contact userContact;
  messagePage({required Contact this.userContact});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _messagePage();
  }

}

class _messagePage extends State<messagePage> {
  String message = "";
  final fieldtext = TextEditingController();
  @override
  Widget build(BuildContext context) {
    print(uidUser);
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          centerTitle: true,
          title: Text("${(widget.userContact.prenom).capitalize()}"),
        ),
        body: Container(
          alignment: Alignment(0.0, 1.0),
          padding: EdgeInsets.all(20),
          child: bodyPage(),
        )
    );
  }

  //faire fonction pour trier les id dans l'ordre alphabétique
  String trieUid(String uidFrom, String uidTo) {
    List<String> list = [
      uidFrom,
      uidTo
    ];
    list.sort();
    return list.toString();
  }

  void clearText() {
    fieldtext.clear();
  }

  Widget bodyPage() {
    String idConversation = trieUid(userConnect.id, widget.userContact.idContact);
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 90),
          child:
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseHelper().fire_message.where('CONVERSATIONID', isEqualTo: idConversation).orderBy('DATE', descending: false).snapshots(),
              builder: (context, snapshot) {
                if(!snapshot.hasData) {
                  return CircularProgressIndicator();
                } else {
                  List documents = snapshot.data!.docs;
                  return ListView.builder(
                      itemCount: documents.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        Message message = Message(documents[index]);
                        if ( message.uidFrom == userConnect.id ) {
                          return ListTile(
                            title: Container(
                              height: 50,
                              width: 50,
                              child: Material(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(20),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 20.0),
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      message.message,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                      ),),
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return ListTile(
                            title: Container(
                              height: 50,
                              width: 50,
                              child: Material(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(20),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 20.0),
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      message.message,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                      ),),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      });
                }
              }),
        ),
        Positioned(
            left: 0,
            bottom: 0,
            child: Container(
                margin: EdgeInsets.only(bottom: 5),
                width: 350,
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  controller: fieldtext,
                  onChanged: (value) {
                    setState(() {
                      message = value;
                      randomId = randomString(30);
                    });
                  },
                  autocorrect: true,
                  decoration: InputDecoration(
                    hintText: 'Message',
                    suffixIcon: IconButton(onPressed: () {
                      //add conversation
                      FirebaseHelper().creationMessage(timestamp: DateTime.now(), message: message, uidFrom: userConnect.id, uidTo: widget.userContact.idContact, conversation: idConversation);
                      //add messageConversation
                      FirebaseHelper().addConversationMessage(timestamp: DateTime.now(), message: message, uidFrom: userConnect.id, uidTo: widget.userContact.idContact, conversation: idConversation);
                      clearText();
                    },

                        icon: const Icon(Icons.send_rounded)),
                    hintStyle: TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      borderSide: BorderSide(color: Colors.blue, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.blue, width: 2),
                    ),
                  ),
                )

            )
        )
      ],
    );
  }
}