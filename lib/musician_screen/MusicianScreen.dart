import 'dart:async';

import 'package:amplifier_configurations/model/Musician.dart';
import 'package:amplifier_configurations/model/firebase/FirebaseFirestoreService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MusicianScreen extends StatefulWidget {
  MusicianScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MusicianScreenState createState() => _MusicianScreenState();
}

class _MusicianScreenState extends State<MusicianScreen> {
  List<Musician> musicians;
  StreamSubscription<QuerySnapshot> musicianSub;
  FirebaseFirestoreService db = new FirebaseFirestoreService();

  @override
  void initState() {
    super.initState();
    musicians = new List();

    musicianSub?.cancel();
    musicianSub = db.getMusiciansList().listen((QuerySnapshot snapshot) {
      final List<Musician> musicians = snapshot.documents
          .map((documentSnapshot) => Musician.fromMap(documentSnapshot.data))
          .toList();

      setState(() {
        this.musicians = musicians;
      });
    });
    }
  @override
  void dispose() {
    musicianSub?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
       child: ListView(
         children: <Widget>[
           ListTile(
             title: Text(
               '${musicians.length}'
             ),
           )
         ],
       )
      ),
    );
  }
}
