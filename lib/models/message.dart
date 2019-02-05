import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable(nullable: false)
class Message {
  String message;
  int carId;

  Message();

factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);

Map<String, dynamic> toJson() => _$MessageToJson(this);

}