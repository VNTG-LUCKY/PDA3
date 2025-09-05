# Flutter 프로젝트 구조 및 모델 정의

## 프로젝트 폴더 구조 (현재 PDA3 기준)

```
lib/
├── main.dart
├── core/
│   ├── config/
│   │   ├── env.dart                # 환경 설정
│   │   ├── api_config.dart         # API 엔드포인트 설정
│   │   └── app_config.dart         # 앱 전역 설정
│   ├── router/
│   │   ├── app_router.dart         # GoRouter 설정 (기존)
│   │   └── route_names.dart        # 라우트 이름 상수
│   ├── constants/
│   │   ├── api_constants.dart      # API 엔드포인트 상수
│   │   ├── app_constants.dart      # 앱 상수
│   │   └── work_codes.dart         # PDA 작업 코드 상수
│   ├── services/
│   │   ├── storage_service.dart    # 로컬 저장소 서비스
│   │   ├── session_service.dart    # 세션 관리 서비스
│   │   ├── barcode_service.dart    # 바코드 스캔 서비스
│   │   ├── gps_service.dart        # GPS 위치 서비스
│   │   └── printer_service.dart    # 프린터 연동 서비스
│   ├── theme/
│   │   ├── app_theme.dart          # 앱 테마
│   │   ├── app_colors.dart         # 색상 정의
│   │   └── text_styles.dart        # 텍스트 스타일
│   └── utils/
│       ├── logger.dart             # 로깅 유틸리티
│       ├── validators.dart         # 입력 검증
│       └── extensions.dart         # 확장 메서드
├── data/
│   ├── models/
│   │   ├── auth/
│   │   │   ├── user_model.dart         # 사용자 모델 (기존)
│   │   │   ├── session_model.dart      # 세션 데이터 모델
│   │   │   └── login_request_model.dart # 로그인 요청 모델
│   │   ├── shipment/
│   │   │   ├── export_shipment_model.dart    # 수출상차 모델
│   │   │   ├── domestic_shipment_model.dart  # 내수상차 모델
│   │   │   ├── stock_view_model.dart         # 재고조회 모델
│   │   │   └── shipment_progress_model.dart  # 상차진행현황 모델
│   │   ├── coil/
│   │   │   ├── coil_model.dart         # 코일 모델 (기존)
│   │   │   ├── coil_input_model.dart   # 코일 입고 모델
│   │   │   └── coil_position_model.dart # 코일 위치 모델
│   │   ├── location/
│   │   │   ├── location_model.dart         # 위치 모델
│   │   │   ├── location_history_model.dart # 위치 이력 모델
│   │   │   └── gps_coordinate_model.dart   # GPS 좌표 모델
│   │   ├── common/
│   │   │   ├── ajax_response_model.dart    # AJAX 응답 모델
│   │   │   ├── company_info_model.dart     # 회사 정보 모델
│   │   │   ├── pagination_model.dart      # 페이지네이션 모델
│   │   │   └── base_response_model.dart    # 기본 응답 모델
│   │   └── board/
│   │       ├── notice_model.dart           # 알림 모델
│   │       └── board_model.dart            # 게시판 모델
│   ├── services/
│   │   ├── api_service.dart            # HTTP 클라이언트 (기존)
│   │   ├── pda_api_service.dart        # PDA API 서비스 (기존 확장)
│   │   ├── auth_service.dart           # 인증 서비스
│   │   ├── shipment_service.dart       # 출하관리 서비스
│   │   ├── coil_service.dart           # 코일관리 서비스
│   │   └── location_service.dart       # 위치관리 서비스
│   └── providers/
│       ├── auth_provider.dart          # 인증 상태 관리
│       ├── session_provider.dart       # 세션 상태 관리
│       ├── company_provider.dart       # 회사 정보 상태 관리
│       └── connectivity_provider.dart  # 네트워크 연결 상태
├── presentation/
│   ├── screens/
│   │   ├── auth/
│   │   │   ├── login_screen.dart           # 로그인 화면
│   │   │   └── splash_screen.dart          # 스플래시 화면
│   │   ├── main/
│   │   │   ├── home_screen.dart            # 홈 화면 (기존)
│   │   │   ├── dashboard_screen.dart       # 대시보드 화면
│   │   │   └── notice_screen.dart          # 알림 화면
│   │   ├── shipment/
│   │   │   ├── shipment_screen.dart        # 출하관리 화면 (기존)
│   │   │   ├── shipment_menu_screen.dart   # 출하관리 메뉴
│   │   │   ├── export_shipment_screen.dart # 수출상차 화면
│   │   │   ├── domestic_shipment_screen.dart # 내수상차 화면
│   │   │   ├── stock_view_screen.dart      # 재고조회 화면
│   │   │   └── shipment_progress_screen.dart # 상차진행현황 화면
│   │   ├── coil/
│   │   │   ├── coil_screen.dart            # 코일 화면 (기존)
│   │   │   ├── coil_menu_screen.dart       # 코일관리 메뉴
│   │   │   ├── coil_input_screen.dart      # 코일 입고 화면
│   │   │   └── coil_position_screen.dart   # 코일 위치변경 화면
│   │   ├── location/
│   │   │   ├── location_screen.dart        # 위치 화면 (기존)
│   │   │   ├── location_menu_screen.dart   # 위치관리 메뉴
│   │   │   ├── location_inquiry_screen.dart # 적재대조회 화면
│   │   │   ├── location_register_screen.dart # 적재위치등록 화면
│   │   │   └── location_history_screen.dart # 적재위치조회 화면
│   │   └── board/
│   │       ├── board_list_screen.dart      # 게시판 목록 화면
│   │       └── board_detail_screen.dart    # 게시판 상세 화면
│   ├── view_models/
│   │   ├── auth_view_model.dart        # 인증 뷰모델
│   │   ├── coil_view_model.dart        # 코일 뷰모델 (기존)
│   │   ├── location_view_model.dart    # 위치 뷰모델 (기존)
│   │   ├── shipment_view_model.dart    # 출하 뷰모델 (기존)
│   │   ├── export_shipment_view_model.dart  # 수출상차 뷰모델
│   │   ├── domestic_shipment_view_model.dart # 내수상차 뷰모델
│   │   ├── stock_view_model.dart       # 재고조회 뷰모델
│   │   ├── notice_view_model.dart      # 알림 뷰모델
│   │   └── main_view_model.dart        # 메인 뷰모델
│   └── widgets/
│       ├── common/
│       │   ├── custom_app_bar.dart     # 커스텀 앱바 (기존)
│       │   ├── custom_button.dart      # 커스텀 버튼 (기존)
│       │   ├── loading_indicator.dart  # 로딩 인디케이터 (기존)
│       │   ├── error_widget.dart       # 에러 위젯
│       │   ├── empty_state_widget.dart # 빈 상태 위젯
│       │   └── confirmation_dialog.dart # 확인 다이얼로그
│       ├── forms/
│       │   ├── custom_text_field.dart  # 커스텀 텍스트 필드
│       │   ├── custom_dropdown.dart    # 커스텀 드롭다운
│       │   ├── date_picker_field.dart  # 날짜 선택 필드
│       │   └── barcode_input_field.dart # 바코드 입력 필드
│       ├── cards/
│       │   ├── menu_card.dart          # 메뉴 카드
│       │   ├── shipment_card.dart      # 출하 카드
│       │   ├── coil_card.dart          # 코일 카드
│       │   └── location_card.dart      # 위치 카드
│       └── dialogs/
│           ├── barcode_scanner_dialog.dart # 바코드 스캔 다이얼로그
│           ├── gps_picker_dialog.dart      # GPS 좌표 선택 다이얼로그
│           └── quantity_input_dialog.dart  # 수량 입력 다이얼로그
└── utils/
    ├── constants.dart                  # 상수 (기존)
    ├── formatters.dart                 # 포맷터 (기존)
    ├── validators.dart                 # 검증 함수
    ├── date_utils.dart                 # 날짜 유틸리티
    └── company_utils.dart              # 회사별 설정 유틸리티
```

