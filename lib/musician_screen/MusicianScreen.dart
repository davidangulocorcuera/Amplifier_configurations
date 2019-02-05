import 'dart:async';
import 'package:amplifier_configurations/model/Musician.dart';
import 'package:amplifier_configurations/model/firebase/FirebaseFirestoreService.dart';
import 'package:amplifier_configurations/musician_screen/MusicianScreenPresenter.dart';
import 'package:amplifier_configurations/musician_screen/MusicianScreenView.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MusicianScreen extends StatefulWidget {
  MusicianScreen({Key key, this.title}) : super(key: key);
  final String title;
  String barTitle = "Musicians";

  @override
  _MusicianScreenState createState() => _MusicianScreenState();
}

class _MusicianScreenState extends State<MusicianScreen>
    implements MusicianScreenView {
  List<Musician> musicians = [];
  List<Musician> favouritesMusicians = [];
  FirebaseFirestoreService db = new FirebaseFirestoreService();
  MusicianScreenPresenter _presenter;
  bool isMarkedAsFav = false;

  _MusicianScreenState() {
    _presenter = MusicianScreenPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _presenter.getMusicians();
  }

  @override
  showMusicians(List<Musician> musicians) {
    setState(() {
      this.musicians = musicians;
    });
  }

  @override
  void dispose() {
    _presenter.dispose();
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
        body: SafeArea(
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Image(
                image: AssetImage("assets/guitarist.jpg"),
                fit: BoxFit.cover,
                color: Colors.black87,
                colorBlendMode: BlendMode.darken,
              ),
              ListView.builder(
                itemBuilder: (context, position) {
                  return Card(
                    elevation: 8.0,
                    margin: new EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 6.0),
                    child: Container(
                      decoration:
                          BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
                      child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          leading: Container(
                              padding: EdgeInsets.only(right: 12.0),
                              decoration: new BoxDecoration(
                                  border: new Border(
                                      right: new BorderSide(
                                          width: 1.0, color: Colors.white))),
                              child: IconButton(
                                icon: isMarkedAsFav ? Icon(Icons.favorite,
                                    color: Colors.redAccent) : Icon(Icons.favorite_border,
                                    color: Colors.redAccent),
                                  onPressed: () { if(!favouritesMusicians.contains(musicians[position])){
                                  favouritesMusicians.add(musicians[position]);
                                  setState(() {
                                    isMarkedAsFav = true;

                                  });
                                  }
                                  else{
                                    favouritesMusicians.remove(musicians[position]);
                                    setState(() {
                                      isMarkedAsFav = false;

                                    });
                                  }
                                  print(favouritesMusicians.length);
                                },
                              )),
                          title: Text(
                            '${musicians[position].name}',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Row(
                            children: <Widget>[
                              Icon(Icons.surround_sound,
                                  color: Colors.yellowAccent),
                              Text(' ${musicians[position].amplifier.name}',
                                  style: TextStyle(color: Colors.white))
                            ],
                          ),
                          trailing: Icon(Icons.keyboard_arrow_right,
                              color: Colors.white, size: 30.0)),
                    ),
                  );
                },
                itemCount: musicians.length,
              )
            ],
          ),
        ));
  }
}
