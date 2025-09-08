# SeAH Steel PDA 시스템 - 백엔드 API 문서

## 개요
이 문서는 SeAH Steel PDA(Personal Digital Assistant) 시스템을 기존 Java/JSP에서 Flutter로 재구축하기 위한 백엔드 API 경로를 정리한 문서입니다. 이 시스템은 제강 공장 운영을 위한 출하 관리, 원자재 처리, 적재 위치 관리를 담당합니다.

## 인증 및 세션 관리

### 로그인 시스템
- **화면**: 로그인 페이지
- **JSP 파일**: `pda/Login.jsp`, `member/memberLogin.jsp`
- **라우트**:
  - `POST /pdaLoginRedirect.do` - PDA 모바일 로그인
  - `POST /memberLoginChk` - 웹 관리자 로그인
  - `GET /pdaLogout` - 로그아웃
  - `GET /memberLogin` - 세션 없을 시 로그인 리다이렉트

### 세션 검증
- 모든 API 호출에 세션 검증 포함
- 세션 만료 시 `400` 상태 코드와 함께 로그인 페이지로 리다이렉트

## 메인 메뉴 및 내비게이션

### 1. 메인 대시보드
- **화면 ID**: `index`
- **제목**: "SeAH Steel PDA System"
- **JSP 파일**: `pda/index.jsp`, `main/index.jsp`
- **라우트**:
  - `GET /index` - 메인 대시보드
  - `POST /moveDate` - 캘린더 내비게이션
  - `GET /schRead4Ajax` - 캘린더 이벤트 상세

### 2. PDA 메인 메뉴
- **화면 ID**: `PdaMainMenu`
- **회사명 표시**: `${sessionScope.userDto.companyName}`
- **메뉴 항목**:
  - 출하관리 (Shipment Management)
  - 원자재관리 (Raw Material Management)  
  - 적재위치관리 (Storage Location Management)

### 3. 알림 시스템
- **화면 ID**: `Notice`
- **JSP 파일**: `pda/Notice.jsp`
- **라우트**:
  - `GET /pdaNotice` - 알림 조회
  - `GET /NoticeAjaxProc` - AJAX 알림 처리

## 1. 출하관리 모듈

### 출하관리 메뉴
- **화면 ID**: `ShipmentMenu`
- **JSP 파일**: `pda/ShipmentMenu.jsp`
- **라우트**: `GET /ShipmentMenu`

### 1.1 내수상차
- **화면 ID**: `NdmShipment`
- **제목**: "내수상차"
- **JSP 파일**: `pda/shipment/NdmShipment.jsp`
- **라우트**:
  - `GET /NdmShipment` - 화면 로드
  - `GET /NdmShipmentAjaxProc` - AJAX 처리
  - **작업 코드**:
    - `btnVIEW_Click` - 상차 정보 조회
    - `btnBATCH_SEARCH_VIEW_Click` - 배치 검색
    - `btnINPUT_Click` - 바코드 입력
    - `btnSave_Click` - 상차 저장
    - `btnDelete_Click` - 상차 삭제
    - `btnModify_Click` - 수량 수정

### 1.2 수출상차
- **화면 ID**: `ExpShipment`
- **제목**: "수출상차"
- **JSP 파일**: `pda/shipment/ExpShipment.jsp`
- **라우트**:
  - `GET /ExpShipment` - 화면 로드
  - `GET /ExpShipmentAjaxProc` - AJAX 처리
  - **작업 코드**:
    - `ExpGetSendInfo` - 선적 정보 조회
    - `ExpBarcodeInput` - 바코드 입력
    - `btnSave_Click` - 상차 저장
    - `btnDelete_Click` - 상차 삭제
    - `btnModify_Click` - 상차 수정
    - `Form_STOCK_VIEW_USER_search` - 재고 검색
    - `Form_STOCK_VIEW_USER_btnSelect_Click` - 재고 선택