## 핵심 모델 정의 (Freezed + JSON Annotation 사용)

### 1. 인증 및 사용자 모델

#### 사용자 모델 (확장)
```dart
// data/models/auth/user_model.dart (기존 파일 확장)
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
```

#### 세션 데이터 모델
```dart
// data/models/auth/session_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'user_model.dart';

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
```

#### 로그인 요청 모델
```dart
// data/models/auth/login_request_model.dart
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
```

### 2. 출하관리 모델

#### 수출상차 모델
```dart
// data/models/shipment/export_shipment_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'export_shipment_model.freezed.dart';
part 'export_shipment_model.g.dart';

@freezed
class ExportShipmentModel with _$ExportShipmentModel {
  const factory ExportShipmentModel({
    String? workCode,
    String? sendNo,          // 선적번호
    String? carNo,           // 차량번호  
    String? carType,         // 차종 (T: 24톤, M: 25톤, G: 18톤 등)
    String? serviceCust,     // 대행업체
    String? dest,            // 도착지
    String? date,            // 상차일자
    String? position,        // 적재위치
    String? barcode,         // 바코드
    String? bon,             // 총본수
    String? isyard,          // 야적장/일반 구분 (Y/N)
    String? isFull,          // 정번들/짜투리 구분 (Y/N)
    String? printOpt,        // 출력위치
    String? carInfo,         // 차량정보
    String? cnt,             // 카운트
    String? scanCnt,         // 스캔횟수
    String? weightSum,       // 중량
    @Default('ExpShipment') String screenId, // 화면 ID
    DateTime? createdAt,     // 생성일시
    DateTime? updatedAt,     // 수정일시
  }) = _ExportShipmentModel;

  factory ExportShipmentModel.fromJson(Map<String, dynamic> json) =>
      _$ExportShipmentModelFromJson(json);
}
```

