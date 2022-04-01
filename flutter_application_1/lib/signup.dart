import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_application_1/functions/FirebaseHelper.dart';
import 'package:flutter_application_1/globalVarialble.dart';


class register extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: impletment createState
    return registerState();
  }
}

class registerState extends State<register> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Center(
        child: bodyPage(),
        )
      )
    );
  }

  String email = "";
  String password = "";
  String firstname = "";
  String lastname = "";



  Widget bodyPage(){
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                    "https://mir-s3-cdn-cf.behance.net/project_modules/disp/0f682438923545.5606a0a9ba488.jpg")
              )
              )
            ),
          SizedBox(height: 20,),
          TextField(
            onChanged: (value){
              setState(() {
                email = value;
                uidUser = value;
              });
            },
            decoration: InputDecoration(
              hintText: "Entrer une adresse mail",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              )
            ),
          ),
          SizedBox(height: 20,),
          TextField(
            obscureText: true,
            onChanged: (value){
              setState(() {
                password = value;
              });
            },
            decoration: InputDecoration(
                hintText: "Entrer un password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                )
            ),
          ),
          SizedBox(height: 20,),
          TextField(
            onChanged: (value){
              setState(() {
                firstname = value;
              });
            },
            decoration: InputDecoration(
                hintText: "Entrer un prénom",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                )
            ),
          ),
          SizedBox(height: 20,),
          TextField(
            onChanged: (value){
              setState(() {
                lastname = value;
              });
            },
            decoration: InputDecoration(
                hintText: "Entrer un nom",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                )
            ),
          ),
          SizedBox(height: 20,),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.orange,
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
    )
            ),
              onPressed: (){
            FirebaseHelper().Signup(email: email, password: password, prenom: firstname, nom: lastname);
          }, child: Text("Inscription"))
        ],
      )
    );
  }
}