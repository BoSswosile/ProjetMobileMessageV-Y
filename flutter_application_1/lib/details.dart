import 'package:flutter/material.dart';
import 'package:flutter_application_1/functions/FirebaseHelper.dart';
import 'package:flutter_application_1/globalVarialble.dart';
import 'package:flutter_application_1/signup.dart';

import 'model/contact_user.dart';
import 'model/users.dart';

class detailsUser extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return detailsUserState();
  }
}

class detailsUserState extends State<detailsUser> {
  late String username;
  late String name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodyPage(),
    );
  }
  Widget _buildPopupDialogsurname(BuildContext context) {
    return AlertDialog(
      title: const Text('Voulez vous changer de nom'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            onChanged: (value){
              setState(() {
                username = value;
              });
            },
            decoration: new InputDecoration.collapsed(
                border: OutlineInputBorder(),
                hintText: 'Nom'
            ),
          ),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Map<String, dynamic> map = {
              "NOM": username,
            };
              FirebaseHelper().updateUser(userConnect.id, map);
            Navigator.of(context).pop();
            setState(() {
              userConnect.nom = username;
            });
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Update'),
        ),
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Close'),
        ),
      ],
    );
  }

  Widget _buildPopupDialogname(BuildContext context) {
    return AlertDialog(
      title: const Text('Voulez vous changer de prénom'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            onChanged: (value){
              setState(() {
                name = value;
              });
            },
            decoration: new InputDecoration.collapsed(
                border: OutlineInputBorder(),
                hintText: 'Prénom'
            ),
          ),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Map<String, dynamic> map = {
              "PRENOM": name,
            };
            FirebaseHelper().updateUser(userConnect.id, map);
            Navigator.of(context).pop();
            setState(() {
              userConnect.prenom = name;
            });
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Update'),
        ),
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Close'),
        ),
      ],
    );
  }

  Widget bodyPage() {
    return Center(child: Column(
      children: [
        Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: (userConnect.avatar == null)
                      ? NetworkImage("https://mir-s3-cdn-cf.behance.net/project_modules/disp/0f682438923545.5606a0a9ba488.jpg")
                      : NetworkImage(userConnect.avatar!)
              )
          ),
        ),
        GestureDetector(
          onTap: () {
            showDialog(context: context, builder: (BuildContext context) => _buildPopupDialogname(context),);
          },
        child: Text("${userConnect.prenom}", style: TextStyle(fontSize: 20),),
        ),
        GestureDetector(
          onTap: () {
            showDialog(context: context, builder: (BuildContext context) => _buildPopupDialogsurname(context),);
            },
          child: Text("${userConnect.nom}", style: TextStyle(fontSize: 20),),
        ),
        SizedBox(height: 20,),
        Text(userConnect.email, style: TextStyle(),),
      ],
    )
    );
  }
}