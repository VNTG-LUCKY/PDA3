import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/auth/session_model.dart';

class StorageService {
  static const String _sessionKey = 'pda_session';
  static const String _tokenKey = 'pda_access_token';
  static const String _refreshTokenKey = 'pda_refresh_token';
  static const String _userKey = 'pda_user';

  /// 세션 정보 저장
  Future<void> saveSession(SessionModel session) async {
    final prefs = await SharedPreferences.getInstance();
    
    // 세션 전체 저장
    await prefs.setString(_sessionKey, jsonEncode(session.toJson()));
    
    // 개별 토큰 정보도 저장 (빠른 접근용)
    if (session.accessToken != null) {
      await prefs.setString(_tokenKey, session.accessToken!);
    }
    if (session.refreshToken != null) {
      await prefs.setString(_refreshTokenKey, session.refreshToken!);
    }
    
    // 사용자 정보 저장
    await prefs.setString(_userKey, jsonEncode(session.user.toJson()));
  }

  /// 세션 정보 조회
  Future<SessionModel?> getSession() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final sessionJson = prefs.getString(_sessionKey);
      
      if (sessionJson == null) return null;
      
      final sessionData = jsonDecode(sessionJson) as Map<String, dynamic>;
      return SessionModel.fromJson(sessionData);
    } catch (e) {
      // 세션 데이터가 손상된 경우 null 반환
      return null;
    }
  }

  /// 액세스 토큰 조회 (빠른 접근)
  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  /// 리프레시 토큰 조회
  Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_refreshTokenKey);
  }

  /// 세션 유효성 검사
  Future<bool> isSessionValid() async {
    try {
      final session = await getSession();
      if (session == null) return false;
      
      // 세션이 유효한지 확인
      if (!session.isValid) return false;
      
      // 만료 시간 확인
      if (session.expiresAt != null) {
        final now = DateTime.now();
        if (now.isAfter(session.expiresAt!)) {
          return false;
        }
      }
      
      return true;
    } catch (e) {
      return false;
    }
  }

  /// 세션 정보 업데이트 (토큰 갱신 등)
  Future<void> updateSession(SessionModel session) async {
    await saveSession(session);
  }

  /// 토큰만 업데이트
  Future<void> updateTokens({
    String? accessToken,
    String? refreshToken,
    DateTime? expiresAt,
  }) async {
    final currentSession = await getSession();
    if (currentSession == null) return;
    
    final updatedSession = currentSession.copyWith(
      accessToken: accessToken ?? currentSession.accessToken,
      refreshToken: refreshToken ?? currentSession.refreshToken,
      expiresAt: expiresAt ?? currentSession.expiresAt,
    );
    
    await saveSession(updatedSession);
  }

  /// 마지막 접근 시간 업데이트
  Future<void> updateLastAccess() async {
    final currentSession = await getSession();
    if (currentSession == null) return;
    
    final updatedSession = currentSession.copyWith(
      lastAccess: DateTime.now(),
    );
    
    await saveSession(updatedSession);
  }

  /// 세션 및 모든 인증 정보 삭제
  Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    
    await Future.wait([
      prefs.remove(_sessionKey),
      prefs.remove(_tokenKey),
      prefs.remove(_refreshTokenKey),
      prefs.remove(_userKey),
    ]);
  }

  /// 모든 저장된 데이터 삭제 (앱 초기화용)
  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  /// 디버그용: 저장된 모든 키 조회
  Future<Set<String>> getAllKeys() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getKeys();
  }
}

// Riverpod 프로바이더
final storageServiceProvider = Provider<StorageService>((ref) {
  return StorageService();
});
