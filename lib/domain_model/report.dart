import 'package:json_annotation/json_annotation.dart';

part 'report.g.dart';

@JsonSerializable(nullable: false)
class Report {
  double id;
  String licensePlate;
  String reason;
  double lat;
  double long;
  String message;
  DateTime date;

  Report();
  Report.full(this.id, this.lat, this.long, this.licensePlate, this.reason,
      this.message, this.date);
  factory Report.fromJson(Map<String, dynamic> json) => _$ReportFromJson(json);

  Map<String, dynamic> toJson() => _$ReportToJson(this);
}
