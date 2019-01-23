import 'package:amplifier_configurations/home_page/MyHomePage.dart';
import 'package:amplifier_configurations/login_screen/LoginScreen.dart';
import 'package:amplifier_configurations/model/firebase/BaseAuth.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}

