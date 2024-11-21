// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthResponse _$AuthResponseFromJson(Map<String, dynamic> json) => AuthResponse(
      apiStatus: (json['apiStatus'] as num).toInt(),
      userId: json['userId'] as String,
      errors:
          AuthResponseError.fromJson(json['errors'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuthResponseToJson(AuthResponse instance) =>
    <String, dynamic>{
      'apiStatus': instance.apiStatus,
      'userId': instance.userId,
      'errors': instance.errors,
    };

AuthResponseError _$AuthResponseErrorFromJson(Map<String, dynamic> json) =>
    AuthResponseError(
      errorText: json['errorText'] as String,
    );

Map<String, dynamic> _$AuthResponseErrorToJson(AuthResponseError instance) =>
    <String, dynamic>{
      'errorText': instance.errorText,
    };
