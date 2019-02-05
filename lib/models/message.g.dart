// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) {
  return Message()
    ..message = json['message'] as String
    ..carId = json['carId'] as int;
}

Map<String, dynamic> _$MessageToJson(Message instance) =>
    <String, dynamic>{'message': instance.message, 'carId': instance.carId};
