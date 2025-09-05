// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: json['id'] as String,
      company: json['company'] as String,
      companyName: json['companyName'] as String,
      fromDevice: json['fromDevice'] as String,
      notiCount: (json['notiCount'] as num).toInt(),
      factory: json['factory'] as String,
      userId: json['userId'] as String,
      username: json['username'] as String?,
      email: json['email'] as String?,
      role: json['role'] as String?,
      lastLoginAt: json['lastLoginAt'] == null
          ? null
          : DateTime.parse(json['lastLoginAt'] as String),
      isActive: json['isActive'] as bool? ?? true,
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'company': instance.company,
      'companyName': instance.companyName,
      'fromDevice': instance.fromDevice,
      'notiCount': instance.notiCount,
      'factory': instance.factory,
      'userId': instance.userId,
      'username': instance.username,
      'email': instance.email,
      'role': instance.role,
      'lastLoginAt': instance.lastLoginAt?.toIso8601String(),
      'isActive': instance.isActive,
    };