#### 내수상차 모델
```dart
// data/models/shipment/domestic_shipment_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'domestic_shipment_model.freezed.dart';
part 'domestic_shipment_model.g.dart';

@freezed
class DomesticShipmentModel with _$DomesticShipmentModel {
  const factory DomesticShipmentModel({
    String? workCode,
    String? sendNo,          // 지시번호
    String? date,            // 상차일자
    String? carNo,           // 차량번호
    String? carType,         // 차종
    String? position,        // 적재위치
    String? barcode,         // 바코드
    String? batchNo,         // 배치번호
    String? qty,             // 수량
    String? cnt,             // 카운트
    String? scanCnt,         // 스캔횟수
    String? isFull,          // 정번들/짜투리 구분
    @Default('NdmShipment') String screenId, // 화면 ID
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _DomesticShipmentModel;

  factory DomesticShipmentModel.fromJson(Map<String, dynamic> json) =>
      _$DomesticShipmentModelFromJson(json);
}
```

#### 재고조회 모델
```dart
// data/models/shipment/stock_view_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'stock_view_model.freezed.dart';
part 'stock_view_model.g.dart';

@freezed
class StockViewModel with _$StockViewModel {
  const factory StockViewModel({
    String? coNo,           // 주문번호
    String? coSeq,          // 주문행번
    String? bundleQty,      // 번들수
    String? qty,            // 수량
    String? storageLocation, // 저장위치
    String? materialCode,   // 자재번호
    String? batchNo,        // 배치번호
    String? bundlePerQty,   // 번들당본수
    String? stockQty,       // 재고수량
    @Default(false) bool isSelected, // 선택여부
    String? itemSpec,       // 제품규격
    DateTime? lastUpdated,  // 마지막 업데이트
  }) = _StockViewModel;

  factory StockViewModel.fromJson(Map<String, dynamic> json) =>
      _$StockViewModelFromJson(json);
}
```

#### 상차진행현황 모델
```dart
// data/models/shipment/shipment_progress_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'shipment_progress_model.freezed.dart';
part 'shipment_progress_model.g.dart';

@freezed
class ShipmentProgressModel with _$ShipmentProgressModel {
  const factory ShipmentProgressModel({
    required String id,
    required String sendNo,      // 지시번호
    required String carNo,       // 차량번호
    required String status,      // 상태 (대기, 진행중, 완료)
    String? customerName,        // 고객명
    String? destination,         // 목적지
    int? totalQty,              // 전체 수량
    int? processedQty,          // 처리된 수량
    double? progress,           // 진행률 (0.0 ~ 1.0)
    DateTime? scheduledDate,    // 예정일
    DateTime? startedAt,        // 시작시간
    DateTime? completedAt,      // 완료시간
    String? remarks,            // 비고
  }) = _ShipmentProgressModel;

  factory ShipmentProgressModel.fromJson(Map<String, dynamic> json) =>
      _$ShipmentProgressModelFromJson(json);
}
```

### 3. 원자재관리 모델

#### 코일 입고 모델 (기존 확장)
```dart
// data/models/coil/coil_input_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'coil_input_model.freezed.dart';
part 'coil_input_model.g.dart';

@freezed
class CoilInputModel with _$CoilInputModel {
  const factory CoilInputModel({
    String? workCode,
    String? barcode,        // 바코드
    String? workGubun,      // 작업구분 (P0: 포스코, H0: 현대제철, D0: 동부제강, DK: 동국제강, J0: JFE)
    String? size,           // 규격
    String? weight,         // 중량
    String? heat,           // HEAT
    String? inputDate,      // 입고일자
    String? warehouse,      // 입고창고
    String? position,       // 적재위치
    String? od,             // OD
    @Default('CoilInput') String screenId, // 화면 ID
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _CoilInputModel;

  factory CoilInputModel.fromJson(Map<String, dynamic> json) =>
      _$CoilInputModelFromJson(json);
}
```

