import 'dart:async';
import 'package:amplifier_configurations/account_screen/AccountScreen.dart';
import 'package:amplifier_configurations/favourites_screen/FavouritesScreen.dart';
import 'package:amplifier_configurations/login_screen/LoginScreen.dart';
import 'package:amplifier_configurations/model/firebase/BaseAuth.dart';
import 'package:amplifier_configurations/musician_screen/MusicianScreen.dart';
import 'package:amplifier_configurations/register_screen/RegisterScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.auth})
      : super(key: key);
  final String title;
  final BaseAuth auth;


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MusicianScreen _musicianScreen = MusicianScreen();
  AccountScreen _accountScreen = AccountScreen();
  FavouriteScreen _favouriteScreen = FavouriteScreen();
  LoginScreen _loginScreen = LoginScreen();
  RegisterScreen _registerScreen = RegisterScreen();
  Widget screen;
  int _currentIndex = 0;
  List<Widget> _children = [];



  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      screen = _children[_currentIndex];
    });
  }

  @override
  void initState() {
    super.initState();
    screen = _musicianScreen;
    _children = [_musicianScreen, _favouriteScreen, _accountScreen];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
              canvasColor: Color.fromRGBO(64, 75, 96, .9),
              // sets the active color of the `BottomNavigationBar` if `Brightness` is light
              primaryColor: Colors.orange,
              textTheme: Theme.of(context)
                  .textTheme
                  .copyWith(caption: new TextStyle(color: Colors.white))),
          child: BottomNavigationBar(
            onTap: onTabTapped, // new
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: new Icon(Icons.music_note),
                title: new Text('Musicians'),
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.star),
                title: new Text('Favourites'),
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.supervisor_account),
                title: new Text('Account'),
              )
            ],
          ),
        ),
        body:
            WillPopScope(onWillPop: () => Future.value(false), child: screen));
  }
}
