import 'package:freezed_annotation/freezed_annotation.dart';

import '../../scripts/json_data_generator.dart' hide GeneratorPack;

export '../../scripts/json_data_generator.dart';

part 'models.freezed.dart';
part 'models.g.dart';

@freezed
class GeneratorPack with _$GeneratorPack {
  const factory GeneratorPack(
    String suggestion,
    List<GeneratorInfo> generators,
  ) = _GeneratorPack;

  factory GeneratorPack.fromJson(Map<String, dynamic> json) => _$GeneratorPackFromJson(json);

  static List<GeneratorPack> toList(Iterable listJson) {
    return List<GeneratorPack>.from(listJson.map((model) => GeneratorPack.fromJson(model)));
  }
}