#### 코일 위치 모델
```dart
// data/models/coil/coil_position_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'coil_position_model.freezed.dart';
part 'coil_position_model.g.dart';

@freezed
class CoilPositionModel with _$CoilPositionModel {
  const factory CoilPositionModel({
    required String coilId,     // 코일 ID
    String? currentWarehouse,   // 현재 창고
    String? targetWarehouse,    // 이동할 창고
    String? currentPosition,    // 현재 위치
    String? targetPosition,     // 이동할 위치
    String? reason,            // 이동 사유
    String? status,            // 상태 (대기, 진행중, 완료)
    DateTime? moveDate,        // 이동 일자
    String? userId,            // 작업자 ID
    String? remarks,           // 비고
  }) = _CoilPositionModel;

  factory CoilPositionModel.fromJson(Map<String, dynamic> json) =>
      _$CoilPositionModelFromJson(json);
}
```

### 4. 적재위치관리 모델

#### 위치 모델
```dart
// data/models/location/location_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_model.freezed.dart';
part 'location_model.g.dart';

@freezed
class LocationModel with _$LocationModel {
  const factory LocationModel({
    String? workCode,
    String? locationId,      // 위치 ID
    String? gubun,           // 적재대구분
    String? locationCode,    // 적재대번호
    String? no,              // 정렬순서
    String? lat,             // 위도
    String? longi,           // 경도
    String? registerDate,    // 등록일
    String? description,     // 설명
    @Default(true) bool isActive, // 활성 상태
  }) = _LocationModel;

  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);
}
```

#### GPS 좌표 모델
```dart
// data/models/location/gps_coordinate_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'gps_coordinate_model.freezed.dart';
part 'gps_coordinate_model.g.dart';

@freezed
class GpsCoordinateModel with _$GpsCoordinateModel {
  const factory GpsCoordinateModel({
    required double latitude,   // 위도
    required double longitude,  // 경도
    double? accuracy,          // 정확도
    double? altitude,          // 고도
    DateTime? timestamp,       // 측정 시간
    String? address,           // 주소 (역지오코딩)
  }) = _GpsCoordinateModel;

  factory GpsCoordinateModel.fromJson(Map<String, dynamic> json) =>
      _$GpsCoordinateModelFromJson(json);
}
```

#### 위치 이력 모델
```dart
// data/models/location/location_history_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_history_model.freezed.dart';
part 'location_history_model.g.dart';

@freezed
class LocationHistoryModel with _$LocationHistoryModel {
  const factory LocationHistoryModel({
    required String id,
    required String locationId,    // 위치 ID
    required String action,        // 액션 (생성, 수정, 삭제, 이동)
    String? previousValue,         // 이전 값
    String? newValue,             // 새 값
    String? userId,               // 작업자 ID
    String? userGubun,            // 작업자 구분
    DateTime? actionDate,         // 작업 일시
    String? remarks,              // 비고
  }) = _LocationHistoryModel;

  factory LocationHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$LocationHistoryModelFromJson(json);
}
```

### 5. 공통 모델

#### AJAX 응답 모델
```dart
// data/models/common/ajax_response_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ajax_response_model.freezed.dart';
part 'ajax_response_model.g.dart';

@Freezed(genericArgumentFactories: true)
class AjaxResponseModel<T> with _$AjaxResponseModel<T> {
  const factory AjaxResponseModel({
    @Default(false) bool success,
    String? message,
    T? data,
    String? workCode,
    String? alert,
    int? statusCode,
    DateTime? timestamp,
  }) = _AjaxResponseModel<T>;

  factory AjaxResponseModel.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$AjaxResponseModelFromJson(json, fromJsonT);
}
```

#### 기본 응답 모델
```dart
// data/models/common/base_response_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_response_model.freezed.dart';
part 'base_response_model.g.dart';

@freezed
class BaseResponseModel with _$BaseResponseModel {
  const factory BaseResponseModel({
    @Default(false) bool success,
    String? message,
    String? errorCode,
    int? statusCode,
    DateTime? timestamp,
  }) = _BaseResponseModel;

  factory BaseResponseModel.fromJson(Map<String, dynamic> json) =>
      _$BaseResponseModelFromJson(json);
}
```

