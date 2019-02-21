import 'package:json_annotation/json_annotation.dart';

part 'profile.g.dart';

@JsonSerializable(nullable: false)
class Profile {
  final String name;
  final String email;

  Profile(this.name, this.email);

  factory Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);

}