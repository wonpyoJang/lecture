import 'package:json_annotation/json_annotation.dart';
import 'package:lecture/data/model/api_result.dart';
import 'package:lecture/data/model/course.dart';

part 'course_response.g.dart';

@JsonSerializable()
class CourseResponse {
  @JsonKey(name: "_result")
  ApiResult apiResult;

  @JsonKey(name: "course_count")
  final int? courseCount;

  @JsonKey(name: "courses")
  final List<Course>? courses;

  factory CourseResponse.fromJson(Map<String, dynamic> json) =>
      _$CourseResponseFromJson(json);

  CourseResponse(this.apiResult, this.courseCount, this.courses);

  Map<String, dynamic> toJson() => _$CourseResponseToJson(this);
}
