import 'package:amplifier_configurations/account_screen/AccountScreen.dart';
import 'package:amplifier_configurations/favourites_screen/FavouritesScreen.dart';
import 'package:amplifier_configurations/login_screen/LoginScreen.dart';
import 'package:amplifier_configurations/musician_screen/MusicianScreen.dart';
import 'package:amplifier_configurations/register_screen/RegisterScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    // TODO: implement initState
    super.initState();
    screen = MyHomePage();
    _children = [_musicianScreen, _accountScreen, _favouriteScreen,_loginScreen,_registerScreen];

  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped, // new
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              title: new Text('Home'),
            ),
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
              title: new Text('Cuenta'),
            )
          ],
        ),
        body: screen
    );
  }
}
