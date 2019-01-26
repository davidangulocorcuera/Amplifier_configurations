
import 'package:json_annotation/json_annotation.dart';
part 'Configuration.g.dart';



@JsonSerializable()
class Configuration{
  String gain;
  String bass;
  String mid;
  String treble;
  String master;
  String presence;

  Configuration(this.gain, this.bass, this.mid,this.treble, this.master, this.presence);
  factory Configuration.fromJson(Map<dynamic, dynamic> json) => _$ConfigurationFromJson(json);
  Map<String, dynamic> toJson() => _$ConfigurationToJson(this);

}