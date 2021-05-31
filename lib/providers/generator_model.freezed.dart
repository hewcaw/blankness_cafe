// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'generator_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GeneratorAndSliderData _$GeneratorAndSliderDataFromJson(
    Map<String, dynamic> json) {
  return _GeneratorAndSliderData.fromJson(json);
}

/// @nodoc
class _$GeneratorAndSliderDataTearOff {
  const _$GeneratorAndSliderDataTearOff();

  _GeneratorAndSliderData call(
      {required String name, required List<GeneratorSliderValue> slidersData}) {
    return _GeneratorAndSliderData(
      name: name,
      slidersData: slidersData,
    );
  }

  GeneratorAndSliderData fromJson(Map<String, Object> json) {
    return GeneratorAndSliderData.fromJson(json);
  }
}

/// @nodoc
const $GeneratorAndSliderData = _$GeneratorAndSliderDataTearOff();

/// @nodoc
mixin _$GeneratorAndSliderData {
  String get name => throw _privateConstructorUsedError;
  List<GeneratorSliderValue> get slidersData =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GeneratorAndSliderDataCopyWith<GeneratorAndSliderData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GeneratorAndSliderDataCopyWith<$Res> {
  factory $GeneratorAndSliderDataCopyWith(GeneratorAndSliderData value,
          $Res Function(GeneratorAndSliderData) then) =
      _$GeneratorAndSliderDataCopyWithImpl<$Res>;
  $Res call({String name, List<GeneratorSliderValue> slidersData});
}

/// @nodoc
class _$GeneratorAndSliderDataCopyWithImpl<$Res>
    implements $GeneratorAndSliderDataCopyWith<$Res> {
  _$GeneratorAndSliderDataCopyWithImpl(this._value, this._then);

  final GeneratorAndSliderData _value;
  // ignore: unused_field
  final $Res Function(GeneratorAndSliderData) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? slidersData = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      slidersData: slidersData == freezed
          ? _value.slidersData
          : slidersData // ignore: cast_nullable_to_non_nullable
              as List<GeneratorSliderValue>,
    ));
  }
}

/// @nodoc
abstract class _$GeneratorAndSliderDataCopyWith<$Res>
    implements $GeneratorAndSliderDataCopyWith<$Res> {
  factory _$GeneratorAndSliderDataCopyWith(_GeneratorAndSliderData value,
          $Res Function(_GeneratorAndSliderData) then) =
      __$GeneratorAndSliderDataCopyWithImpl<$Res>;
  @override
  $Res call({String name, List<GeneratorSliderValue> slidersData});
}

/// @nodoc
class __$GeneratorAndSliderDataCopyWithImpl<$Res>
    extends _$GeneratorAndSliderDataCopyWithImpl<$Res>
    implements _$GeneratorAndSliderDataCopyWith<$Res> {
  __$GeneratorAndSliderDataCopyWithImpl(_GeneratorAndSliderData _value,
      $Res Function(_GeneratorAndSliderData) _then)
      : super(_value, (v) => _then(v as _GeneratorAndSliderData));

  @override
  _GeneratorAndSliderData get _value => super._value as _GeneratorAndSliderData;

  @override
  $Res call({
    Object? name = freezed,
    Object? slidersData = freezed,
  }) {
    return _then(_GeneratorAndSliderData(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      slidersData: slidersData == freezed
          ? _value.slidersData
          : slidersData // ignore: cast_nullable_to_non_nullable
              as List<GeneratorSliderValue>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GeneratorAndSliderData implements _GeneratorAndSliderData {
  const _$_GeneratorAndSliderData(
      {required this.name, required this.slidersData});

  factory _$_GeneratorAndSliderData.fromJson(Map<String, dynamic> json) =>
      _$_$_GeneratorAndSliderDataFromJson(json);

  @override
  final String name;
  @override
  final List<GeneratorSliderValue> slidersData;

  @override
  String toString() {
    return 'GeneratorAndSliderData(name: $name, slidersData: $slidersData)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _GeneratorAndSliderData &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.slidersData, slidersData) ||
                const DeepCollectionEquality()
                    .equals(other.slidersData, slidersData)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(slidersData);

  @JsonKey(ignore: true)
  @override
  _$GeneratorAndSliderDataCopyWith<_GeneratorAndSliderData> get copyWith =>
      __$GeneratorAndSliderDataCopyWithImpl<_GeneratorAndSliderData>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_GeneratorAndSliderDataToJson(this);
  }
}

abstract class _GeneratorAndSliderData implements GeneratorAndSliderData {
  const factory _GeneratorAndSliderData(
          {required String name,
          required List<GeneratorSliderValue> slidersData}) =
      _$_GeneratorAndSliderData;

  factory _GeneratorAndSliderData.fromJson(Map<String, dynamic> json) =
      _$_GeneratorAndSliderData.fromJson;

  @override
  String get name => throw _privateConstructorUsedError;
  @override
  List<GeneratorSliderValue> get slidersData =>
      throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$GeneratorAndSliderDataCopyWith<_GeneratorAndSliderData> get copyWith =>
      throw _privateConstructorUsedError;
}
