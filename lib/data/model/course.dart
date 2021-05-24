import 'package:json_annotation/json_annotation.dart';

part 'course.g.dart';

@JsonSerializable()
class Course {

  @JsonKey(name: "title")
  final String? title;

  @JsonKey(name: "logo_file_url")
  final String? logoFileUrl;

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);

  Course(this.title, this.logoFileUrl);

  Map<String, dynamic> toJson() => _$CourseToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Course &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          logoFileUrl == other.logoFileUrl;

  @override
  int get hashCode => title.hashCode ^ logoFileUrl.hashCode;
}