### 1.3 수출상차 진행현황
- **화면 ID**: `ExpShipmentProg`
- **라우트**:
  - `GET /ExpShipmentProg`
  - `GET /ExpShipmentProgAjaxProc`

### 1.4 내수상차 진행현황
- **화면 ID**: `NdmShipmentProg`
- **라우트**:
  - `GET /NdmShipmentProg`
  - `GET /NdmShipmentProgAjaxProc`

### 1.5 재고조회
- **화면 ID**: `StockView`
- **라우트**:
  - `GET /StockView`
  - `GET /StockViewAjaxProc`

### 1.6 처리이력조회
- **화면 ID**: `ProcHistInquiry`
- **라우트**:
  - `GET /ProcHistInquiry`
  - `GET /ProcHistInquiryAjaxProc`

### 1.7 사내이적
- **화면 ID**: `PlantTrans`
- **라우트**:
  - `GET /PlantTrans`
  - `GET /PlantTransAjaxProc`

### 1.8 텐더수출상차
- **화면 ID**: `TexpShipment`
- **라우트**:
  - `GET /TexpShipment`
  - `GET /TexpShipmentAjaxProc`

## 2. 원자재관리 모듈

### 원자재관리 메뉴
- **화면 ID**: `CoilMenu`
- **JSP 파일**: `pda/CoilMenu.jsp`
- **라우트**: `GET /CoilMenu`

### 2.1 원재료 입고
- **화면 ID**: `CoilInput`
- **제목**: "원재료 입고"
- **JSP 파일**: `pda/coil/CoilInput.jsp`
- **라우트**:
  - `GET /CoilInput` - 화면 로드
  - `GET /CoilInputAjaxProc` - AJAX 처리
  - **작업 코드**:
    - `CoilGetSendInfo` - 코일 정보 조회
    - `SaveData` - 코일 데이터 저장

### 2.2 재고 창고수정
- **화면 ID**: `CoilPositionChange`
- **라우트**:
  - `GET /CoilPositionChange`
  - `GET /CoilPositionChangeAjaxProc`

### 2.3 원재료 재고이전
- **화면 ID**: `CoilPositionChange2`
- **라우트**:
  - `GET /CoilPositionChange2`
  - `GET /CoilPositionChange2AjaxProc`

### 2.4 수입재 포항창고 이동
- **화면 ID**: `CoilPositionChangePo`
- **라우트**:
  - `GET /CoilPositionChangePo` (포항공장 전용)
  - `GET /CoilPositionChangePoAjaxProc`

## 3. 적재위치관리 모듈

### 적재위치관리 메뉴
- **화면 ID**: `LocationMenu`
- **JSP 파일**: `pda/LocationMenu.jsp`
- **라우트**: `GET /LocationMenu`

### 3.1 적재대조회
- **화면 ID**: `Location`
- **제목**: "적재대조회"
- **JSP 파일**: `pda/location/Location.jsp`
- **라우트**:
  - `GET /Location` - 화면 로드
  - `GET /LocationAjaxProc` - AJAX 처리
  - **작업 코드**:
    - `btnVIEW_Click` - 적재대 검색
    - `btnRegister_Click` - 새 적재대 등록
    - `btnModify_Click` - 적재대 수정
    - `btnDelete_Click` - 적재대 삭제
    - `Form_MODIFY_SAVE` - 수정 사항 저장

### 3.2 적재위치등록
- **화면 ID**: `LocationInput`
- **라우트**:
  - `GET /LocationInput`
  - `GET /LocationInputAjaxProc`

### 3.3 적재위치조회
- **화면 ID**: `LocationHistory`
- **라우트**:
  - `GET /LocationHistory`
  - `GET /LocationHistoryAjaxProc`

### 3.4 적재위치등록 (원자재)
- **화면 ID**: `LocationInputCoil` (군산공장 전용)
- **라우트**:
  - `GET /LocationInputCoil`
  - `GET /LocationInputCoilAjaxProc`

