import 'package:amplifier_configurations/model/Configuration.dart';
import 'package:amplifier_configurations/model/Amplifier.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Musician.g.dart';

@JsonSerializable()
class Musician {
  String name;
  Configuration configuration;
  Amplifier amplifier;

  Musician(this.name, this.configuration, this.amplifier);

  factory Musician.fromJson(Map<String, dynamic> json) =>
      _$MusicianFromJson(json);

  Map<String, dynamic> toJson() => _$MusicianToJson(this);
}
