import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/dashboard.dart';
import 'package:flutter_application_1/functions/FirebaseHelper.dart';
import 'package:flutter_application_1/globalVarialble.dart';
import 'package:random_string/random_string.dart';
import 'model/users.dart';

class addContactUserPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _addContactUserPage();
  }
}

class _addContactUserPage extends State<addContactUserPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
      body: bodyPage(),
    );
  }

  Widget bodyPage() {
    return SingleChildScrollView(
        child: Column(
            children: <Widget> [
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseHelper().fire_user.where('NOM', isNotEqualTo: userConnect.nom).snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    }
                    else {
                      List documents = snapshot.data!.docs;
                      return ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: documents.length,
                          itemBuilder: (context, index) {
                            Users user = Users(documents[index]);
                            return ListTile(
                              title: Text("${user.prenom} ${user.nom}"),
                              trailing: IconButton(onPressed: (){
                                FirebaseHelper().addContactToUser(prenom: user.prenom, nom: user.nom!, idContact: user.id, email: user.email, idContactUser: userConnect.id);
                                Navigator.push(context, MaterialPageRoute(builder: (context) {
                                  return dashBoard();
                                }));
                                setState(() {
                                  randomIdContact = randomString(20);
                                });
                              },
                                icon: Icon(Icons.add),
                              ),
                            );
                          }
                      );
                    }
                  }
              )
            ]
        )
    );
  }
}