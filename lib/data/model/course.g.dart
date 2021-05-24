// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Course _$CourseFromJson(Map<String, dynamic> json) {
  return Course(
    json['title'] as String?,
    json['logo_file_url'] as String?,
  );
}

Map<String, dynamic> _$CourseToJson(Course instance) => <String, dynamic>{
      'title': instance.title,
      'logo_file_url': instance.logoFileUrl,
    };
