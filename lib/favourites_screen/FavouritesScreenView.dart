import 'package:amplifier_configurations/model/Musician.dart';
import 'package:amplifier_configurations/model/User.dart';

abstract class FavouritesScreenView{
  showUser(User user);
  fillFavourites(List<Musician> favourites);

}