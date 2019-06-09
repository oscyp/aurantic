import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'report.g.dart';

@JsonSerializable(nullable: false)
class Report {
  double id;
  String licensePlate;
  String reason;
  String message;
  DateTime date;
  List<String> files;
  double latitude;
  double longitude;

  Report();
  Report.full(this.id, this.latitude, this.longitude, this.licensePlate, this.reason,
      this.message, this.date);
  factory Report.fromJson(Map<String, dynamic> json) => _$ReportFromJson(json);

  Map<String, dynamic> toJson() => _$ReportToJson(this);
}
