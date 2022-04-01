import 'package:flutter/material.dart';

import 'model/users.dart';

class detailsUser extends StatefulWidget {
  Users user;
  detailsUser({required Users this.user});
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
        title: Text("${widget.user.prenom} ${widget.user.nom!}"),
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
                  image: (widget.user.avatar == null)
                      ? NetworkImage("https://mir-s3-cdn-cf.behance.net/project_modules/disp/0f682438923545.5606a0a9ba488.jpg")
                      : NetworkImage(widget.user.avatar!)
              )
          ),
        ),
        Text("${widget.user.prenom} ${widget.user.nom}", style: TextStyle(fontSize: 20),),
        SizedBox(height: 20,),
        Text(widget.user.email, style: TextStyle(),),
        (widget.user.birthday==null)?Container():Text(widget.user.birthday.toString())
      ],
    );
  }
}