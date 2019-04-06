// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'observed_car.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ObservedCar _$ObservedCarFromJson(Map<String, dynamic> json) {
  return ObservedCar(
      json['licensePlate'] as String, json['notifications'] as int);
}

Map<String, dynamic> _$ObservedCarToJson(ObservedCar instance) =>
    <String, dynamic>{
      'licensePlate': instance.licensePlate,
      'notifications': instance.notifications
    };
