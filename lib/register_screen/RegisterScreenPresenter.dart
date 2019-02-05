import 'package:amplifier_configurations/model/firebase/Auth.dart';
import 'package:amplifier_configurations/model/firebase/BaseAuth.dart';
import 'package:amplifier_configurations/model/firebase/FirebaseFirestoreService.dart';
import 'package:amplifier_configurations/register_screen/RegisterScreenView.dart';

class RegisterScreenPresenter{
  final BaseAuth auth;
  final FirebaseFirestoreService db;
  String _errorMessage = "";
  RegisterScreenView _view;
  RegisterScreenPresenter(this._view):
        auth = Auth(),
        db = FirebaseFirestoreService();

 bool validateEmail(email) {
   String p =
       r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
   RegExp regExp = new RegExp(p);
   return regExp.hasMatch(email);
 }

 bool validatePassword(String password) {
   return password.length > 6 ? true : false;
 }

  registerClicked(String email, String password) async {
    try {
      _view.showCircularProgress();
      String userId = await auth.signUp(email, password);
      print(userId);
      createUser(email,userId);
      print('Signed up user: $userId');
      _view.goToHomePage();
    } catch (e) {
       _errorMessage = "The user already exists";
      _view.showError(_errorMessage);
    } finally {
      _view.hideCircularProgress();
    }
  }
   void createUser(String email,String uid){
   db.createUser([], email,uid);
 }

}