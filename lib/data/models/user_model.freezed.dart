// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  String get id => throw _privateConstructorUsedError;
  String get company =>
      throw _privateConstructorUsedError; // 회사 코드 (1000, 2000, 3000, 4000)
  String get companyName =>
      throw _privateConstructorUsedError; // 회사명 (포항공장, 군산공장, 창원공장, 순천공장)
  String get fromDevice =>
      throw _privateConstructorUsedError; // 기기 타입 (M: 모바일, W: 웹)
  int get notiCount => throw _privateConstructorUsedError; // 알림 개수
  String get factory => throw _privateConstructorUsedError; // 공장 정보
  String get userId => throw _privateConstructorUsedError; // 사용자 ID
  String? get username => throw _privateConstructorUsedError; // 사용자명
  String? get email => throw _privateConstructorUsedError; // 이메일
  String? get role => throw _privateConstructorUsedError; // 권한
  DateTime? get lastLoginAt => throw _privateConstructorUsedError; // 마지막 로그인 시간
  bool get isActive => throw _privateConstructorUsedError;

  /// Serializes this UserModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res, UserModel>;
  @useResult
  $Res call(
      {String id,
      String company,
      String companyName,
      String fromDevice,
      int notiCount,
      String factory,
      String userId,
      String? username,
      String? email,
      String? role,
      DateTime? lastLoginAt,
      bool isActive});
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res, $Val extends UserModel>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? company = null,
    Object? companyName = null,
    Object? fromDevice = null,
    Object? notiCount = null,
    Object? factory = null,
    Object? userId = null,
    Object? username = freezed,
    Object? email = freezed,
    Object? role = freezed,
    Object? lastLoginAt = freezed,
    Object? isActive = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      company: null == company
          ? _value.company
          : company // ignore: cast_nullable_to_non_nullable
              as String,
      companyName: null == companyName
          ? _value.companyName
          : companyName // ignore: cast_nullable_to_non_nullable
              as String,
      fromDevice: null == fromDevice
          ? _value.fromDevice
          : fromDevice // ignore: cast_nullable_to_non_nullable
              as String,
      notiCount: null == notiCount
          ? _value.notiCount
          : notiCount // ignore: cast_nullable_to_non_nullable
              as int,
      factory: null == factory
          ? _value.factory
          : factory // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      role: freezed == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String?,
      lastLoginAt: freezed == lastLoginAt
          ? _value.lastLoginAt
          : lastLoginAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserModelImplCopyWith<$Res>
    implements $UserModelCopyWith<$Res> {
  factory _$$UserModelImplCopyWith(
          _$UserModelImpl value, $Res Function(_$UserModelImpl) then) =
      __$$UserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String company,
      String companyName,
      String fromDevice,
      int notiCount,
      String factory,
      String userId,
      String? username,
      String? email,
      String? role,
      DateTime? lastLoginAt,
      bool isActive});
}

/// @nodoc
class __$$UserModelImplCopyWithImpl<$Res>
    extends _$UserModelCopyWithImpl<$Res, _$UserModelImpl>
    implements _$$UserModelImplCopyWith<$Res> {
  __$$UserModelImplCopyWithImpl(
      _$UserModelImpl _value, $Res Function(_$UserModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? company = null,
    Object? companyName = null,
    Object? fromDevice = null,
    Object? notiCount = null,
    Object? factory = null,
    Object? userId = null,
    Object? username = freezed,
    Object? email = freezed,
    Object? role = freezed,
    Object? lastLoginAt = freezed,
    Object? isActive = null,
  }) {
    return _then(_$UserModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      company: null == company
          ? _value.company
          : company // ignore: cast_nullable_to_non_nullable
              as String,
      companyName: null == companyName
          ? _value.companyName
          : companyName // ignore: cast_nullable_to_non_nullable
              as String,
      fromDevice: null == fromDevice
          ? _value.fromDevice
          : fromDevice // ignore: cast_nullable_to_non_nullable
              as String,
      notiCount: null == notiCount
          ? _value.notiCount
          : notiCount // ignore: cast_nullable_to_non_nullable
              as int,
      factory: null == factory
          ? _value.factory
          : factory // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      role: freezed == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String?,
      lastLoginAt: freezed == lastLoginAt
          ? _value.lastLoginAt
          : lastLoginAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserModelImpl implements _UserModel {
  const _$UserModelImpl(
      {required this.id,
      required this.company,
      required this.companyName,
      required this.fromDevice,
      required this.notiCount,
      required this.factory,
      required this.userId,
      this.username,
      this.email,
      this.role,
      this.lastLoginAt,
      this.isActive = true});

  factory _$UserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserModelImplFromJson(json);

  @override
  final String id;
  @override
  final String company;
// 회사 코드 (1000, 2000, 3000, 4000)
  @override
  final String companyName;
// 회사명 (포항공장, 군산공장, 창원공장, 순천공장)
  @override
  final String fromDevice;
// 기기 타입 (M: 모바일, W: 웹)
  @override
  final int notiCount;
// 알림 개수
  @override
  final String factory;
// 공장 정보
  @override
  final String userId;
// 사용자 ID
  @override
  final String? username;
// 사용자명
  @override
  final String? email;
// 이메일
  @override
  final String? role;
// 권한
  @override
  final DateTime? lastLoginAt;
// 마지막 로그인 시간
  @override
  @JsonKey()
  final bool isActive;

  @override
  String toString() {
    return 'UserModel(id: $id, company: $company, companyName: $companyName, fromDevice: $fromDevice, notiCount: $notiCount, factory: $factory, userId: $userId, username: $username, email: $email, role: $role, lastLoginAt: $lastLoginAt, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.company, company) || other.company == company) &&
            (identical(other.companyName, companyName) ||
                other.companyName == companyName) &&
            (identical(other.fromDevice, fromDevice) ||
                other.fromDevice == fromDevice) &&
            (identical(other.notiCount, notiCount) ||
                other.notiCount == notiCount) &&
            (identical(other.factory, factory) || other.factory == factory) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.lastLoginAt, lastLoginAt) ||
                other.lastLoginAt == lastLoginAt) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      company,
      companyName,
      fromDevice,
      notiCount,
      factory,
      userId,
      username,
      email,
      role,
      lastLoginAt,
      isActive);

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      __$$UserModelImplCopyWithImpl<_$UserModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserModelImplToJson(
      this,
    );
  }
}

abstract class _UserModel implements UserModel {
  const factory _UserModel(
      {required final String id,
      required final String company,
      required final String companyName,
      required final String fromDevice,
      required final int notiCount,
      required final String factory,
      required final String userId,
      final String? username,
      final String? email,
      final String? role,
      final DateTime? lastLoginAt,
      final bool isActive}) = _$UserModelImpl;

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$UserModelImpl.fromJson;

  @override
  String get id;
  @override
  String get company; // 회사 코드 (1000, 2000, 3000, 4000)
  @override
  String get companyName; // 회사명 (포항공장, 군산공장, 창원공장, 순천공장)
  @override
  String get fromDevice; // 기기 타입 (M: 모바일, W: 웹)
  @override
  int get notiCount; // 알림 개수
  @override
  String get factory; // 공장 정보
  @override
  String get userId; // 사용자 ID
  @override
  String? get username; // 사용자명
  @override
  String? get email; // 이메일
  @override
  String? get role; // 권한
  @override
  DateTime? get lastLoginAt; // 마지막 로그인 시간
  @override
  bool get isActive;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
