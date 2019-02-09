import 'package:amplifier_configurations/model/Musician.dart';
import 'package:amplifier_configurations/model/User.dart';

abstract class MusicianScreenView{
 showUsers(List<User> users);
 showMusicians(List<Musician> musicians);
}