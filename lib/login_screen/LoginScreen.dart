import 'package:amplifier_configurations/home_page/MyHomePage.dart';
import 'package:amplifier_configurations/login_screen/LoginScreenPresenter.dart';
import 'package:amplifier_configurations/login_screen/LoginScreenView.dart';
import 'package:amplifier_configurations/register_screen/RegisterScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin
    implements LoginScreenView {
  AnimationController _iconAnimationController;
  Animation<double> _iconAnimation;
  String _email = "";
  String _password = "";
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey();
  LoginScreenPresenter _presenter;

  _LoginScreenState() {
    _presenter = LoginScreenPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _iconAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _iconAnimation = CurvedAnimation(
        parent: _iconAnimationController, curve: Curves.bounceOut);
    _iconAnimation.addListener(() => this.setState(() {}));
    _iconAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      backgroundColor: Colors.black,
      body: SafeArea(
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
                                    return 'Password incorrect';
                                  }
                                },
                                enabled: !_isLoading,
                                obscureText: true,
                              ),
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
                                      child: Text("Login"),
                                      onPressed: () async {
                                        if (_formKey.currentState.validate()) {
                                          _formKey.currentState.save();
                                          _presenter.loginClicked(
                                              _email, _password);
                                        }
                                      },
                                      splashColor: Colors.blueAccent,
                                    ),
                              Padding(padding: const EdgeInsets.only(top: 10.0)),
                              FlatButton(
                                onPressed: () {
                                  _formKey.currentState.reset();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RegisterScreen()),
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
  showLoginError() {
    _scaffoldState.currentState.showSnackBar(SnackBar(
      content: Text("incorrect user or password"),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 1),
    ));
  }
}
