// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GeneratorPack _$_$_GeneratorPackFromJson(Map<String, dynamic> json) {
  return _$_GeneratorPack(
    json['suggestion'] as String,
    (json['generators'] as List<dynamic>)
        .map((e) => GeneratorInfo.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$_$_GeneratorPackToJson(_$_GeneratorPack instance) =>
    <String, dynamic>{
      'suggestion': instance.suggestion,
      'generators': instance.generators,
    };
