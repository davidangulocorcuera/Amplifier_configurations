// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

User _$UserFromJson(Map json) {
  return User(
      (json['favourites'] as List)
          .map((e) => Musician.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['email'] as String);
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'favourites': instance.favourites,
      'email': instance.email
    };
