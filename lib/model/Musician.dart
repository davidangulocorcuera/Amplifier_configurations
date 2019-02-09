import 'package:amplifier_configurations/model/Configuration.dart';
import 'package:amplifier_configurations/model/Amplifier.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Musician.g.dart';

@JsonSerializable()
class Musician {
  String id;
  String name;
  Configuration configuration;
  Amplifier amplifier;
  bool isFav = false;

  Musician(this.id, this.name, this.configuration, this.amplifier, {this.isFav});

  factory Musician.fromJson(Map<dynamic, dynamic> json) =>
      _$MusicianFromJson(json);

  Map<String, dynamic> toJson() => _$MusicianToJson(this);
}
