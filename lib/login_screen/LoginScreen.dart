import 'package:amplifier_configurations/home_page/MyHomePage.dart';
import 'package:amplifier_configurations/login_screen/LoginScreenView.dart';
import 'package:amplifier_configurations/model/firebase/BaseAuth.dart';
import 'package:amplifier_configurations/register_screen/RegisterScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class LoginScreen extends StatefulWidget {
  LoginScreen({this.auth});

  final BaseAuth auth;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin
    implements LoginScreenView {
  AnimationController _iconAnimationController;
  Animation<double> _iconAnimation;
  String _email;
  String _password;
  String _errorMessage;
  bool _isLoading;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _iconAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _iconAnimation = CurvedAnimation(
        parent: _iconAnimationController, curve: Curves.bounceOut);
    _iconAnimation.addListener(() => this.setState(() {}));
    _iconAnimationController.forward();
    _email = "";
    _password = "";
    _errorMessage  = "";
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black38,
        ),
        backgroundColor: Colors.black,
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image(
              image: AssetImage("assets/guitarist.jpg"),
              fit: BoxFit.cover,
              color: Colors.black87,
              colorBlendMode: BlendMode.darken,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlutterLogo(
                  size: _iconAnimation.value * 100,
                ),
                Form(
                  key: _formKey,
                  child: Theme(
                    data: ThemeData(
                        brightness: Brightness.dark,
                        primarySwatch: Colors.teal,
                        inputDecorationTheme: InputDecorationTheme(
                            labelStyle: TextStyle(
                                color: Colors.white70, fontSize: 20.0))),
                    child: Container(
                      padding: const EdgeInsets.all(40.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "Enter E-mail",
                            ),
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (value) => _email = value,
                            validator: (value) {
                              if (!validateEmail(value)) {
                                return 'Incorrect e-mail';
                              }
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "Enter Password",
                            ),
                            keyboardType: TextInputType.text,
                            onSaved: (value) => _password = value,
                            validator: (value) {
                              if (!validatePassword(value)) {
                                return 'Password incorrect';
                              }
                            },
                            obscureText: true,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 40.0),
                          ),
                          MaterialButton(
                            height: 40.0,
                            minWidth: 60.0,
                            color: Colors.green,
                            textColor: Colors.white,
                            child: Text("Login"),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                              loginUser();
                              }
                            },
                            splashColor: Colors.blueAccent,
                          ),
                          Padding(padding: const EdgeInsets.only(top: 10.0)),
                          FlatButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterScreen(auth: new Auth())),
                              );
                            },
                            splashColor: Colors.blueAccent,
                            child: Text(
                              "Create account",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.white70,
                                color: Colors.white70,
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ));
  }

  @override
  validateEmail(email) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(p);
    return regExp.hasMatch(email);
  }

  @override
  validatePassword(String password) {
    return password.length > 6 ? true : false;
  }


  @override
  showCircularProgress() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    } return Container(height: 0.0, width: 0.0,);

  }

  @override
  loginUser() async {
    print("hola");
    setState(() {
      _errorMessage = "";
    });
    String userId = "";
    try {
      userId = await widget.auth.signIn(_email, _password);
      print('Signed up user: $userId');
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                MyHomePage(title: "hola")),
      );
    } catch (e) {
      _errorMessage = e.message;
      print(_errorMessage);

    }
  }
}
