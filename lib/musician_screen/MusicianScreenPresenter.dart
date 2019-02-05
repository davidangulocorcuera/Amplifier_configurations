import 'dart:async';

import 'package:amplifier_configurations/model/Musician.dart';
import 'package:amplifier_configurations/model/firebase/BaseAuth.dart';
import 'package:amplifier_configurations/model/firebase/FirebaseFirestoreService.dart';
import 'package:amplifier_configurations/musician_screen/MusicianScreenView.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MusicianScreenPresenter {
  final MusicianScreenView _view;
  final FirebaseFirestoreService db;
  StreamSubscription<QuerySnapshot> musicianSub;

  MusicianScreenPresenter(this._view) : db = FirebaseFirestoreService();

  getMusicians() async {
    musicianSub?.cancel();
    musicianSub = db.getMusiciansList().listen((QuerySnapshot snapshot) {
      final List<Musician> musicians = snapshot.documents
          .map((documentSnapshot) => Musician.fromJson(documentSnapshot.data))
          .toList();
      _view.showMusicians(musicians);
    });
  }

  void dispose() {
    musicianSub?.cancel();
  }
  void addToFavourites(Musician musiciacan){

  }
}
