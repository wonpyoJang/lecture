// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseResponse _$CourseResponseFromJson(Map<String, dynamic> json) {
  return CourseResponse(
    ApiResult.fromJson(json['_result'] as Map<String, dynamic>),
    json['course_count'] as int?,
    (json['courses'] as List<dynamic>?)
        ?.map((e) => Course.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$CourseResponseToJson(CourseResponse instance) =>
    <String, dynamic>{
      '_result': instance.apiResult,
      'course_count': instance.courseCount,
      'courses': instance.courses,
    };
