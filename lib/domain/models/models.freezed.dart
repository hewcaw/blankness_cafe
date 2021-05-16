// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GeneratorPack _$GeneratorPackFromJson(Map<String, dynamic> json) {
  return _GeneratorPack.fromJson(json);
}

/// @nodoc
class _$GeneratorPackTearOff {
  const _$GeneratorPackTearOff();

  _GeneratorPack call(String suggestion, List<GeneratorInfo> generators) {
    return _GeneratorPack(
      suggestion,
      generators,
    );
  }

  GeneratorPack fromJson(Map<String, Object> json) {
    return GeneratorPack.fromJson(json);
  }
}

/// @nodoc
const $GeneratorPack = _$GeneratorPackTearOff();

/// @nodoc
mixin _$GeneratorPack {
  String get suggestion => throw _privateConstructorUsedError;
  List<GeneratorInfo> get generators => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GeneratorPackCopyWith<GeneratorPack> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GeneratorPackCopyWith<$Res> {
  factory $GeneratorPackCopyWith(
          GeneratorPack value, $Res Function(GeneratorPack) then) =
      _$GeneratorPackCopyWithImpl<$Res>;
  $Res call({String suggestion, List<GeneratorInfo> generators});
}

/// @nodoc
class _$GeneratorPackCopyWithImpl<$Res>
    implements $GeneratorPackCopyWith<$Res> {
  _$GeneratorPackCopyWithImpl(this._value, this._then);

  final GeneratorPack _value;
  // ignore: unused_field
  final $Res Function(GeneratorPack) _then;

  @override
  $Res call({
    Object? suggestion = freezed,
    Object? generators = freezed,
  }) {
    return _then(_value.copyWith(
      suggestion: suggestion == freezed
          ? _value.suggestion
          : suggestion // ignore: cast_nullable_to_non_nullable
              as String,
      generators: generators == freezed
          ? _value.generators
          : generators // ignore: cast_nullable_to_non_nullable
              as List<GeneratorInfo>,
    ));
  }
}

/// @nodoc
abstract class _$GeneratorPackCopyWith<$Res>
    implements $GeneratorPackCopyWith<$Res> {
  factory _$GeneratorPackCopyWith(
          _GeneratorPack value, $Res Function(_GeneratorPack) then) =
      __$GeneratorPackCopyWithImpl<$Res>;
  @override
  $Res call({String suggestion, List<GeneratorInfo> generators});
}

/// @nodoc
class __$GeneratorPackCopyWithImpl<$Res>
    extends _$GeneratorPackCopyWithImpl<$Res>
    implements _$GeneratorPackCopyWith<$Res> {
  __$GeneratorPackCopyWithImpl(
      _GeneratorPack _value, $Res Function(_GeneratorPack) _then)
      : super(_value, (v) => _then(v as _GeneratorPack));

  @override
  _GeneratorPack get _value => super._value as _GeneratorPack;

  @override
  $Res call({
    Object? suggestion = freezed,
    Object? generators = freezed,
  }) {
    return _then(_GeneratorPack(
      suggestion == freezed
          ? _value.suggestion
          : suggestion // ignore: cast_nullable_to_non_nullable
              as String,
      generators == freezed
          ? _value.generators
          : generators // ignore: cast_nullable_to_non_nullable
              as List<GeneratorInfo>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GeneratorPack implements _GeneratorPack {
  const _$_GeneratorPack(this.suggestion, this.generators);

  factory _$_GeneratorPack.fromJson(Map<String, dynamic> json) =>
      _$_$_GeneratorPackFromJson(json);

  @override
  final String suggestion;
  @override
  final List<GeneratorInfo> generators;

  @override
  String toString() {
    return 'GeneratorPack(suggestion: $suggestion, generators: $generators)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _GeneratorPack &&
            (identical(other.suggestion, suggestion) ||
                const DeepCollectionEquality()
                    .equals(other.suggestion, suggestion)) &&
            (identical(other.generators, generators) ||
                const DeepCollectionEquality()
                    .equals(other.generators, generators)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(suggestion) ^
      const DeepCollectionEquality().hash(generators);

  @JsonKey(ignore: true)
  @override
  _$GeneratorPackCopyWith<_GeneratorPack> get copyWith =>
      __$GeneratorPackCopyWithImpl<_GeneratorPack>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_GeneratorPackToJson(this);
  }
}

abstract class _GeneratorPack implements GeneratorPack {
  const factory _GeneratorPack(
      String suggestion, List<GeneratorInfo> generators) = _$_GeneratorPack;

  factory _GeneratorPack.fromJson(Map<String, dynamic> json) =
      _$_GeneratorPack.fromJson;

  @override
  String get suggestion => throw _privateConstructorUsedError;
  @override
  List<GeneratorInfo> get generators => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$GeneratorPackCopyWith<_GeneratorPack> get copyWith =>
      throw _privateConstructorUsedError;
}
