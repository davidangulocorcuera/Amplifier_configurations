import 'package:amplifier_configurations/login_screen/LoginScreenView.dart';

class LoginScreenPresenter{

  LoginScreenView _view;
  LoginScreenPresenter(this._view);

  validateEmail(email){
    _view.validateEmail(email);
  }

}