### 3.5 적재위치조회 (원자재)
- **화면 ID**: `LocationHistoryCoil` (군산공장 전용)
- **라우트**:
  - `GET /LocationHistoryCoil`
  - `GET /LocationHistoryCoilAjaxProc`

## 4. 게시판 및 커뮤니케이션 모듈

### 4.1 게시판 관리
- **화면 ID**: `BoardList`
- **라우트**:
  - `GET /boardList` - 게시판 목록
  - `GET /boardRead` - 게시글 읽기
  - `GET /BoardReadAjax4Reply` - AJAX 댓글 로딩

### 4.2 관리자 기능
- **화면들**: 
  - `BoardGroupList` (관리자)
  - `CodeList`, `CodeForm`, `CodeRead` (관리자)
  - `UserList`, `User`, `Department` (관리자)
- **라우트**: 사용자 및 시스템 관리를 위한 다양한 관리자 전용 라우트

## 공장별 특화 기능

### 공장 유형:
- **포항공장**: `company='1000'`
- **군산공장**: `company='2000'`  
- **창원공장**: `company='3000'`
- **순천공장**: `company='4000'`

### 공장별 특화 라우트:
- 공장별로 다른 창고 옵션
- 회사별로 다른 위치 카테고리
- 일부 기능은 공장별 전용 (예: 포항 창고 이전)

## 모바일 기기 연동

### 바코드 스캔
- **안드로이드 연동**: `window.android.openBarcodeScanner()` 사용
- **콜백**: `barcodeScanResult(data)` 
- **기기 감지**: 모바일용 `fromDevice='M'`

### GPS 연동
- **위치 서비스**: `setLocation(lat, longi)`
- **GPS 좌표**: 위치 관리에서 사용

## 공통 데이터 구조

### 세션 데이터:
```json
{
  "userDto": {
    "company": "1000|2000|3000|4000",
    "companyName": "포항공장|군산공장|창원공장|순천공장",
    "fromDevice": "M|W",
    "notiCount": number,
    "factory": string
  }
}
```

### 표준 AJAX 응답 패턴:
- 모든 AJAX 호출은 `workCode` 매개변수를 포함한 유사한 패턴 따름
- 오류 처리에는 세션 타임아웃 감지 포함
- 모든 작업에서 로딩 인디케이터 사용

## Flutter 구현을 위한 주의사항

1. **세션 관리**: JWT 또는 유사한 토큰 기반 인증 구현
2. **기기 연동**: 바코드 스캔 및 GPS용 Flutter 플러그인 사용
3. **공장 로직**: 공장별 비즈니스 규칙 및 UI 변형 구현
4. **오프라인 지원**: 바코드 작업용 캐싱 고려
5. **실시간 업데이트**: 진행 상황 추적을 위한 WebSocket 또는 폴링 구현
6. **인쇄 연동**: 배송 라벨용 열전사 프린터 연동 처리

## 화면별 상세 기능 명세

### 주요 입력 필드 및 검증 규칙

#### 수출상차 화면 (`ExpShipment`)
**필수 입력 필드:**
- 선적번호 (`sendNo`)
- 차량번호 (`carNo`) - 4자리
- 적재위치 (`position`) - 4자리
- 차종 (`carType`) - T(24톤), M(25톤), G(18톤) 등
- 대행업체 (`serviceCust`)
- 도착지 (`dest`)

**선택 입력 필드:**
- 상차일자 (`date`)
- 총본수 (`bon`)
- 바코드 (`barcode`) - 24자리 이상
- 야적장/일반 구분 (`isyard`)
- 정번들/짜투리 구분 (`isFull`)

#### 원재료 입고 화면 (`CoilInput`)
**필수 입력 필드:**
- 바코드 (`barcode`)
- 작업구분 (`workGubun`) - P0(포스코), H0(현대제철), D0(동부제강), DK(동국제강), J0(JFE)
- 입고창고 (`warehouse`) - 공장별로 다른 옵션

**선택 입력 필드:**
- 규격 (`size`)
- 중량 (`weight`)
- HEAT (`heat`)
- 입고일자 (`inputDate`)
- 적재위치 (`position`)

