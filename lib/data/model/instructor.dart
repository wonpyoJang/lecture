import 'package:json_annotation/json_annotation.dart';
import 'package:lecture/data/model/api_result.dart';
import 'package:lecture/data/model/course.dart';

part 'instructor.g.dart';

@JsonSerializable()
class Instructor {
  @JsonKey(name: "id")
  final int id;

  @JsonKey(name: "fullname")
  final String? fullname;

  @JsonKey(name: "firstname")
  final String? firstname;

  @JsonKey(name: "lastname")
  final String? lastname;

  @JsonKey(name: "profile_url")
  final String? profileUrl;

  factory Instructor.fromJson(Map<String, dynamic> json) =>
      _$InstructorFromJson(json);

  Instructor(this.id, this.fullname, this.firstname, this.lastname, this.profileUrl);

  Map<String, dynamic> toJson() => _$InstructorToJson(this);
}
