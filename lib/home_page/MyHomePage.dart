import 'package:amplifier_configurations/account_screen/AccountScreen.dart';
import 'package:amplifier_configurations/favourites_screen/FavouritesScreen.dart';
import 'package:amplifier_configurations/login_screen/LoginScreen.dart';
import 'package:amplifier_configurations/musician_screen/MusicianScreen.dart';
import 'package:amplifier_configurations/register_screen/RegisterScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

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
    screen = MyHomePage();
    _children = [_musicianScreen, _favouriteScreen, _accountScreen];


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          title: Text(widget.title),
        ),
        bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
            canvasColor: Colors.black,
            // sets the active color of the `BottomNavigationBar` if `Brightness` is light
            primaryColor: Colors.teal,
            textTheme: Theme
                .of(context)
                .textTheme
                .copyWith(caption: new TextStyle(color: Colors.white70))),
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
        body: screen
    );
  }
}
