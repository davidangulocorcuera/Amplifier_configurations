// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Configuration _$ConfigurationFromJson(Map json) {
  return Configuration(
      json['gain'] as String,
      json['bass'] as String,
      json['mid'] as String,
      json['treble'] as String,
      json['master'] as String,
      json['presence'] as String);
}

Map<String, dynamic> _$ConfigurationToJson(Configuration instance) =>
    <String, dynamic>{
      'gain': instance.gain,
      'bass': instance.bass,
      'mid': instance.mid,
      'treble': instance.treble,
      'master': instance.master,
      'presence': instance.presence
    };
