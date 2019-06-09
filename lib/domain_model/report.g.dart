// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Report _$ReportFromJson(Map<String, dynamic> json) {
  return Report()
    ..id = (json['id'] as num).toDouble()
    ..licensePlate = json['licensePlate'] as String
    ..reason = json['reason'] as String
    ..message = json['message'] as String
    ..date = DateTime.parse(json['date'] as String)
    ..files = (json['files'] as List).map((e) => e as String).toList()
    ..latitude = (json['latitude'] as num).toDouble()
    ..longitude = (json['longitude'] as num).toDouble();
}

Map<String, dynamic> _$ReportToJson(Report instance) => <String, dynamic>{
      'id': instance.id,
      'licensePlate': instance.licensePlate,
      'reason': instance.reason,
      'message': instance.message,
      'date': instance.date.toIso8601String(),
      'files': instance.files,
      'latitude': instance.latitude,
      'longitude': instance.longitude
    };
