import 'package:flutter/material.dart';
import 'package:flutter_application_1/globalVarialble.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodyPage(),
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
        Text("${userConnect.prenom} ${userConnect.nom}", style: TextStyle(fontSize: 20),),
        SizedBox(height: 20,),
        Text(userConnect.email, style: TextStyle(),),
      ],
    )
    );
  }
}