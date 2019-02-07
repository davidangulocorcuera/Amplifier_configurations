import 'package:amplifier_configurations/model/Musician.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class MusicianDetailScreen extends StatefulWidget {
  final Musician musician;

  MusicianDetailScreen({@required this.musician});

  @override
  _MusicianDetailScreenState createState() => _MusicianDetailScreenState();
}

class _MusicianDetailScreenState extends State<MusicianDetailScreen> {


  String setList(int position){
    switch(position){
      case 0:
        return "Bass " + widget.musician.configuration.bass;

      case 1:
        return "Gain " + widget.musician.configuration.gain;

      case 2:
        return "Presence " + widget.musician.configuration.presence;

      case 3:
        return "Treble " + widget.musician.configuration.treble;

      case 4:
          return "Middle " + widget.musician.configuration.mid;

      case 5:
       return  "Master " + widget.musician.configuration.master;

      default: return "";

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
          centerTitle: true,
          title: Center(
            child: SizedBox(
              width: 250.0,
              child: TypewriterAnimatedTextKit(
                onTap: () {
                  print("Tap Event");
                },
                text: [
                  widget.musician.name,
                  widget.musician.name,
                  widget.musician.name,
                  widget.musician.name,
                ],
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                ),
              ),
            ),
          ),
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
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(64, 75, 96, .9)),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          leading: Container(
                              padding: EdgeInsets.only(right: 12.0),
                              decoration:  BoxDecoration(
                                  border:  Border(
                                      right:  BorderSide(
                                          width: 1.0, color: Colors.white))),
                              child: Text("Configuration")),

                          title: Text(
                            setList(position),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                  );

                },
                itemCount: 6,

              )
            ],
          ),
        ));
  }
}
