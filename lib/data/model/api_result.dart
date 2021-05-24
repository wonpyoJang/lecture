import 'package:json_annotation/json_annotation.dart';

part 'api_result.g.dart';

@JsonSerializable()
class ApiResult {

  @JsonKey(name: "reason")
  final String? reason;

  @JsonKey(name: "status")
  final String? status;

  factory ApiResult.fromJson(Map<String, dynamic> json) => _$ApiResultFromJson(json);

  ApiResult(this.reason, this.status);

  Map<String, dynamic> toJson() => _$ApiResultToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ApiResult &&
              runtimeType == other.runtimeType &&
              reason == other.reason &&
              status == other.status;

  @override
  int get hashCode => reason.hashCode ^ status.hashCode;
}