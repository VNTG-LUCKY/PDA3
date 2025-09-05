// App Constants
class AppConstants {
  // App Information
  static const String appName = 'PDA3 App';
  static const String appVersion = '1.0.0';
  
  // API Constants
  static const int apiTimeoutSeconds = 30;
  static const int apiRetryAttempts = 3;
  static const int itemsPerPage = 20;
  
  // UI Constants
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  static const double defaultBorderRadius = 8.0;
  static const double defaultElevation = 2.0;
  
  // Animation Constants
  static const int defaultAnimationDuration = 300;
  static const int fastAnimationDuration = 150;
  static const int slowAnimationDuration = 500;
  
  // Date Formats
  static const String defaultDateFormat = 'yyyy-MM-dd';
  static const String displayDateFormat = 'yyyy년 MM월 dd일';
  static const String dateTimeFormat = 'yyyy-MM-dd HH:mm:ss';
  static const String displayDateTimeFormat = 'yyyy년 MM월 dd일 HH:mm';
  static const String timeFormat = 'HH:mm';
  
  // Storage Keys
  static const String userTokenKey = 'user_token';
  static const String userDataKey = 'user_data';
  static const String settingsKey = 'app_settings';
  static const String themeKey = 'theme_mode';
  static const String languageKey = 'language_code';
  
  // Routes
  static const String homeRoute = '/';
  static const String loginRoute = '/login';
  static const String coilRoute = '/coil';
  static const String locationRoute = '/location';
  static const String shipmentRoute = '/shipment';
  static const String settingsRoute = '/settings';
  static const String profileRoute = '/profile';
}

// Coil Status Constants
class CoilStatus {
  static const String created = 'created';
  static const String inProduction = 'in_production';
  static const String quality_check = 'quality_check';
  static const String ready = 'ready';
  static const String shipped = 'shipped';
  static const String delivered = 'delivered';
  static const String returned = 'returned';
  static const String scrapped = 'scrapped';
  
  static const List<String> allStatuses = [
    created,
    inProduction,
    quality_check,
    ready,
    shipped,
    delivered,
    returned,
    scrapped,
  ];
  
  static const Map<String, String> statusLabels = {
    created: '생성됨',
    inProduction: '생산중',
    quality_check: '품질검사',
    ready: '출하준비',
    shipped: '출하완료',
    delivered: '배송완료',
    returned: '반품',
    scrapped: '폐기',
  };
}

// Shipment Status Constants
class ShipmentStatus {
  static const String pending = 'pending';
  static const String inProgress = 'in_progress';
  static const String completed = 'completed';
  static const String cancelled = 'cancelled';
  static const String delayed = 'delayed';
  
  static const List<String> allStatuses = [
    pending,
    inProgress,
    completed,
    cancelled,
    delayed,
  ];
  
  static const Map<String, String> statusLabels = {
    pending: '대기중',
    inProgress: '진행중',
    completed: '완료',
    cancelled: '취소됨',
    delayed: '지연됨',
  };
}

// User Roles Constants
class UserRoles {
  static const String admin = 'admin';
  static const String manager = 'manager';
  static const String operator = 'operator';
  static const String viewer = 'viewer';
  
  static const List<String> allRoles = [
    admin,
    manager,
    operator,
    viewer,
  ];
  
  static const Map<String, String> roleLabels = {
    admin: '관리자',
    manager: '매니저',
    operator: '작업자',
    viewer: '조회자',
  };
}

// Location Types Constants
class LocationTypes {
  static const String warehouse = 'warehouse';
  static const String production = 'production';
  static const String quality = 'quality';
  static const String shipping = 'shipping';
  static const String storage = 'storage';
  
  static const List<String> allTypes = [
    warehouse,
    production,
    quality,
    shipping,
    storage,
  ];
  
  static const Map<String, String> typeLabels = {
    warehouse: '창고',
    production: '생산라인',
    quality: '품질관리',
    shipping: '출하장',
    storage: '보관소',
  };
}

// Error Messages
class ErrorMessages {
  static const String networkError = '네트워크 연결을 확인해주세요.';
  static const String serverError = '서버 오류가 발생했습니다.';
  static const String unauthorizedError = '인증이 필요합니다.';
  static const String forbiddenError = '접근 권한이 없습니다.';
  static const String notFoundError = '요청한 데이터를 찾을 수 없습니다.';
  static const String validationError = '입력 데이터를 확인해주세요.';
  static const String unknownError = '알 수 없는 오류가 발생했습니다.';
  
  // Form validation messages
  static const String requiredField = '필수 입력 항목입니다.';
  static const String invalidEmail = '올바른 이메일 주소를 입력해주세요.';
  static const String invalidPhoneNumber = '올바른 전화번호를 입력해주세요.';
  static const String passwordTooShort = '비밀번호는 최소 8자 이상이어야 합니다.';
  static const String passwordMismatch = '비밀번호가 일치하지 않습니다.';
}

// Success Messages
class SuccessMessages {
  static const String saveSuccess = '저장되었습니다.';
  static const String updateSuccess = '수정되었습니다.';
  static const String deleteSuccess = '삭제되었습니다.';
  static const String loginSuccess = '로그인되었습니다.';
  static const String logoutSuccess = '로그아웃되었습니다.';
  static const String uploadSuccess = '업로드가 완료되었습니다.';
  static const String downloadSuccess = '다운로드가 완료되었습니다.';
}

// File and Image Constants
class FileConstants {
  static const List<String> allowedImageExtensions = ['jpg', 'jpeg', 'png', 'gif'];
  static const List<String> allowedDocumentExtensions = ['pdf', 'doc', 'docx', 'xls', 'xlsx'];
  static const int maxFileSize = 10 * 1024 * 1024; // 10MB
  static const int maxImageSize = 5 * 1024 * 1024; // 5MB
}

// Regex Patterns
class RegexPatterns {
  static const String email = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  static const String phoneNumber = r'^[0-9-+\s()]+$';
  static const String koreanPhoneNumber = r'^01[016789]-?\d{3,4}-?\d{4}$';
  static const String numberOnly = r'^[0-9]+$';
  static const String alphanumeric = r'^[a-zA-Z0-9]+$';
  static const String coilNumber = r'^[A-Z0-9]{8,12}$';
}
