import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';


class AccountScreen extends StatefulWidget {
  AccountScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        centerTitle: true,
        title: Text("Account"),
        actions: <Widget>[
          // action button
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              // logout
            },
          ),
          // action button
        ],
      ),
    );
  }
}
