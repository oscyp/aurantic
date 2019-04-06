import 'package:json_annotation/json_annotation.dart';

part 'observed_car.g.dart';

@JsonSerializable(nullable: false)
class ObservedCar {
  final String licensePlate;
  final int notifications;

  ObservedCar(this.licensePlate, this.notifications);

  factory ObservedCar.fromJson(Map<String, dynamic> json) =>
      _$ObservedCarFromJson(json);

  Map<String, dynamic> toJson() => _$ObservedCarToJson(this);
}
