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
          .map((documentSnapshot) => Musician.fromJson(documentSnapshot.data))
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
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
          centerTitle: true,
          title: Text("Musicians"),
        ),
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        body: ListView.builder(
      itemBuilder: (context, position) {
        return Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
            child: ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                leading: Container(
                    padding: EdgeInsets.only(right: 12.0),
                    decoration: new BoxDecoration(
                        border: new Border(
                            right: new BorderSide(
                                width: 1.0, color: Colors.white24))),
                    child: Icon(Icons.library_music, color: Colors.white)),
                title: Text(
                  '${musicians[0].name}',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                subtitle: Row(
                  children: <Widget>[
                    Icon(Icons.surround_sound, color: Colors.yellowAccent),
                    Text(' ${musicians[0].amplifier.name}', style: TextStyle(color: Colors.white))
                  ],
                ),
                trailing:
                Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0)
            ),
          ),
        );
      },
      itemCount: musicians.length,
    ));
  }
}
