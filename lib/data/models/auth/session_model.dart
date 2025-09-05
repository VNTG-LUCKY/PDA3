import 'package:freezed_annotation/freezed_annotation.dart';
import '../user_model.dart';

part 'session_model.freezed.dart';
part 'session_model.g.dart';

@freezed
class SessionModel with _$SessionModel {
  const factory SessionModel({
    required UserModel user,
    String? sessionId,
    String? accessToken,
    String? refreshToken,
    DateTime? expiresAt,
    DateTime? lastAccess,
    @Default(false) bool isValid,
  }) = _SessionModel;

  factory SessionModel.fromJson(Map<String, dynamic> json) =>
      _$SessionModelFromJson(json);
}
