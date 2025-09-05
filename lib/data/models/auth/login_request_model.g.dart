// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LoginRequestModelImpl _$$LoginRequestModelImplFromJson(
        Map<String, dynamic> json) =>
    _$LoginRequestModelImpl(
      userId: json['userId'] as String,
      userPassword: json['userPassword'] as String,
      uuid: json['uuid'] as String?,
      fromDevice: json['fromDevice'] as String? ?? 'M',
      remember: json['remember'] as bool? ?? false,
    );

Map<String, dynamic> _$$LoginRequestModelImplToJson(
        _$LoginRequestModelImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'userPassword': instance.userPassword,
      'uuid': instance.uuid,
      'fromDevice': instance.fromDevice,
      'remember': instance.remember,
    };
