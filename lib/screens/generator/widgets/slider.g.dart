// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GeneratorSliderValue _$_$_GeneratorSliderValueFromJson(
    Map<String, dynamic> json) {
  return _$_GeneratorSliderValue(
    volume: (json['volume'] as num?)?.toDouble() ?? 0.35,
    isPlaying: json['isPlaying'] as bool? ?? true,
  );
}

Map<String, dynamic> _$_$_GeneratorSliderValueToJson(
        _$_GeneratorSliderValue instance) =>
    <String, dynamic>{
      'volume': instance.volume,
      'isPlaying': instance.isPlaying,
    };
