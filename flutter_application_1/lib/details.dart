import 'package:flutter/material.dart';

import 'model/contact_user.dart';
import 'model/users.dart';

class detailsUser extends StatefulWidget {
  late Contact userContact;
  detailsUser({required Contact this.userContact});
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
      appBar: AppBar(
        title: Text("${widget.userContact.prenom} ${widget.userContact.nom!}"),
        centerTitle: true,
      ),
      body: bodyPage(),
    );
  }


  Widget bodyPage() {
    return Column(
      children: [
        Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: (widget.userContact.avatar == null)
                      ? NetworkImage("https://mir-s3-cdn-cf.behance.net/project_modules/disp/0f682438923545.5606a0a9ba488.jpg")
                      : NetworkImage(widget.userContact.avatar!)
              )
          ),
        ),
        Text("${widget.userContact.prenom} ${widget.userContact.nom}", style: TextStyle(fontSize: 20),),
        SizedBox(height: 20,),
        Text(widget.userContact.email, style: TextStyle(),),
      ],
    );
  }
}