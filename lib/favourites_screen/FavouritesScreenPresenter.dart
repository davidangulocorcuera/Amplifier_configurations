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
  StreamSubscription<QuerySnapshot> userSub;
  StreamSubscription<List<QuerySnapshot>> favouritesSub;
  FavouritesScreenPresenter(this._view) : db = FirebaseFirestoreService(), auth = Auth();

  getUser() async {
    String uid = await auth.getCurrentUser();
    userSub = db.getUser(uid).listen((QuerySnapshot snapshot) {
      final user = snapshot.documents.map((documentSnapshot) => User.fromJson(documentSnapshot.data)).toList()[0]; // Get first of single item list

      _view.showUser(user);
    });
  }

  getFavourites(List<String> ids) async {
    favouritesSub = db.getFavouritesMusicians(ids).listen((favs) {
      List<Musician> favourites = [];
      for (var fav in favs) {
        favourites.add(fav.documents.map((doc) => Musician.fromJson(doc.data)).toList()[0]);
      }
      _view.fillFavourites(favourites);
    });

  }

  void disposeUser() {
    userSub?.cancel();
  }

  void disposeFavourites() {
    favouritesSub?.cancel();
  }
  updateUser(User user){
    db.updateUser(user);
  }
}