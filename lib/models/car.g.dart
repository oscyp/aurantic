// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Car _$CarFromJson(Map<String, dynamic> json) {
  return Car()
    ..licensePlate = json['licensePlate'] as String
    ..mark = json['mark'] as String
    ..model = json['model'] as String
    ..color = json['color'] as String;
}

Map<String, dynamic> _$CarToJson(Car instance) => <String, dynamic>{
      'licensePlate': instance.licensePlate,
      'mark': instance.mark,
      'model': instance.model,
      'color': instance.color
    };
