import 'package:json_annotation/json_annotation.dart';

part 'car.g.dart';

@JsonSerializable(nullable: false)
class Car{
  String licensePlate;
  String mark;
  String model;
  String color;

  Car();
  Car.withRegistration(String registration){
    this.licensePlate = registration;
  }

  factory Car.fromJson(Map<String, dynamic> json) => _$CarFromJson(json);

  Map<String, dynamic> toJson() => _$CarToJson(this);

  // Map toJson() => {
  //   'registration': registration,
  //   'mark': mark,
  //   'model': model,
  //   'color': color
  // };
}