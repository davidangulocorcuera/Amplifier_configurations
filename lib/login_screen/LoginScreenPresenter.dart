import 'package:amplifier_configurations/login_screen/LoginScreenView.dart';

class LoginScreenPresenter{

  LoginScreenView _view;
  LoginScreenPresenter(this._view);

  validateEmail(email){
    _view.validateEmail(email);
  }
  validatePassword(String password){
    _view.validatePassword(password);
  }
  showCircularProgress(){
    _view.showCircularProgress();
  }
  loginUser(){
    _view.loginUser();
  }

}