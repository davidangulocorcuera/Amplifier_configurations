// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Musician.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Musician _$MusicianFromJson(Map json) {
  print(json);
  return Musician(
      json['id'] as String,
      json['name'] as String,
      Configuration.fromJson(json['configuration'] as Map),
      Amplifier.fromJson(json['amplifier'] as Map));
}

Map<String, dynamic> _$MusicianToJson(Musician instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'configuration': instance.configuration,
      'amplifier': instance.amplifier
    };
