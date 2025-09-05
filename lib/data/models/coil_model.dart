import 'package:freezed_annotation/freezed_annotation.dart';

part 'coil_model.freezed.dart';
part 'coil_model.g.dart';

@freezed
class CoilModel with _$CoilModel {
  const factory CoilModel({
    required String id,
    required String coilNumber,
    required String productType,
    required double weight,
    required double width,
    required double thickness,
    required String grade,
    required String status,
    required DateTime createdAt,
    String? location,
    String? remarks,
  }) = _CoilModel;

  factory CoilModel.fromJson(Map<String, dynamic> json) =>
      _$CoilModelFromJson(json);
}
