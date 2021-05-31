// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generator_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GeneratorAndSliderData _$_$_GeneratorAndSliderDataFromJson(
    Map<String, dynamic> json) {
  return _$_GeneratorAndSliderData(
    name: json['name'] as String,
    slidersData: (json['slidersData'] as List<dynamic>)
        .map((e) => GeneratorSliderValue.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$_$_GeneratorAndSliderDataToJson(
        _$_GeneratorAndSliderData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'slidersData': instance.slidersData,
    };
