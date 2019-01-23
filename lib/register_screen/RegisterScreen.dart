import 'package:amplifier_configurations/home_page/MyHomePage.dart';
import 'package:amplifier_configurations/register_screen/RegisterScreenPresenter.dart';
import 'package:amplifier_configurations/register_screen/RegisterScreenView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    implements RegisterScreenView {
  bool _isLoading = false;
  bool _valueCheck = false;
  String _email = "";
  String _password = "";
  final _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey();

  RegisterScreenPresenter _presenter;

  _RegisterScreenState() {
    _presenter = RegisterScreenPresenter(this);
  }

  @override
  void initState() {
  }

  void _valueCheckChanged(bool value) => setState(() => _valueCheck = value);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      backgroundColor: Colors.black,
      body:SafeArea(
        child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Image(
                    image: AssetImage("assets/guitarist.jpg"),
                    fit: BoxFit.cover,
                    color: Colors.black87,
                    colorBlendMode: BlendMode.darken,
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(top : 50.0),
                      child: Column(
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
                                        if (!_presenter.validateEmail(value)) {
                                          return 'Incorrect e-mail';
                                        }
                                      },
                                      enabled: !_isLoading,
                                    ),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        labelText: "Enter Password",
                                      ),
                                      keyboardType: TextInputType.text,
                                      onSaved: (value) => _password = value,
                                      validator: (value) {
                                        if (!_presenter.validatePassword(value)) {
                                          return 'The password must be 6 characters long or more.';
                                        }
                                      },
                                      enabled: !_isLoading,
                                      obscureText: true,                                ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 40.0),
                                    ),
                                    _isLoading
                                        ? CircularProgressIndicator()
                                        : MaterialButton(
                                      height: 40.0,
                                      minWidth: 60.0,
                                      color: Colors.green,
                                      textColor: Colors.white,
                                      child: Text("Sign up!"),
                                      onPressed: () async {
                                        if(!_valueCheck){
                                          showTermsError();
                                        }
                                        else if (_formKey.currentState.validate()) {
                                          _formKey.currentState.save();
                                          _presenter.registerClicked(
                                              _email, _password);
                                        }
                                      },
                                      splashColor: Colors.blueAccent,
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.only(top: 10.0)),
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
                                    Padding(
                                        padding: const EdgeInsets.only(top: 20.0)),
                                    new CheckboxListTile(
                                      value: _valueCheck,
                                      onChanged: _valueCheckChanged,
                                      title:
                                          Text('I agree to the terms of service'),
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
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
                          ),
                          // Find the Scaffold in the Widget tree and use it to show a SnackBar!
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  @override
  showCircularProgress() {
    setState(() {
      _isLoading = true;
    });
  }

  @override
  hideCircularProgress() {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  goToHomePage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MyHomePage(title: "hola")),
    );
  }

  @override
  showRegisterError() {
    _scaffoldState.currentState.showSnackBar(SnackBar(
      content: Text("The user already exists"),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 1),
    ));
  }
  @override
  showTermsError() {
    _scaffoldState.currentState.showSnackBar(SnackBar(
      content: Text("May accept the terms of service"),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 1),
    ));
  }
}