#### 회사 정보 모델
```dart
// data/models/common/company_info_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_info_model.freezed.dart';
part 'company_info_model.g.dart';

@freezed
class CompanyInfoModel with _$CompanyInfoModel {
  const factory CompanyInfoModel({
    required String code,
    required String name,
    required List<WarehouseOptionModel> warehouses,
    required List<LocationCategoryModel> locationCategories,
  }) = _CompanyInfoModel;

  factory CompanyInfoModel.fromJson(Map<String, dynamic> json) =>
      _$CompanyInfoModelFromJson(json);
      
  factory CompanyInfoModel.fromCompanyCode(String code) {
    switch (code) {
      case '1000':
        return const CompanyInfoModel(
          code: '1000',
          name: '포항공장',
          warehouses: [
            WarehouseOptionModel(code: '1100', name: '1공장'),
            WarehouseOptionModel(code: '1200', name: '2공장'),
            WarehouseOptionModel(code: '1300', name: '3공장'),
            WarehouseOptionModel(code: '1400', name: '4공장'),
            WarehouseOptionModel(code: '1600', name: '6공장'),
            WarehouseOptionModel(code: '1700', name: '7공장'),
            WarehouseOptionModel(code: '1900', name: 'JCOE'),
            WarehouseOptionModel(code: '1500', name: '문덕공장'),
          ],
          locationCategories: [
            LocationCategoryModel(name: '1공장'),
            LocationCategoryModel(name: '2공장'),
            LocationCategoryModel(name: '3공장'),
            LocationCategoryModel(name: 'A동,B동'),
            LocationCategoryModel(name: '7공장'),
            LocationCategoryModel(name: '야적장(JCOE)'),
            LocationCategoryModel(name: '야적장(7P뒤, 산)'),
            LocationCategoryModel(name: '문덕공장'),
            LocationCategoryModel(name: 'S/P공장'),
          ],
        );
      case '2000':
        return const CompanyInfoModel(
          code: '2000',
          name: '군산공장',
          warehouses: [
            WarehouseOptionModel(code: '1100', name: '원재료(군산P)'),
            WarehouseOptionModel(code: '1200', name: '원재료(군산부두)'),
            WarehouseOptionModel(code: '1300', name: '원재료(외주조관)'),
          ],
          locationCategories: [
            LocationCategoryModel(name: '원재료'),
            LocationCategoryModel(name: '소경공장(SP)'),
            LocationCategoryModel(name: '중경공장(MP)'),
            LocationCategoryModel(name: '도금공장'),
            LocationCategoryModel(name: '신창고(NW)'),
          ],
        );
      case '3000':
        return const CompanyInfoModel(
          code: '3000',
          name: '창원공장',
          warehouses: [
            WarehouseOptionModel(code: '1100', name: '원재료(창원1P)'),
            WarehouseOptionModel(code: '1200', name: '원재료(창원2P)'),
          ],
          locationCategories: [
            LocationCategoryModel(name: '물류창고(옥내)'),
            LocationCategoryModel(name: 'A-LINE'),
            LocationCategoryModel(name: 'B-LINE'),
            LocationCategoryModel(name: 'C-LINE'),
            LocationCategoryModel(name: '팩킹야적장A'),
            LocationCategoryModel(name: '팩킹야적장B'),
            LocationCategoryModel(name: '옥내창고(옥내)'),
            LocationCategoryModel(name: '장척팩킹장(옥내)'),
          ],
        );
      case '4000':
        return const CompanyInfoModel(
          code: '4000',
          name: '순천공장',
          warehouses: [
            WarehouseOptionModel(code: '1300', name: 'P/B-C'),
            WarehouseOptionModel(code: '1400', name: 'P/B-S'),
            WarehouseOptionModel(code: '1500', name: 'R/B-C'),
            WarehouseOptionModel(code: '1600', name: 'R/B-S'),
            WarehouseOptionModel(code: '1700', name: 'S/P'),
          ],
          locationCategories: [
            LocationCategoryModel(name: '1공장'),
            LocationCategoryModel(name: '1공장(7Bay)'),
            LocationCategoryModel(name: '2공장(동쪽)'),
            LocationCategoryModel(name: '2공장(서쪽)'),
            LocationCategoryModel(name: '2공장(남동쪽)'),
            LocationCategoryModel(name: '2공장(남쪽)'),
            LocationCategoryModel(name: '2공장(S1)'),
            LocationCategoryModel(name: '2공장(S3)'),
          ],
        );
      default:
        return const CompanyInfoModel(
          code: '',
          name: '알수없음',
          warehouses: [],
          locationCategories: [],
        );
    }
  }
}

@freezed
class WarehouseOptionModel with _$WarehouseOptionModel {
  const factory WarehouseOptionModel({
    required String code,
    required String name,
  }) = _WarehouseOptionModel;

  factory WarehouseOptionModel.fromJson(Map<String, dynamic> json) =>
      _$WarehouseOptionModelFromJson(json);
}

@freezed
class LocationCategoryModel with _$LocationCategoryModel {
  const factory LocationCategoryModel({
    required String name,
  }) = _LocationCategoryModel;

  factory LocationCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$LocationCategoryModelFromJson(json);
}
```

