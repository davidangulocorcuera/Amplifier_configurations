import 'package:amplifier_configurations/model/Configuration.dart';
import 'package:amplifier_configurations/model/Amplifier.dart';


class Musician {
  String name;
  Configuration configuration;
  Amplifier amplifier;
  Musician(this.name, this.configuration, this.amplifier);

  Musician.map(dynamic obj) {
    this.name = obj['name'];
    this.configuration = obj['configuration'];
    this.amplifier = obj['amplifier'];

  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (name != null) {
      map['name'] = name;
    }
    map['configuration'] = configuration;
    map['amplifier'] = amplifier;
    return map;
  }
  Musician.fromMap(Map<String, dynamic> map) {
    this.name = map['name'];
    this.configuration = map['configuration'];
    this.amplifier = map['amplifier'];

  }

}