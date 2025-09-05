# PDA3 프로젝트 - Flutter 개발 가이드

## 📋 프로젝트 소개

PDA3는 코일, 위치, 출하를 통합 관리하는 Flutter 모바일 애플리케이션입니다.

### 🎯 주요 기능
- **코일 관리**: 제품 코일의 생성, 조회, 수정, 삭제
- **위치 관리**: 창고 및 생산 위치 관리
- **출하 관리**: 제품 출하 계획 및 실행 관리

### 🏗️ 기술 스택
- **Framework**: Flutter 3.7+
- **상태 관리**: Riverpod
- **라우팅**: GoRouter
- **네트워킹**: Dio
- **데이터 모델**: Freezed + JSON Annotation
- **코드 생성**: Build Runner

---

## 🚀 개발 환경 설정

### 1️⃣ Flutter SDK 설치

#### Windows 사용자

1. **Flutter SDK 다운로드**
   ```
   https://docs.flutter.dev/get-started/install/windows
   ```

2. **ZIP 파일 압축 해제**
   - `C:\src\flutter` 폴더에 압축 해제 (경로에 공백이 없어야 함)

3. **환경 변수 설정**
   - 시스템 환경 변수에서 `Path`에 `C:\src\flutter\bin` 추가

4. **Flutter Doctor 실행**
   ```bash
   flutter doctor
   ```

#### macOS 사용자

1. **Flutter SDK 다운로드**
   ```bash
   cd ~/development
   unzip ~/Downloads/flutter_macos_3.x.x-stable.zip
   ```

2. **PATH 설정**
   ```bash
   export PATH="$PATH:`pwd`/flutter/bin"
   ```

3. **Flutter Doctor 실행**
   ```bash
   flutter doctor
   ```

### 2️⃣ 개발 도구 설치

