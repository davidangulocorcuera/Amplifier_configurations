import 'package:amplifier_configurations/home_page/MyHomePage.dart';
import 'package:amplifier_configurations/model/firebase/BaseAuth.dart';
import 'package:amplifier_configurations/register_screen/RegisterScreenView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({this.auth});

  final BaseAuth auth;

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    implements RegisterScreenView {
  bool _isLoading;
  bool _value2 = false;
  final _formKey = GlobalKey<FormState>();
  String _errorMessage;
  String _email;
  String _password;

  @override
  void initState(){
    _password = "";
    _errorMessage = "";
    _isLoading = false;
  }

  void _value2Changed(bool value) => setState(() => _value2 = value);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
                  size: 100.0,
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
                                return 'The password must be 6 characters long or more.';
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
                            child: Text("Sign up!"),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                _registerUser();
                                if(_registerUser()){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MyHomePage(title: "hola")),
                                  );
                                }

                              }
                            },
                            splashColor: Colors.blueAccent,
                          ),
                          Padding(padding: const EdgeInsets.only(top: 10.0)),
                          FlatButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            splashColor: Colors.blueAccent,
                            child: Text(
                              "Sign in",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.white70,
                                color: Colors.white70,
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                          Padding(padding: const EdgeInsets.only(top: 20.0)),
                          new CheckboxListTile(
                            value: _value2,
                            onChanged: _value2Changed,
                            title: Text('I agree to the terms of service'),
                            controlAffinity: ListTileControlAffinity.leading,
                            activeColor: Colors.teal,
                          ),
                          FlatButton(
                            onPressed: () {},
                            splashColor: Colors.blueAccent,
                            child: Text(
                              "Terms of service",
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
            showErrorMessage(),
            showCircularProgress(),
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
  showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return new Text(
        _errorMessage,
        style: TextStyle(
            fontSize: 13.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }

  @override
  showCircularProgress() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  _registerUser() async {
    print("hola");
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });
    String userId = "";
    try {
      userId = await widget.auth.signUp(_email, _password);
      print('Signed up user: $userId');
      _isLoading = false;
      return true;
    } catch (e) {
      _isLoading = false;
      print(_password);
      _errorMessage = e.details;
      print(_errorMessage);
      return false;
    }
  }
}
