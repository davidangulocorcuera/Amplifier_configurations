

import 'package:json_annotation/json_annotation.dart';
part 'Amplifier.g.dart';


@JsonSerializable()
class Amplifier {
  String name;
  Amplifier(this.name);

  factory Amplifier.fromJson(Map<dynamic, dynamic> json) => _$AmplifierFromJson(json);
  Map<String, dynamic> toJson() => _$AmplifierToJson(this);
}