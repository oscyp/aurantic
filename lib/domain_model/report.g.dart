// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Report _$ReportFromJson(Map<String, dynamic> json) {
  return Report()
    ..licensePlate = json['licensePlate'] as String
    ..reason = json['reason'] as String
    ..lat = (json['lat'] as num).toDouble()
    ..long = (json['long'] as num).toDouble()
    ..message = json['message'] as String;
}

Map<String, dynamic> _$ReportToJson(Report instance) => <String, dynamic>{
      'licensePlate': instance.licensePlate,
      'reason': instance.reason,
      'lat': instance.lat,
      'long': instance.long,
      'message': instance.message
    };
