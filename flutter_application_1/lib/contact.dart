import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/details.dart';
import 'package:flutter_application_1/functions/FirebaseHelper.dart';
import 'package:flutter_application_1/functions/string_extension.dart';
import 'package:flutter_application_1/model/contact_user.dart';

import 'addContactUserPage.dart';
import 'globalVarialble.dart';
import 'messagePage.dart';

class contact extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _contact();
  }
}

class _contact extends State<contact> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: bodyPage(),
    );
  }

  Widget bodyPage(){
    return SingleChildScrollView(
        child: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseHelper().fire_userContact.where("IDCONTACTUSER", isEqualTo: userConnect.id).snapshots(),
                  builder: (context, snapshot){
                    if(!snapshot.hasData){
                      return CircularProgressIndicator();
                    }
                    else
                    {
                      List documents = snapshot.data!.docs;
                      return ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: documents.length,
                          itemBuilder: (context,index){
                            Contact userContact = Contact(documents[index]);
                            return ListTile(
                              /*onTap: (){
                                print(userConnect);
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context){
                                      return detailsUser(userContact: userContact,);
                                    }
                                ));
                              },

                               */
                              title:Text("${(userContact.prenom).capitalize()}"),
                              trailing: IconButton(onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                return messagePage(userContact: userContact,);
                              }));
                              },
                                  icon: Icon(Icons.mode_comment_outlined)),
                            );
                          }
                      );
                    }
                  }
              ),
              ElevatedButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return addContactUserPage();
                  }
                ));
              }, child: Icon(Icons.add)),
            ]
        )
    );
  }

}