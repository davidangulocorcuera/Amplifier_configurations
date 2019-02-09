import 'package:amplifier_configurations/model/Musician.dart';
import 'package:amplifier_configurations/model/User.dart';

abstract class MusicianScreenView{
 showUser(User user);
 showMusicians(List<Musician> musicians);
}