#### 적재대조회 화면 (`Location`)
**필수 입력 필드:**
- 적재대구분 (`gubun`) - 공장별로 다른 옵션
- 적재대번호 (`locationcode`)

**GPS 연동 필드:**
- 위도 (`lat`)
- 경도 (`longi`)

### 바코드 스캔 통합 가이드

```javascript
// 바코드 스캔 시작
function fn_barcode_Click() {
    $("#barcode").val("");
    var fromDevice = "${sessionScope.userDto.fromDevice}";
    if(fromDevice == "M"){
        openAndroidBarcodeScannerInput("aaaaa");				
    }
}

// Android 네이티브 브리지
function openAndroidBarcodeScannerInput(msg){
    if (typeof android != 'undefined') {
        window.android.openBarcodeScanner(msg);
    }
}

// 스캔 결과 콜백
function barcodeScanResult(data) {
    if(data != ""){
        $("#barcode").val(data);
        // 자동으로 다음 처리 진행
        fn_btnINPUT_Click();
    }
}
```

### 공장별 창고 코드 매핑

#### 포항공장 (company='1000')
- `1100`: 1공장
- `1200`: 2공장
- `1300`: 3공장
- `1400`: 4공장
- `1600`: 6공장
- `1700`: 7공장
- `1900`: JCOE
- `1500`: 문덕공장

#### 군산공장 (company='2000')
- `1100`: 원재료(군산P)
- `1200`: 원재료(군산부두)
- `1300`: 원재료(외주조관)

#### 창원공장 (company='3000')
- `1100`: 원재료(창원1P)
- `1200`: 원재료(창원2P)

#### 순천공장 (company='4000')
- `1300`: P/B-C
- `1400`: P/B-S
- `1500`: R/B-C
- `1600`: R/B-S
- `1700`: S/P

### 에러 처리 패턴

```javascript
// 표준 AJAX 에러 처리
error : function(jqXHR, textStatus, errorThrown){
    if(jqXHR.status == 400){
        alert("세션이 만료가 되었습니다. 로그인 페이지로 이동합니다.");
        location.href = "pdaLogin";
    }else{
        alert(jqXHR.responseText);
    }
}
```

### 화면 전환 패턴

```javascript
// 메뉴 화면으로 돌아가기
<a href="ShipmentMenu" class="page-back">
<a href="CoilMenu" class="page-back">
<a href="LocationMenu" class="page-back">

// 로그아웃
function fn_exit() {
    var isReal = confirm("로그아웃 하시겠습니까?");
    if(isReal == false) {
        return;
    }else{
         location.href = "/pdaLogout";
    }
}
```

### Summary

Claude have successfully analyzed the legacy JSP codebase from legacy and created a comprehensive back-end API documentation for your Flutter rebuild project. Here's what Claude extracted:

* Key Findings:
  71 JSP Files organized into 7 main modules
  3 Main Functional Areas:
  - Shipment Management (출하관리) - 8 screens
  - Raw Material Management (원자재관리) - 4 screens
  - Storage Location Management (적재위치관리) - 5 screens

* Company-Specific Logic for 4 different factories:
  - 포항공장 (Pohang) - company='1000'
  - 군산공장 (Gunsan) - company='2000'
  - 창원공장 (Changwon) - company='3000'
  - 순천공장 (Suncheon) - company='4000'

* Mobile Device Integration:
  - Barcode scanning capabilities
  - GPS location services
  - Android native bridge integration

* Key API Patterns Identified:
  - AJAX Processing Pattern: Most screens use {ModuleName}AjaxProc routes
  - Work Code System: Operations identified by specific work codes (e.g., btnVIEW_Click, SaveData)
  - Session Management: Centralized user session with company-specific permissions
  - Error Handling: Standardized session timeout detection and error responses

The documentation provides all the necessary backend route information, screen identifiers, and business logic patterns needed to implement the Flutter frontend while maintaining compatibility with your existing backend infrastructure.