#### 페이지네이션 모델
```dart
// data/models/common/pagination_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pagination_model.freezed.dart';
part 'pagination_model.g.dart';

@freezed
class PaginationModel with _$PaginationModel {
  const factory PaginationModel({
    @Default(1) int currentPage,
    @Default(20) int pageSize,
    @Default(0) int totalCount,
    @Default(0) int totalPages,
    @Default(false) bool hasNext,
    @Default(false) bool hasPrevious,
  }) = _PaginationModel;

  factory PaginationModel.fromJson(Map<String, dynamic> json) =>
      _$PaginationModelFromJson(json);
}
```

### 6. 열거형 정의

```dart
// core/constants/enums.dart
enum CompanyType {
  pohang('1000', '포항공장'),
  gunsan('2000', '군산공장'),
  changwon('3000', '창원공장'),
  suncheon('4000', '순천공장');

  const CompanyType(this.code, this.name);
  final String code;
  final String name;
}

enum WorkGubun {
  posco('P0', '포스코'),
  hyundai('H0', '현대제철'),
  dongbu('D0', '동부제강'),
  dongkook('DK', '동국제강'),
  jfe('J0', 'JFE');

  const WorkGubun(this.code, this.name);
  final String code;
  final String name;
}

enum CarType {
  t24('T', '24톤'),
  m25('M', '25톤'),
  g18('G', '18톤'),
  a15('A', '15톤'),
  c11('C', '11톤'),
  i10('I', '10톤'),
  f8('F', '8톤'),
  d5('D', '5톤'),
  b25('B', '2.5톤');

  const CarType(this.code, this.description);
  final String code;
  final String description;
}

enum DeviceType {
  mobile('M', '모바일'),
  web('W', '웹');

  const DeviceType(this.code, this.name);
  final String code;
  final String name;
}
```

### 7. API 상수 정의

```dart
// core/constants/api_constants.dart
class ApiConstants {
  // Base URLs
  static const String baseUrl = 'https://your-api-base-url.com';
  
  // Auth endpoints
  static const String login = '/pdaLoginRedirect.do';
  static const String logout = '/pdaLogout';
  static const String memberLogin = '/memberLoginChk';
  
  // Main endpoints
  static const String index = '/index';
  static const String notice = '/pdaNotice';
  static const String moveDate = '/moveDate';
  static const String schRead4Ajax = '/schRead4Ajax';
  
  // Shipment endpoints
  static const String shipmentMenu = '/ShipmentMenu';
  static const String ndmShipment = '/NdmShipment';
  static const String ndmShipmentAjax = '/NdmShipmentAjaxProc';
  static const String expShipment = '/ExpShipment';
  static const String expShipmentAjax = '/ExpShipmentAjaxProc';
  static const String expShipmentProg = '/ExpShipmentProg';
  static const String expShipmentProgAjax = '/ExpShipmentProgAjaxProc';
  static const String stockView = '/StockView';
  static const String stockViewAjax = '/StockViewAjaxProc';
  static const String procHistInquiry = '/ProcHistInquiry';
  static const String procHistInquiryAjax = '/ProcHistInquiryAjaxProc';
  static const String plantTrans = '/PlantTrans';
  static const String plantTransAjax = '/PlantTransAjaxProc';
  
  // Coil endpoints
  static const String coilMenu = '/CoilMenu';
  static const String coilInput = '/CoilInput';
  static const String coilInputAjax = '/CoilInputAjaxProc';
  static const String coilPositionChange = '/CoilPositionChange';
  static const String coilPositionChangeAjax = '/CoilPositionChangeAjaxProc';
  static const String coilPositionChange2 = '/CoilPositionChange2';
  static const String coilPositionChange2Ajax = '/CoilPositionChange2AjaxProc';
  static const String coilPositionChangePo = '/CoilPositionChangePo';
  static const String coilPositionChangePoAjax = '/CoilPositionChangePoAjaxProc';
  
  // Location endpoints
  static const String locationMenu = '/LocationMenu';
  static const String location = '/Location';
  static const String locationAjax = '/LocationAjaxProc';
  static const String locationInput = '/LocationInput';
  static const String locationInputAjax = '/LocationInputAjaxProc';
  static const String locationHistory = '/LocationHistory';
  static const String locationHistoryAjax = '/LocationHistoryAjaxProc';
  static const String locationInputCoil = '/LocationInputCoil';
  static const String locationInputCoilAjax = '/LocationInputCoilAjaxProc';
  static const String locationHistoryCoil = '/LocationHistoryCoil';
  static const String locationHistoryCoilAjax = '/LocationHistoryCoilAjaxProc';
  
  // Board endpoints
  static const String boardList = '/boardList';
  static const String boardRead = '/boardRead';
  static const String noticeAjax = '/NoticeAjaxProc';
}
```

