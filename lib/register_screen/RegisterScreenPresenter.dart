import 'package:amplifier_configurations/register_screen/RegisterScreenView.dart';

class RegisterScreenPresenter{

 RegisterScreenView _view;
  RegisterScreenPresenter(this._view);

  validateEmail(email){
    _view.validateEmail(email);
  }
  validatePassword(String password){
    _view.validatePassword(password);
  }

}