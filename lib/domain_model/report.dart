import 'package:json_annotation/json_annotation.dart';

part 'report.g.dart';

@JsonSerializable(nullable: false)
class Report{
  String licensePlate;
  String reason;
  double lat;
  double long;
  String message;
  
  Report();
  factory Report.fromJson(Map<String, dynamic> json) => _$ReportFromJson(json);

  Map<String, dynamic> toJson() => _$ReportToJson(this);
}