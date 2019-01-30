// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Musician.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Musician _$MusicianFromJson(Map json) {
  return Musician(
      json['name'] as String,
      Configuration.fromJson(json['configuration'] as Map<dynamic, dynamic>),
      Amplifier.fromJson(json['amplifier'] as Map<dynamic, dynamic>));
  }

Map<String, dynamic> _$MusicianToJson(Musician instance) => <String, dynamic>{
      'name': instance.name,
      'configuration': instance.configuration,
      'amplifier': instance.amplifier,
    };