### 8. 작업 코드 정의

```dart
// core/constants/work_codes.dart
class WorkCodes {
  // 공통 작업 코드
  static const String btnViewClick = 'btnVIEW_Click';
  static const String btnSaveClick = 'btnSave_Click';
  static const String btnDeleteClick = 'btnDelete_Click';
  static const String btnModifyClick = 'btnModify_Click';
  static const String btnInputClick = 'btnINPUT_Click';
  static const String btnRegisterClick = 'btnRegister_Click';
  
  // 출하관리 작업 코드
  static const String expGetSendInfo = 'ExpGetSendInfo';
  static const String expBarcodeInput = 'ExpBarcodeInput';
  static const String btnBatchSearchView = 'btnBATCH_SEARCH_VIEW_Click';
  static const String btnUserInput = 'btnUserInput';
  static const String formStockViewUserSearch = 'Form_STOCK_VIEW_USER_search';
  static const String formStockViewUserBtnSelect = 'Form_STOCK_VIEW_USER_btnSelect_Click';
  static const String formStockViewUserBtnModifyQty = 'Form_STOCK_VIEW_USER_btnModifyQty_Click';
  static const String formStockViewUserBtnConfirm = 'Form_STOCK_VIEW_USER_btnConfirm_Click';
  
  // 코일관리 작업 코드
  static const String coilGetSendInfo = 'CoilGetSendInfo';
  static const String saveData = 'SaveData';
  
  // 위치관리 작업 코드
  static const String formModifySave = 'Form_MODIFY_SAVE';
  
  // 알림 작업 코드
  static const String noticeRead = 'NoticeRead';
}
```

### 9. Riverpod 프로바이더 설정

#### PDA API 서비스 확장 (기존 파일 수정)
```dart
// data/services/pda_api_service.dart (기존 파일 확장)
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/auth/user_model.dart';
import '../models/auth/session_model.dart';
import '../models/auth/login_request_model.dart';
import '../models/shipment/export_shipment_model.dart';
import '../models/shipment/domestic_shipment_model.dart';
import '../models/shipment/stock_view_model.dart';
import '../models/coil/coil_input_model.dart';
import '../models/location/location_model.dart';
import '../models/common/ajax_response_model.dart';
import '../../core/constants/api_constants.dart';
import '../../core/constants/work_codes.dart';
import 'api_service.dart';

class PdaApiService {
  final ApiService _apiService;

  PdaApiService(this._apiService);

  // 인증 관련 API
  Future<SessionModel> login(LoginRequestModel request) async {
    final response = await _apiService.post<Map<String, dynamic>>(
      ApiConstants.login,
      data: request.toJson(),
    );
    return SessionModel.fromJson(response.data!);
  }

  Future<void> logout() async {
    await _apiService.get(ApiConstants.logout);
  }

  // 출하관리 API
  Future<AjaxResponseModel<ExportShipmentModel>> getExportShipmentInfo({
    required String workCode,
    required String sendNo,
    required String carNo,
    String? position,
  }) async {
    final response = await _apiService.get<Map<String, dynamic>>(
      ApiConstants.expShipmentAjax,
      queryParameters: {
        'workCode': workCode,
        'sendNo': sendNo,
        'carNo': carNo,
        if (position != null) 'position': position,
      },
    );
    
    return AjaxResponseModel.fromJson(
      response.data!,
      (json) => ExportShipmentModel.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<AjaxResponseModel<ExportShipmentModel>> saveExportShipment(
    ExportShipmentModel shipment,
  ) async {
    final data = shipment.copyWith(workCode: WorkCodes.btnSaveClick).toJson();
    
    final response = await _apiService.get<Map<String, dynamic>>(
      ApiConstants.expShipmentAjax,
      queryParameters: data,
    );
    
    return AjaxResponseModel.fromJson(
      response.data!,
      (json) => ExportShipmentModel.fromJson(json as Map<String, dynamic>),
    );
  }

  // 코일 관리 API
  Future<AjaxResponseModel<CoilInputModel>> getCoilInfo({
    required String barcode,
    required String workGubun,
  }) async {
    final response = await _apiService.get<Map<String, dynamic>>(
      ApiConstants.coilInputAjax,
      queryParameters: {
        'workCode': WorkCodes.coilGetSendInfo,
        'barcode': barcode,
        'workGubun': workGubun,
      },
    );
    
    return AjaxResponseModel.fromJson(
      response.data!,
      (json) => CoilInputModel.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<AjaxResponseModel<CoilInputModel>> saveCoilInput(
    CoilInputModel coil,
  ) async {
    final data = coil.copyWith(workCode: WorkCodes.saveData).toJson();
    
    final response = await _apiService.get<Map<String, dynamic>>(
      ApiConstants.coilInputAjax,
      queryParameters: data,
    );
    
    return AjaxResponseModel.fromJson(
      response.data!,
      (json) => CoilInputModel.fromJson(json as Map<String, dynamic>),
    );
  }

  // 위치 관리 API
  Future<AjaxResponseModel<List<LocationModel>>> getLocations({
    String? gubun,
    String? locationcode,
  }) async {
    final response = await _apiService.get<Map<String, dynamic>>(
      ApiConstants.locationAjax,
      queryParameters: {
        'workCode': WorkCodes.btnViewClick,
        if (gubun != null) 'gubun': gubun,
        if (locationcode != null) 'locationcode': locationcode,
      },
    );
    
    return AjaxResponseModel.fromJson(
      response.data!,
      (json) => (json as List)
          .map((item) => LocationModel.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  // 바코드 스캔 처리
  Future<AjaxResponseModel<dynamic>> processBarcodeInput({
    required String screenId,
    required String barcode,
    String? position,
    Map<String, dynamic>? additionalData,
  }) async {
    final Map<String, dynamic> requestData = {
      'workCode': WorkCodes.btnInputClick,
      'barcode': barcode,
      if (position != null) 'position': position,
      ...?additionalData,
    };

    String endpoint;
    switch (screenId) {
      case 'ExpShipment':
        endpoint = ApiConstants.expShipmentAjax;
        break;
      case 'NdmShipment':
        endpoint = ApiConstants.ndmShipmentAjax;
        break;
      case 'CoilInput':
        endpoint = ApiConstants.coilInputAjax;
        break;
      default:
        throw ArgumentError('Unsupported screen ID: $screenId');
    }

    final response = await _apiService.get<Map<String, dynamic>>(
      endpoint,
      queryParameters: requestData,
    );
    
    return AjaxResponseModel.fromJson(
      response.data!,
      (json) => json,
    );
  }
}

// Riverpod 프로바이더
final pdaApiServiceProvider = Provider<PdaApiService>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return PdaApiService(apiService);
});
```

