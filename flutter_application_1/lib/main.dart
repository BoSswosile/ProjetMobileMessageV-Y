import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/dashboard.dart';
import 'package:flutter_application_1/functions/FirebaseHelper.dart';
import 'package:flutter_application_1/globalVarialble.dart';
import 'package:flutter_application_1/signup.dart';

import 'model/users.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Center(
          child: bodyPage(


          )
        )
      ),
    );
  }

  pop() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Erreur !!"),
            actions: [
              Center(
              child: ElevatedButton(onPressed: () {
                Navigator.pop(context);
              },
                  child: Text("OK"))
              )],
          );
        }
    );
  }


  Widget bodyPage() {
    FirebaseHelper().getUid().then((String identifiant) {
      setState(() {
        uidUser = identifiant;
        FirebaseHelper().getUser(uidUser).then((Users user) {
          setState(() {
            userConnect = user;
          });
        });
      });
    });
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                        "https://mir-s3-cdn-cf.behance.net/project_modules/disp/0f682438923545.5606a0a9ba488.jpg")
                ),
              )
          ),
          TextFormField(
            onChanged: (value) {
              setState(() {
                email = value;
              });
            },
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Enter something !';
              } else if (RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(value!)) {
                return null;
              } else {
                return 'Enter validation email !';
              }
            },
            decoration: InputDecoration(
                hintText: "Entrer votre adresse mail",
                //filled: true,
                //fillColor: Colors.black,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                )
            ),
          ),
          SizedBox(height: 20,),
          TextFormField(
            onChanged: (value){
              setState(() {
                password = value;
              });
            },
            obscureText: true,
            decoration: InputDecoration(
                hintText: "Entrer votre password",
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
                    borderRadius: BorderRadius.circular(20))
            ),
            onPressed: () {
              FirebaseHelper().connect(email: email, password: password).then((value) => {
               Navigator.push(context,
               MaterialPageRoute(builder: (context) => dashBoard()))
             }).catchError((error) {
               pop();
             });
            },
            child: Text("Connexion"),
          ),

          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => register())
              );
            },
            child: Text("Have a account",
              style: TextStyle(color: Colors.orange)
              ,),
          )
        ],
      ),
    );
  }
}


      /*GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      children: [
        Text(
          "Je suis beau",
          style: TextStyle(
            fontSize: 100,
            foreground: Paint()..shader = linearGradient,
          ),
        ),
        Text(
          "Je suis beau",
          style: TextStyle(
            fontSize: 100,
            foreground: Paint()..shader = linearGradient,
          ),
        ),
        Text(
          "Je suis beau",
          style: TextStyle(
            fontSize: 100,
            foreground: Paint()..shader = linearGradient,
          ),
        ),
        Text(
          "Je suis beau",
          style: TextStyle(
            fontSize: 100,
            foreground: Paint()..shader = linearGradient,
          ),
        ),
        Text(
          "Je suis beau",
          style: TextStyle(
            fontSize: 100,
            foreground: Paint()..shader = linearGradient,
          ),
        ),
        Text(
          "Je suis beau",
          style: TextStyle(
            fontSize: 100,
            foreground: Paint()..shader = linearGradient,
          ),
        ),
        Text(
          "Je suis beau",
          style: TextStyle(
            fontSize: 20,
            foreground: Paint()..shader = linearGradient,
          ),
        ),
        Text(
          "Je suis beau",
          style: TextStyle(
            fontSize: 20,
            foreground: Paint()..shader = linearGradient,
          ),
        ),
      ],
    );
    */



      /*Card(
      elevation: 40,
      child: Text("Coucou"),
    );*/

      /*SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
      children: [
    Container(
      decoration: const BoxDecoration(
      shape: BoxShape.circle,
        color: Colors.green,
      ),
        width: 50,
        height: 50,
        child: Image.network("https://media-exp1.licdn.com/dms/image/C4D03AQGspds_lredEQ/profile-displayphoto-shrink_800_800/0/1598698386120?e=1652313600&v=beta&t=86utUEWYdGpDszCxcHYujdwduDXHDQ5WhFoQp6CneH0",

      ),
      ),
        Text(
          "Je suis beau",
          style: TextStyle(
            fontSize: 80,
            foreground: Paint()..shader = linearGradient,
          ),
        ),
        Text(
          "Je suis beau",
          style: TextStyle(
            fontSize: 80,
            foreground: Paint()..shader = linearGradient,
          ),
        ),
        Text(
          "Je suis beau",
          style: TextStyle(
            fontSize: 80,
            foreground: Paint()..shader = linearGradient,
          ),
        ),
        Text(
          "Je suis beau",
          style: TextStyle(
            fontSize: 80,
            foreground: Paint()..shader = linearGradient,
          ),
        ),
        Text(
          "Je suis beau",
          style: TextStyle(
            fontSize: 80,
            foreground: Paint()..shader = linearGradient,
          ),
        ),
        Text(
          "Je suis beau",
          style: TextStyle(
            fontSize: 80,
            foreground: Paint()..shader = linearGradient,
          ),
        ),
        Text(
          "Je suis beau",
          style: TextStyle(
            fontSize: 80,
            foreground: Paint()..shader = linearGradient,
          ),
        ),
        Text(
          "Je suis beau",
          style: TextStyle(
            fontSize: 80,
            foreground: Paint()..shader = linearGradient,
          ),
        ),

      ],
    )
    );
    */


      /*ElevatedButton(onPressed: (){print("je valide");
    },
        child: Text("Appui moi sur le tits"));

       */




      /*Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.green,
      ),
    width: 200,
    height: 400,
    child: Image.network("https://media-exp1.licdn.com/dms/image/C4D03AQGspds_lredEQ/profile-displayphoto-shrink_800_800/0/1598698386120?e=1652313600&v=beta&t=86utUEWYdGpDszCxcHYujdwduDXHDQ5WhFoQp6CneH0",

    ),
    );*/
        /*child: Text(
        "Je suis beau",
      style: TextStyle(
      fontSize: 80,
        foreground: Paint()..shader = linearGradient,
      ),
    ),
    );
    */
