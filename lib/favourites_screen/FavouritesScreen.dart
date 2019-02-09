import 'package:amplifier_configurations/favourites_screen/FavouritesScreenPresenter.dart';
import 'package:amplifier_configurations/favourites_screen/FavouritesScreenView.dart';
import 'package:amplifier_configurations/model/Musician.dart';
import 'package:amplifier_configurations/model/User.dart';
import 'package:amplifier_configurations/model/firebase/FirebaseFirestoreService.dart';
import 'package:amplifier_configurations/musician_detail_screen/MusicianDetailScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class FavouriteScreen extends StatefulWidget {
  FavouriteScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> implements FavouritesScreenView{
  List<Musician> favouritesMusicians = [];
  User user;
  FirebaseFirestoreService db = new FirebaseFirestoreService();
  FavouritesScreenPresenter _presenter;
  String barTittle = "Favourites";

  _FavouriteScreenState() {
    _presenter = FavouritesScreenPresenter(this);
  }
  @override
  void initState() {
    super.initState();
    _presenter.getUser();
  }
  @override
  showUser(User user) {
    setState(() {
      this.user = user;
    });

    _presenter.getFavourites(user.favourites);
  }

  @override
  fillFavourites(List<Musician> favourites) {
    setState(() {
      this.favouritesMusicians = favourites;
    });

   // if (this.favouritesMusicians.length == this.user.favourites.length) setState(() {});
  }

  @override
  void dispose() {
    _presenter.disposeUser();
    _presenter.disposeFavourites();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
          centerTitle: true,
          title: Text(barTittle),
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
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: ListView.builder(
                  itemBuilder: (context, position) {
                    return Card(
                      elevation: 8.0,
                      margin: new EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 6.0),
                      child: Container(
                        decoration:
                            BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
                        child: ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MusicianDetailScreen(
                                      musician: favouritesMusicians[position]),
                                ),
                              );
                            },
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            leading: Container(
                                padding: EdgeInsets.only(right: 12.0),
                                decoration: new BoxDecoration(
                                    border: new Border(
                                        right: new BorderSide(
                                            width: 1.0, color: Colors.white))),
                                child: IconButton(
                                  icon: Icon(Icons.delete,
                                      color: Colors.redAccent),
                                  onPressed: () {

                                  },
                                )),
                            title: Text(
                              favouritesMusicians[position].name,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Row(
                              children: <Widget>[
                                Text(favouritesMusicians[position].amplifier.name,
                                    style: TextStyle(color: Colors.white))
                              ],
                            ),
                            trailing: Icon(Icons.keyboard_arrow_right,
                                color: Colors.white, size: 30.0)),
                      ),
                    );
                  },
                  itemCount: favouritesMusicians.length,
                ),
              )
            ],
          ),
        ));
  }




}
