import 'package:amplifier_configurations/model/Musician.dart';
import 'package:json_annotation/json_annotation.dart';

part 'User.g.dart';


@JsonSerializable()

class User {
  User(this.favourites, this.email,this.id);
  String id;
  List<String> favourites;
  String email;
  factory User.fromJson(Map<dynamic, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}