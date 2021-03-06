import 'package:flutter/material.dart';
import 'package:flutter_application_1/contact.dart';
import 'package:flutter_application_1/details.dart';
import 'package:flutter_application_1/globalVarialble.dart';

class dashBoard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return dashBoardState();
  }
}

class dashBoardState extends State<dashBoard> {

  int _selectIndex = 0;
  final List<Widget> navbar = [
    contact(),
    detailsUser(),
    Text("Message"),
  ];

  void _onTapeSelect(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Menu"),
        centerTitle: true,
      ),
      body: bodyPage(),
    );
  }

  Widget bodyPage() {
    return Scaffold(
      body: Center(
      child: navbar.elementAt(_selectIndex),
    ),
    bottomNavigationBar: BottomNavigationBar(
    items: [
    BottomNavigationBarItem(icon: Icon(Icons.person_pin_circle), label: "Contact"),
    BottomNavigationBarItem(icon: Icon(Icons.account_circle_rounded), label: "Profil"),
    BottomNavigationBarItem(icon: Icon(Icons.message_rounded), label: "Message"),
    ],
    currentIndex: _selectIndex,
    onTap: _onTapeSelect,
    ),
    );
  }

}