import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/generator/widgets/slider.dart';

import 'models/models.dart' show GeneratorPack, GeneratorInfo;

// TODO: Reduce boilerplate like 200, etc
class GeneratorService {
  GeneratorService(this.prefs);

  final SharedPreferences prefs;

  static const String _baseUrl = "192.168.2.6:3000";
  static const String _prefix = "generators";

  Future<List<GeneratorPack>> fetchGeneratorPack() async {
    final response = await http.get(Uri.http(_baseUrl, "/$_prefix"));

    if (response.statusCode == 200) {
      List<GeneratorPack> list = GeneratorPack.toList(jsonDecode(response.body));
      return list;
    } else
      throw Exception('Failed to load generator packs');
  }

  Future<GeneratorInfo> fetchGenerator(String name) async {
    final String noSpaces = name.replaceAll(' ', '');
    final String urlParam = noSpaces[0].toLowerCase() + noSpaces.substring(1);

    final response = await http.get(Uri.http(_baseUrl, "/$_prefix/$urlParam"));

    if (response.statusCode == 200)
      return GeneratorInfo.fromJson(jsonDecode(response.body));
    else
      throw Exception('Failed to load generator packs');
  }

  void saveGeneratorData(List<GeneratorSliderValue> genSliValue) async {
    await prefs.setString("current", jsonEncode(genSliValue));
  }

  Future<List<GeneratorSliderValue>> loadGeneratorData() async {
    return GeneratorSliderValue.toList(jsonDecode(prefs.getString("current") ?? '[]'));
  }
}
