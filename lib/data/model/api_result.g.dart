// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiResult _$ApiResultFromJson(Map<String, dynamic> json) {
  return ApiResult(
    json['reason'] as String?,
    json['status'] as String?,
  );
}

Map<String, dynamic> _$ApiResultToJson(ApiResult instance) => <String, dynamic>{
      'reason': instance.reason,
      'status': instance.status,
    };
