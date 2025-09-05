import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String company,        // 회사 코드 (1000, 2000, 3000, 4000)
    required String companyName,    // 회사명 (포항공장, 군산공장, 창원공장, 순천공장)
    required String fromDevice,     // 기기 타입 (M: 모바일, W: 웹)
    required int notiCount,         // 알림 개수
    required String factory,        // 공장 정보
    required String userId,         // 사용자 ID
    String? username,               // 사용자명
    String? email,                  // 이메일
    String? role,                   // 권한
    DateTime? lastLoginAt,          // 마지막 로그인 시간
    @Default(true) bool isActive,   // 활성 상태
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
