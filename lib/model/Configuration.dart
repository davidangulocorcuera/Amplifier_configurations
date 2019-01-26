class Configuration{
  String gain;
  String bass;
  String mid;
  String treble;
  String master;
  String presence;

  Configuration(this.gain, this.bass, this.mid,this.treble, this.master, this.presence);
  Configuration.map(dynamic obj) {
    this.gain = obj['gain'];
    this.bass = obj['bass'];
    this.mid = obj['mid'];
    this.treble = obj['treble'];
    this.master = obj['master'];
    this.presence = obj['presence'];
    }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (gain != null) {
      map['gain'] = gain;
    }
    map['bass'] = bass;
    map['mid'] = mid;
    map['treble'] = treble;
    map['master'] = master;
    map['presence'] = presence;
    return map;
  }

  Configuration.fromMap(Map<String, dynamic> map) {
    this.gain = map['gain'];
    this.bass = map['bass'];
    this.mid = map['mid'];
    this.treble = map['treble'];
    this.master = map['master'];
    this.presence = map['presence'];
  }
}