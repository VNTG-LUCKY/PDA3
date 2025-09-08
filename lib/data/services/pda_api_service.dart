import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import '../models/coil_model.dart';
import '../models/user_model.dart';
import '../models/auth/session_model.dart';
import '../models/auth/login_request_model.dart';
import 'api_service.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:path_provider/path_provider.dart';
import '../../core/constants/api_constants.dart';

class PdaApiService {
  late Dio _dio;
  late CookieJar _cookieJar;
  PdaApiService() {
    _dio = Dio(BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'}));
    _cookieJar = CookieJar();
    _dio.interceptors.add(CookieManager(_cookieJar));
    _dio.interceptors
        .add(LogInterceptor(responseBody: true, requestBody: true));
  }

  // Authentication related APIs
  Future<SessionModel> login(String userId, String userPassword) async {
    try {
      final response =
          await _dio.post<String>(ApiConstants.login, queryParameters: {
        'userId': userId,
        'userPassword': userPassword,
        'fromDevice': 'M',
        'uuid': "1234567890"
      });

      if (response.statusCode == 200) {
        List<Cookie> cookies =
            await _cookieJar.loadForRequest(Uri.parse(ApiConstants.baseUrl));
        // Check if the JSESSIONID cookie exists after the login call.
        bool sessionCreated =
            cookies.any((cookie) => cookie.name == 'JSESSIONID');

        final String htmlBody = response.data.toString();
        const String successKeyword = '작업환경설정';
        final bool isLoginSuccess = htmlBody.contains(successKeyword);

        if (isLoginSuccess) {
          print(
              "✅ Login Successful: Success keyword ('$successKeyword') found in response body.");
          return SessionModel(
              user: UserModel(
                  id: userId,
                  company: '',
                  companyName: '',
                  notiCount: 0,
                  factory: '',
                  userId: userId,
                  username: '',
                  email: '',
                  role: '',
                  lastLoginAt: DateTime.now(),
                  isActive: true,
                  fromDevice: 'M'),
              sessionId: cookies.first.value,
              accessToken: cookies.first.value,
              refreshToken: cookies.first.value,
              expiresAt:
                  DateTime.now().add(const Duration(hours: 8)), // 8시간 후 만료
              lastAccess: DateTime.now(),
              isValid: true);
        } else {
          print(
              "Login Failed: Server returned 200 OK, but no session cookie was set.");
          // This can happen if credentials are wrong and it just re-renders the login page.
          throw Exception('아이디와 비밀번호를 확인하세요.');
        }
      } else {
        print("Login failed with status: ${response.statusCode}");
        throw Exception('${response.statusCode}');
      }
    } on DioException catch (e) {
      print("Error during login: $e");
      throw Exception('로그인 실패: ${e.toString()}');
    } catch (e) {
      throw Exception('로그인 실패: ${e.toString()}');
    }
  }

  Future<void> logout() async {
    try {
      await _dio.get(ApiConstants.logout);
    } catch (e) {
      // 로그아웃 실패는 무시 (서버에서 이미 세션이 만료되었을 수 있음)
    }
  }

  // Coil related APIs
  Future<List<CoilModel>> getCoils(
      {int page = 1, int limit = 20, String? search, String? status}) async {
    final response =
        await _dio.get<Map<String, dynamic>>('/coils', queryParameters: {
      'page': page,
      'limit': limit,
      if (search != null) 'search': search,
      if (status != null) 'status': status
    });

    final List<dynamic> coilsData = response.data?['data'] ?? [];
    return coilsData.map((json) => CoilModel.fromJson(json)).toList();
  }

  Future<CoilModel> getCoilById(String id) async {
    final response = await _dio.get<Map<String, dynamic>>('/coils/$id');
    return CoilModel.fromJson(response.data!);
  }

  Future<CoilModel> createCoil(Map<String, dynamic> coilData) async {
    final response =
        await _dio.post<Map<String, dynamic>>('/coils', data: coilData);
    return CoilModel.fromJson(response.data!);
  }

  Future<CoilModel> updateCoil(String id, Map<String, dynamic> coilData) async {
    final response =
        await _dio.put<Map<String, dynamic>>('/coils/$id', data: coilData);
    return CoilModel.fromJson(response.data!);
  }

  Future<void> deleteCoil(String id) async {
    await _dio.delete('/coils/$id');
  }

  // User related APIs
  Future<UserModel> getCurrentUser() async {
    final response = await _dio.get<Map<String, dynamic>>('/auth/me');
    return UserModel.fromJson(response.data!);
  }

  // Location related APIs
  Future<List<Map<String, dynamic>>> getLocations() async {
    final response = await _dio.get<Map<String, dynamic>>('/locations');
    return List<Map<String, dynamic>>.from(response.data?['data'] ?? []);
  }

  // Shipment related APIs
  Future<List<Map<String, dynamic>>> getShipments(
      {int page = 1, int limit = 20, String? status}) async {
    final response = await _dio.get<Map<String, dynamic>>('/shipments',
        queryParameters: {
          'page': page,
          'limit': limit,
          if (status != null) 'status': status
        });
    return List<Map<String, dynamic>>.from(response.data?['data'] ?? []);
  }

  Future<Map<String, dynamic>> createShipment(
      Map<String, dynamic> shipmentData) async {
    final response =
        await _dio.post<Map<String, dynamic>>('/shipments', data: shipmentData);
    return response.data!;
  }
}

final pdaApiServiceProvider = Provider<PdaApiService>((ref) {
  return PdaApiService();
});
