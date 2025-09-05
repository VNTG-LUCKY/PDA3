// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SessionModelImpl _$$SessionModelImplFromJson(Map<String, dynamic> json) =>
    _$SessionModelImpl(
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      sessionId: json['sessionId'] as String?,
      accessToken: json['accessToken'] as String?,
      refreshToken: json['refreshToken'] as String?,
      expiresAt: json['expiresAt'] == null
          ? null
          : DateTime.parse(json['expiresAt'] as String),
      lastAccess: json['lastAccess'] == null
          ? null
          : DateTime.parse(json['lastAccess'] as String),
      isValid: json['isValid'] as bool? ?? false,
    );

Map<String, dynamic> _$$SessionModelImplToJson(_$SessionModelImpl instance) =>
    <String, dynamic>{
      'user': instance.user,
      'sessionId': instance.sessionId,
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'expiresAt': instance.expiresAt?.toIso8601String(),
      'lastAccess': instance.lastAccess?.toIso8601String(),
      'isValid': instance.isValid,
    };
