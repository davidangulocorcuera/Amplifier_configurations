class Amplifier {
  String name;
  Amplifier(this.name);

  Amplifier.map(dynamic obj) {
    this.name = obj['name'];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (name != null) {
      map['name'] = name;
    }
    return map;
  }
  Amplifier.fromMap(Map<String, dynamic> map) {
    this.name = map['name'];
  }
}