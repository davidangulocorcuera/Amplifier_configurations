import 'package:amplifier_configurations/model/Musician.dart';

class User {
  String name;
  String email;
  List<Musician> favourites;

  User(this.name, this.email, this.favourites);
}
