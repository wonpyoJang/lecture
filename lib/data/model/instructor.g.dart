// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'instructor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Instructor _$InstructorFromJson(Map<String, dynamic> json) {
  return Instructor(
    json['id'] as int,
    json['fullname'] as String?,
    json['firstname'] as String?,
    json['lastname'] as String?,
    json['profile_url'] as String?,
  );
}

Map<String, dynamic> _$InstructorToJson(Instructor instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullname': instance.fullname,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'profile_url': instance.profileUrl,
    };
