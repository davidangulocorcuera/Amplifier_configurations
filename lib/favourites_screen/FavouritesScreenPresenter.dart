import 'dart:async';

import 'package:amplifier_configurations/favourites_screen/FavouritesScreenView.dart';
import 'package:amplifier_configurations/model/Musician.dart';
import 'package:amplifier_configurations/model/User.dart';
import 'package:amplifier_configurations/model/firebase/Auth.dart';
import 'package:amplifier_configurations/model/firebase/BaseAuth.dart';
import 'package:amplifier_configurations/model/firebase/FirebaseFirestoreService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavouritesScreenPresenter {
  final FavouritesScreenView _view;
  final FirebaseFirestoreService db;
  final BaseAuth auth;
  StreamSubscription<QuerySnapshot> musicianSub;

  FavouritesScreenPresenter(this._view) : db = FirebaseFirestoreService(), auth = Auth();

  getUser() async {
    musicianSub?.cancel();
    String uid = await auth.getCurrentUser();
    musicianSub = db.getUser(uid).listen((QuerySnapshot snapshot) {
      final users  = snapshot.documents
          .map((documentSnapshot) => User.fromJson(documentSnapshot.data))
          .toList();
      print(users.length);
      _view.showUsers(users);
    });
  }

  void dispose() {
    musicianSub?.cancel();
  }
  void addToFavourites(Musician musiciacan){

  }
}