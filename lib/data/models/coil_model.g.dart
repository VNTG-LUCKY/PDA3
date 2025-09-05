// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coil_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CoilModelImpl _$$CoilModelImplFromJson(Map<String, dynamic> json) =>
    _$CoilModelImpl(
      id: json['id'] as String,
      coilNumber: json['coilNumber'] as String,
      productType: json['productType'] as String,
      weight: (json['weight'] as num).toDouble(),
      width: (json['width'] as num).toDouble(),
      thickness: (json['thickness'] as num).toDouble(),
      grade: json['grade'] as String,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      location: json['location'] as String?,
      remarks: json['remarks'] as String?,
    );

Map<String, dynamic> _$$CoilModelImplToJson(_$CoilModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'coilNumber': instance.coilNumber,
      'productType': instance.productType,
      'weight': instance.weight,
      'width': instance.width,
      'thickness': instance.thickness,
      'grade': instance.grade,
      'status': instance.status,
      'createdAt': instance.createdAt.toIso8601String(),
      'location': instance.location,
      'remarks': instance.remarks,
    };
