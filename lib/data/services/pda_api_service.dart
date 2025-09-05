import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/coil_model.dart';
import '../models/user_model.dart';
import '../models/auth/session_model.dart';
import '../models/auth/login_request_model.dart';
import 'api_service.dart';

class PdaApiService {
  final ApiService _apiService;

  PdaApiService(this._apiService);

  // Authentication related APIs
  Future<SessionModel> login(LoginRequestModel request) async {
    try {
      final response = await _apiService.post<Map<String, dynamic>>(
        '/pdaLoginRedirect.do',
        data: request.toJson(),
      );

      if (response.data != null) {
        // API 문서에 따라 응답에서 사용자 정보 추출
        final userData = response.data!;
        
        // UserModel 생성
        final user = UserModel.fromJson(userData);
        
        // SessionModel 생성 - 실제 토큰 정보는 서버 응답에 따라 조정 필요
        return SessionModel(
          user: user,
          sessionId: userData['sessionId'] as String?,
          accessToken: userData['accessToken'] as String? ?? 'mock_token_${DateTime.now().millisecondsSinceEpoch}',
          refreshToken: userData['refreshToken'] as String?,
          expiresAt: DateTime.now().add(const Duration(hours: 8)), // 8시간 후 만료
          lastAccess: DateTime.now(),
          isValid: true,
        );
      } else {
        throw Exception('로그인 응답 데이터가 없습니다');
      }
    } catch (e) {
      throw Exception('로그인 실패: ${e.toString()}');
    }
  }

  Future<void> logout() async {
    try {
      await _apiService.get('/pdaLogout');
    } catch (e) {
      // 로그아웃 실패는 무시 (서버에서 이미 세션이 만료되었을 수 있음)
    }
  }

  // Coil related APIs
  Future<List<CoilModel>> getCoils({
    int page = 1,
    int limit = 20,
    String? search,
    String? status,
  }) async {
    final response = await _apiService.get<Map<String, dynamic>>(
      '/coils',
      queryParameters: {
        'page': page,
        'limit': limit,
        if (search != null) 'search': search,
        if (status != null) 'status': status,
      },
    );

    final List<dynamic> coilsData = response.data?['data'] ?? [];
    return coilsData.map((json) => CoilModel.fromJson(json)).toList();
  }

  Future<CoilModel> getCoilById(String id) async {
    final response = await _apiService.get<Map<String, dynamic>>('/coils/$id');
    return CoilModel.fromJson(response.data!);
  }

  Future<CoilModel> createCoil(Map<String, dynamic> coilData) async {
    final response = await _apiService.post<Map<String, dynamic>>(
      '/coils',
      data: coilData,
    );
    return CoilModel.fromJson(response.data!);
  }

  Future<CoilModel> updateCoil(String id, Map<String, dynamic> coilData) async {
    final response = await _apiService.put<Map<String, dynamic>>(
      '/coils/$id',
      data: coilData,
    );
    return CoilModel.fromJson(response.data!);
  }

  Future<void> deleteCoil(String id) async {
    await _apiService.delete('/coils/$id');
  }

  // User related APIs
  Future<UserModel> getCurrentUser() async {
    final response = await _apiService.get<Map<String, dynamic>>('/auth/me');
    return UserModel.fromJson(response.data!);
  }

  // Location related APIs
  Future<List<Map<String, dynamic>>> getLocations() async {
    final response = await _apiService.get<Map<String, dynamic>>('/locations');
    return List<Map<String, dynamic>>.from(response.data?['data'] ?? []);
  }

  // Shipment related APIs
  Future<List<Map<String, dynamic>>> getShipments({
    int page = 1,
    int limit = 20,
    String? status,
  }) async {
    final response = await _apiService.get<Map<String, dynamic>>(
      '/shipments',
      queryParameters: {
        'page': page,
        'limit': limit,
        if (status != null) 'status': status,
      },
    );
    return List<Map<String, dynamic>>.from(response.data?['data'] ?? []);
  }

  Future<Map<String, dynamic>> createShipment(
      Map<String, dynamic> shipmentData) async {
    final response = await _apiService.post<Map<String, dynamic>>(
      '/shipments',
      data: shipmentData,
    );
    return response.data!;
  }
}

final pdaApiServiceProvider = Provider<PdaApiService>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return PdaApiService(apiService);
});
