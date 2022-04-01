import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/functions/FirebaseHelper.dart';
import 'package:flutter_application_1/globalVarialble.dart';

import 'model/message.dart';
import 'model/users.dart';

class messagePage extends StatefulWidget {
  late Users user;
  messagePage({required Users this.user});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _messagePage();
  }

}

class _messagePage extends State<messagePage> {
  String message = "";
  DateTime timestamp = DateTime.now();
  @override
  Widget build(BuildContext context) {
    print(uidUser);
    // TODO: implement build
    return Scaffold(
        body: Container(
          padding: EdgeInsets.all(20),
          child: bodyPage(),
        )
    );
  }

  Widget bodyPage() {
    return SingleChildScrollView(
        child: Column(
          children: <Widget> [
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseHelper().fire_message.snapshots(),
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
                          if(message.uidFrom == userConnect.id) {
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
                                    child: Text(message.message)
                                ));
                          }
                        });
                  }
                }),
            Text("${userConnect.email}"),
            TextField(
              onChanged: (value) {
                setState(() {
                  message = value;
                });
              },
            ),
            ElevatedButton(onPressed: () {
              FirebaseHelper().creationMessage(timestamp: timestamp, message: message, uidFrom: userConnect.id, uidTo: widget.user.id);
            }, child: Text("Envoyé")),
          ],
        )
    );
  }
}