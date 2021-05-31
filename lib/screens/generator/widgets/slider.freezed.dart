// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'slider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GeneratorSliderValue _$GeneratorSliderValueFromJson(Map<String, dynamic> json) {
  return _GeneratorSliderValue.fromJson(json);
}

/// @nodoc
class _$GeneratorSliderValueTearOff {
  const _$GeneratorSliderValueTearOff();

  _GeneratorSliderValue call({double volume = 0.35, bool isPlaying = true}) {
    return _GeneratorSliderValue(
      volume: volume,
      isPlaying: isPlaying,
    );
  }

  GeneratorSliderValue fromJson(Map<String, Object> json) {
    return GeneratorSliderValue.fromJson(json);
  }
}

/// @nodoc
const $GeneratorSliderValue = _$GeneratorSliderValueTearOff();

/// @nodoc
mixin _$GeneratorSliderValue {
  double get volume => throw _privateConstructorUsedError;
  bool get isPlaying => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GeneratorSliderValueCopyWith<GeneratorSliderValue> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GeneratorSliderValueCopyWith<$Res> {
  factory $GeneratorSliderValueCopyWith(GeneratorSliderValue value,
          $Res Function(GeneratorSliderValue) then) =
      _$GeneratorSliderValueCopyWithImpl<$Res>;
  $Res call({double volume, bool isPlaying});
}

/// @nodoc
class _$GeneratorSliderValueCopyWithImpl<$Res>
    implements $GeneratorSliderValueCopyWith<$Res> {
  _$GeneratorSliderValueCopyWithImpl(this._value, this._then);

  final GeneratorSliderValue _value;
  // ignore: unused_field
  final $Res Function(GeneratorSliderValue) _then;

  @override
  $Res call({
    Object? volume = freezed,
    Object? isPlaying = freezed,
  }) {
    return _then(_value.copyWith(
      volume: volume == freezed
          ? _value.volume
          : volume // ignore: cast_nullable_to_non_nullable
              as double,
      isPlaying: isPlaying == freezed
          ? _value.isPlaying
          : isPlaying // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$GeneratorSliderValueCopyWith<$Res>
    implements $GeneratorSliderValueCopyWith<$Res> {
  factory _$GeneratorSliderValueCopyWith(_GeneratorSliderValue value,
          $Res Function(_GeneratorSliderValue) then) =
      __$GeneratorSliderValueCopyWithImpl<$Res>;
  @override
  $Res call({double volume, bool isPlaying});
}

/// @nodoc
class __$GeneratorSliderValueCopyWithImpl<$Res>
    extends _$GeneratorSliderValueCopyWithImpl<$Res>
    implements _$GeneratorSliderValueCopyWith<$Res> {
  __$GeneratorSliderValueCopyWithImpl(
      _GeneratorSliderValue _value, $Res Function(_GeneratorSliderValue) _then)
      : super(_value, (v) => _then(v as _GeneratorSliderValue));

  @override
  _GeneratorSliderValue get _value => super._value as _GeneratorSliderValue;

  @override
  $Res call({
    Object? volume = freezed,
    Object? isPlaying = freezed,
  }) {
    return _then(_GeneratorSliderValue(
      volume: volume == freezed
          ? _value.volume
          : volume // ignore: cast_nullable_to_non_nullable
              as double,
      isPlaying: isPlaying == freezed
          ? _value.isPlaying
          : isPlaying // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GeneratorSliderValue implements _GeneratorSliderValue {
  const _$_GeneratorSliderValue({this.volume = 0.35, this.isPlaying = true});

  factory _$_GeneratorSliderValue.fromJson(Map<String, dynamic> json) =>
      _$_$_GeneratorSliderValueFromJson(json);

  @JsonKey(defaultValue: 0.35)
  @override
  final double volume;
  @JsonKey(defaultValue: true)
  @override
  final bool isPlaying;

  @override
  String toString() {
    return 'GeneratorSliderValue(volume: $volume, isPlaying: $isPlaying)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _GeneratorSliderValue &&
            (identical(other.volume, volume) ||
                const DeepCollectionEquality().equals(other.volume, volume)) &&
            (identical(other.isPlaying, isPlaying) ||
                const DeepCollectionEquality()
                    .equals(other.isPlaying, isPlaying)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(volume) ^
      const DeepCollectionEquality().hash(isPlaying);

  @JsonKey(ignore: true)
  @override
  _$GeneratorSliderValueCopyWith<_GeneratorSliderValue> get copyWith =>
      __$GeneratorSliderValueCopyWithImpl<_GeneratorSliderValue>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_GeneratorSliderValueToJson(this);
  }
}

abstract class _GeneratorSliderValue implements GeneratorSliderValue {
  const factory _GeneratorSliderValue({double volume, bool isPlaying}) =
      _$_GeneratorSliderValue;

  factory _GeneratorSliderValue.fromJson(Map<String, dynamic> json) =
      _$_GeneratorSliderValue.fromJson;

  @override
  double get volume => throw _privateConstructorUsedError;
  @override
  bool get isPlaying => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$GeneratorSliderValueCopyWith<_GeneratorSliderValue> get copyWith =>
      throw _privateConstructorUsedError;
}
