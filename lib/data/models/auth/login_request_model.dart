import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_request_model.freezed.dart';
part 'login_request_model.g.dart';

@freezed
class LoginRequestModel with _$LoginRequestModel {
  const factory LoginRequestModel({
    required String userId,
    required String userPassword,
    String? uuid,               // 기기 UUID
    @Default('M') String fromDevice, // M: 모바일, W: 웹
    @Default(false) bool remember,   // 로그인 정보 저장 여부
  }) = _LoginRequestModel;

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestModelFromJson(json);
}
