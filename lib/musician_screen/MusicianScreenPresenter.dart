import 'dart:async';

import 'package:amplifier_configurations/model/Musician.dart';
import 'package:amplifier_configurations/model/User.dart';
import 'package:amplifier_configurations/model/firebase/Auth.dart';
import 'package:amplifier_configurations/model/firebase/BaseAuth.dart';
import 'package:amplifier_configurations/model/firebase/FirebaseFirestoreService.dart';
import 'package:amplifier_configurations/musician_screen/MusicianScreenView.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MusicianScreenPresenter {
  final MusicianScreenView _view;
  final FirebaseFirestoreService db;
  final BaseAuth auth;

  StreamSubscription<QuerySnapshot> musicianSub;
  StreamSubscription<QuerySnapshot> userSub;


  MusicianScreenPresenter(this._view) : db = FirebaseFirestoreService(), auth = Auth();

  getMusicians() async {
    musicianSub?.cancel();
    musicianSub = db.getMusiciansList().listen((QuerySnapshot snapshot) {
      final List<Musician> musicians = snapshot.documents
          .map((documentSnapshot) => Musician.fromJson(documentSnapshot.data))
          .toList();
      _view.showMusicians(musicians);
    });
  }
  getUser() async {
    userSub?.cancel();
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
  void disposeUser() {
    userSub?.cancel();
  }
  void addToFavourites(Musician musiciacan){

  }
  updateUser(User user){
    db.updateUser(user);
  }
}
