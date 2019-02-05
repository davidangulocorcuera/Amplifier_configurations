import 'package:amplifier_configurations/login_screen/LoginScreenView.dart';
import 'package:amplifier_configurations/model/firebase/Auth.dart';
import 'package:amplifier_configurations/model/firebase/BaseAuth.dart';
import 'package:flutter/cupertino.dart';

class LoginScreenPresenter {
  final BaseAuth auth;
  final LoginScreenView _view;

  LoginScreenPresenter(this._view) : auth = Auth();

  showCircularProgress() {
    _view.showCircularProgress();
  }

  loginClicked(String email, String password) async {
    try {
      _view.showCircularProgress();
      String userId = await auth.signIn(email, password);
      print('Signed up user: $userId');
      _view.goToHomePage();
    } catch (e) {
      _view.showLoginError();
    } finally {
      _view.hideCircularProgress();
    }
  }

  bool validateEmail(email) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(p);
    return regExp.hasMatch(email);
  }

  bool validatePassword(String password) {
    return password.length > 6 ? true : false;
  }
}