#### 상태 관리 프로바이더들
```dart
// data/providers/auth_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/auth/session_model.dart';
import '../models/auth/user_model.dart';
import '../services/pda_api_service.dart';
import '../../core/services/storage_service.dart';

final authStateProvider = StateNotifierProvider<AuthNotifier, AsyncValue<SessionModel?>>((ref) {
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
      state = AsyncValue.data(sessionData);
    } catch (e) {
      state = AsyncValue.data(null);
    }
  }

  Future<void> login(String userId, String password) async {
    state = const AsyncValue.loading();
    try {
      final apiService = _ref.read(pdaApiServiceProvider);
      final session = await apiService.login(
        LoginRequestModel(
          userId: userId,
          userPassword: password,
          fromDevice: 'M',
        ),
      );
      
      final storageService = _ref.read(storageServiceProvider);
      await storageService.saveSession(session);
      
      state = AsyncValue.data(session);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
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
      state = AsyncValue.error(e, StackTrace.current);
    }
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
```

## 프로젝트 설정 가이드

### 필요한 의존성 추가 (pubspec.yaml)

```yaml
dependencies:
  # 상태 관리
  flutter_riverpod: ^2.4.9
  
  # 네트워킹
  dio: ^5.3.2
  
  # 라우팅 (기존)
  go_router: ^12.1.3
  
  # 데이터 모델 (기존)
  freezed_annotation: ^2.4.1
  json_annotation: ^4.8.1
  
  # 로컬 저장소
  shared_preferences: ^2.2.2
  
  # 바코드 스캔
  mobile_scanner: ^4.0.1
  
  # GPS
  geolocator: ^10.1.0
  
  # 기타 유틸리티
  intl: ^0.19.0

dev_dependencies:
  # 코드 생성 (기존)
  build_runner: ^2.4.7
  freezed: ^2.4.6
  json_serializable: ^6.7.1
```

이 구조는 현재 PDA3 프로젝트의 기존 아키텍처(Riverpod + Freezed + GoRouter)를 확장하여 백엔드 API 문서의 모든 요구사항을 만족시킵니다. 기존 파일들과 호환되면서도 새로운 PDA 기능들을 체계적으로 추가할 수 있도록 설계되었습니다.
