import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/functions/FirebaseHelper.dart';
import 'package:file_picker/file_picker.dart';
import '../model/users.dart';

class myDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _myDrawer();
  }

}

class _myDrawer extends State<myDrawer> {
  late Users myProfil;
  late String uid;
  late Uint8List? byteData;
  late String fileName;
  late String urlImage;

  popImage() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          if(Platform.isIOS) {
            return CupertinoAlertDialog(
              title: Text("Souhaitez vous utiliser cette photo ?"),
              content: Image.memory(byteData!),
              actions: [
                ElevatedButton(
                    onPressed: (){
                      FirebaseHelper().saveImage(fileName, byteData!).then((String lienImage) {
                        setState(() {
                          urlImage = lienImage;
                        });
                      });
                      Map<String, dynamic> map = {
                        "AVATAR": urlImage
                      };
                      FirebaseHelper().updateUser(myProfil.id, map);
                      Navigator.pop(context);
                    },
                    child: Text("Acctepter")),

                ElevatedButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: Text("Annuler")),
              ],
            );
          } else {
            return AlertDialog(
              title: Text("Souhaitez vous utiliser cette photo ?"),
              content: Image.memory(byteData!),
              actions: [
                ElevatedButton(
                    onPressed: (){
                      FirebaseHelper().saveImage(fileName, byteData!).then((String lienImage) {
                        setState(() {
                          urlImage = lienImage;
                        });
                      });
                      Map<String, dynamic> map = {
                        "AVATAR": urlImage,
                      };
                      FirebaseHelper().updateUser(myProfil.id, map);
                      Navigator.pop(context);
                    },
                    child: Text("Acctepter")),

                ElevatedButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: Text("Annuler")),
              ],
            );
          }
        }
    );
  }

  importImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      withData: true,
      type: FileType.image,
    );
    if(result != null){
      setState(() {
        byteData = result.files.first.bytes;
        fileName = result.files.first.name;
      });
      popImage();
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    FirebaseHelper().getUid().then((String identifiant) {
      setState((){
        uid = identifiant;
        FirebaseHelper().getUser(uid).then((Users user) {
          setState((){
            myProfil = user;
          });
        });
      });
    });
    return Container(
      padding: EdgeInsets.all(20),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width/3,
      color: Colors.white,
      child: Center(
        child: Column(
            children: [
              SizedBox(height: 50,),
              InkWell(
                child: Container(
                  height: 180,
                  width: 180,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: (myProfil.avatar==null)?NetworkImage("https://mir-s3-cdn-cf.behance.net/project_modules/disp/0f682438923545.5606a0a9ba488.jpg"): NetworkImage(myProfil.avatar!)
                      )
                  ),
                ),
                onTap: (){
                  importImage();
                },
              ),

              Text("${myProfil.prenom} ${myProfil.nom}"),
              Text("BIRTHDAY"),
              Text("MAIL"),
            ]
        ),
      ),
    );
  }
}