#### Android Studio 설치
1. [Android Studio](https://developer.android.com/studio) 다운로드 및 설치
2. Android SDK 설치
3. Android 에뮬레이터 설정

#### Cursor IDE 설치 (필수)
1. [Cursor IDE](https://cursor.sh/) 다운로드 및 설치
2. 필수 확장 프로그램 설치:
   - **Flutter**: Flutter 개발 지원
   - **Dart**: Dart 언어 지원

### 3️⃣ Flutter Doctor 확인

설치가 완료되면 다음 명령어로 환경을 확인하세요:

```bash
flutter doctor
```

모든 항목이 ✅ 체크되어야 합니다.

---

## 📦 프로젝트 설정

### 1️⃣ 프로젝트 클론
- 이 코드는 선택한 폴더(현재 디렉토리)에 모든 코드를 복사(clone)합니다.
- 코드를 복사할 위치의 경로에서 명령어를 실행하세요.

```bash
git clone https://github.com/VNTG-LUCKY/PDA3.git .
```

### 2️⃣ 의존성 설치

```bash
flutter pub get
```

### 3️⃣ 코드 생성

Freezed 모델과 JSON 직렬화 코드를 생성합니다:

```bash
flutter packages pub run build_runner build
```

### 4️⃣ 환경 설정 확인

프로젝트 루트에 다음 파일들이 있는지 확인하세요:
- `.env.dev` - 개발 환경 설정
- `.env.prod` - 운영 환경 설정

---

## 🏃‍♂️ 앱 실행

### 개발 환경에서 실행

```bash
flutter run --dart-define=ENV=dev
```

### 운영 환경에서 실행

```bash
flutter run --dart-define=ENV=prod
```

### Cursor IDE에서 실행

1. `F5` 키를 누르거나 디버그 메뉴에서 실행
2. 환경 선택:
   - **Run (DEV)**: 개발 환경
   - **Run (PROD)**: 운영 환경

---

## 📁 프로젝트 구조

* 상세한 프로젝트 구조는 `Flutter_프로젝트_구조_및_모델_정의` md 파일을 참고해주시기 바랍니다.

---

## 🛠️ 개발 가이드

### 새로운 화면 추가하기

1. **화면 파일 생성**
   ```dart
   // lib/presentation/screens/new_feature/new_screen.dart
   class NewScreen extends ConsumerWidget {
     const NewScreen({super.key});
     
     @override
     Widget build(BuildContext context, WidgetRef ref) {
       return Scaffold(
         appBar: ManagementAppBar(
           title: '새 기능',
           onRefresh: () => {}, // 새로고침 로직
         ),
         body: const Center(
           child: Text('새 화면'),
         ),
       );
     }
   }
   ```

2. **라우트 추가**
   ```dart
   // lib/core/router/app_router.dart
   GoRoute(
     path: '/new-feature',
     name: 'new-feature',
     builder: (context, state) => const NewScreen(),
   ),
   ```

### 새로운 모델 추가하기

1. **모델 클래스 생성**
   ```dart
   // lib/data/models/new_model.dart
   @freezed
   class NewModel with _$NewModel {
     const factory NewModel({
       required String id,
       required String name,
     }) = _NewModel;
     
     factory NewModel.fromJson(Map<String, dynamic> json) =>
         _$NewModelFromJson(json);
   }
   ```

2. **코드 생성**
   ```bash
   flutter packages pub run build_runner build
   ```

### 새로운 API 서비스 추가하기

```dart
// lib/data/services/new_api_service.dart
class NewApiService {
  final ApiService _apiService;
  
  NewApiService(this._apiService);
  
  Future<List<NewModel>> getNewData() async {
    final response = await _apiService.get<Map<String, dynamic>>('/new-data');
    final List<dynamic> data = response.data?['data'] ?? [];
    return data.map((json) => NewModel.fromJson(json)).toList();
  }
}
```

---

## 🧪 테스트 실행

### 단위 테스트

```bash
flutter test
```

### 통합 테스트

```bash
flutter test integration_test/
```

---

## 📱 빌드 및 배포

### Android APK 빌드

```bash
flutter build apk --dart-define=ENV=prod
```

### iOS IPA 빌드

```bash
flutter build ios --dart-define=ENV=prod
```

### Android App Bundle 빌드 (Play Store 배포용)

```bash
flutter build appbundle --dart-define=ENV=prod
```

---

## 🔧 트러블슈팅

### 자주 발생하는 문제들

#### 1. Flutter Doctor 체크 실패
```bash
# Android toolchain 문제
flutter doctor --android-licenses

# iOS 문제 (macOS만)
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
```

#### 2. 의존성 충돌
```bash
flutter clean
flutter pub get
```

#### 3. 코드 생성 오류
```bash
flutter packages pub run build_runner clean
flutter packages pub run build_runner build --delete-conflicting-outputs
```

#### 4. 에뮬레이터 연결 문제
```bash
# 연결된 기기 확인
flutter devices

# 에뮬레이터 시작
flutter emulators --launch "<emulator_id>"
```

### 성능 최적화

1. **빌드 시간 단축**
   ```bash
   # 병렬 빌드 활성화
   flutter config --enable-web
   ```

2. **핫 리로드 최적화**
   - 불필요한 import 제거
   - const 생성자 사용
   - 위젯 분리

---

## 📚 학습 자료

### Flutter 공식 문서
- [Flutter 공식 사이트](https://flutter.dev/)
- [Dart 언어 가이드](https://dart.dev/guides)

### 사용된 패키지 문서
- [Riverpod](https://riverpod.dev/)
- [GoRouter](https://pub.dev/packages/go_router)
- [Dio](https://pub.dev/packages/dio)
- [Freezed](https://pub.dev/packages/freezed)

### 유용한 리소스
- [Flutter 한국 커뮤니티](https://flutter-ko.dev/)
- [Flutter 공식 YouTube](https://www.youtube.com/c/flutterdev)

---

## 🤝 기여하기

### 개발 워크플로우

1. **이슈 생성**: 새 기능이나 버그 리포트
2. **브랜치 생성**: `feature/기능명` 또는 `fix/버그명`
3. **개발**: 코딩 스타일 가이드 준수
4. **테스트**: 단위 테스트 및 통합 테스트
5. **PR 생성**: 상세한 설명과 함께 풀 리퀘스트

### 코딩 스타일

- **Dart 공식 스타일 가이드** 준수
- **린터 규칙** 준수 (`analysis_options.yaml`)
- **주석**: 복잡한 로직에 한국어 주석 추가

---

## 📞 지원

### 문제 해결이 필요하다면:

1. **FAQ**: 이 문서의 트러블슈팅 섹션 확인
2. **이슈 등록**: GitHub Issues에 문제 등록
3. **팀 문의**: 개발팀에 직접 문의

---

## 📄 라이선스

이 프로젝트는 [MIT 라이선스](LICENSE) 하에 배포됩니다.

---

**Happy Coding! 🚀**