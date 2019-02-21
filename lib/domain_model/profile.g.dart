// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) {
  return Profile(json['name'] as String, json['email'] as String);
}

Map<String, dynamic> _$ProfileToJson(Profile instance) =>
    <String, dynamic>{'name': instance.name, 'email': instance.email};
