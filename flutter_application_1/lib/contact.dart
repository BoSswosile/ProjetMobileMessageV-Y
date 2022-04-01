import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/details.dart';
import 'package:flutter_application_1/functions/FirebaseHelper.dart';
import 'package:flutter_application_1/model/users.dart';

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
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseHelper().fire_user.snapshots(),
        builder: (context, snapshot){
          if(!snapshot.hasData){
            return CircularProgressIndicator();
          }
          else
          {
            List documents = snapshot.data!.docs;
            return ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context,index){
                  Users user = Users(documents[index]);
                  return ListTile(
                    onTap: (){
                      print(userConnect);
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context){
                            return detailsUser(user: user);
                          }
                      ));
                    },
                    title:Text("${user.prenom}"),
                    trailing: IconButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context){
                      return messagePage(user: user);
                    }));
                      },
                        icon: Icon(Icons.mode_comment_outlined)),
                  );
                }
            );
          }
        }
    );
  }

}