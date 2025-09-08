import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/auth/session_model.dart';
import '../models/user_model.dart';
import '../services/pda_api_service.dart';
import '../../core/services/storage_service.dart';

final authStateProvider =
    StateNotifierProvider<AuthNotifier, AsyncValue<SessionModel?>>((ref) {
  return AuthNotifier(ref);
});

class AuthNotifier extends StateNotifier<AsyncValue<SessionModel?>> {
  final Ref _ref;

  AuthNotifier(this._ref) : super(const AsyncValue.loading()) {
    _loadStoredSession();
  }

  Future<void> _loadStoredSession() async {
    try {
      final storageService = _ref.read(storageServiceProvider);
      final sessionData = await storageService.getSession();

      // 세션 유효성 검사
      if (sessionData != null) {
        final isValid = await storageService.isSessionValid();
        if (isValid) {
          // 마지막 접근 시간 업데이트
          await storageService.updateLastAccess();
          state = AsyncValue.data(sessionData);
        } else {
          // 유효하지 않은 세션 삭제
          await storageService.clearSession();
          state = const AsyncValue.data(null);
        }
      } else {
        state = const AsyncValue.data(null);
      }
    } catch (e) {
      state = const AsyncValue.data(null);
    }
  }

  Future<void> login(String userId, String password) async {
    state = const AsyncValue.loading();
    try {
      final apiService = _ref.read(pdaApiServiceProvider);
      final session = await apiService.login(
        userId,
        password,
      );

      final storageService = _ref.read(storageServiceProvider);
      await storageService.saveSession(session);

      state = AsyncValue.data(session);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      throw e;
    }
  }

  Future<void> logout() async {
    try {
      final apiService = _ref.read(pdaApiServiceProvider);
      await apiService.logout();

      final storageService = _ref.read(storageServiceProvider);
      await storageService.clearSession();

      state = const AsyncValue.data(null);
    } catch (e) {
      // 로그아웃 에러가 발생해도 로컬 세션은 삭제
      final storageService = _ref.read(storageServiceProvider);
      await storageService.clearSession();
      state = const AsyncValue.data(null);
    }
  }

  Future<void> refreshSession() async {
    final currentSession = await getCurrentSession();
    if (currentSession == null) return;

    try {
      // 여기서 리프레시 토큰을 사용한 토큰 갱신 로직 구현
      // 현재는 단순히 마지막 접근 시간만 업데이트
      final storageService = _ref.read(storageServiceProvider);
      await storageService.updateLastAccess();

      final updatedSession = currentSession.copyWith(
        lastAccess: DateTime.now(),
      );

      await storageService.saveSession(updatedSession);
      state = AsyncValue.data(updatedSession);
    } catch (e) {
      // 리프레시 실패 시 로그아웃 처리
      await logout();
    }
  }

  Future<SessionModel?> getCurrentSession() async {
    final storageService = _ref.read(storageServiceProvider);
    return await storageService.getSession();
  }

  Future<bool> isAuthenticated() async {
    final storageService = _ref.read(storageServiceProvider);
    return await storageService.isSessionValid();
  }

  Future<String> _generateDeviceUuid() async {
    // 실제 구현에서는 device_info_plus 등을 사용하여 기기 고유 ID 생성
    // 현재는 간단한 타임스탬프 기반 UUID 사용
    return 'mobile_${DateTime.now().millisecondsSinceEpoch}';
  }
}

// 현재 사용자 정보 프로바이더
final currentUserProvider = Provider<UserModel?>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.whenOrNull(data: (session) => session?.user);
});

// 현재 회사 정보 프로바이더
final currentCompanyProvider = Provider<String?>((ref) {
  final user = ref.watch(currentUserProvider);
  return user?.company;
});

// 로그인 상태 프로바이더
final isLoggedInProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.whenOrNull(data: (session) => session != null) ?? false;
});

// 로딩 상태 프로바이더
final isAuthLoadingProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.isLoading;
});
