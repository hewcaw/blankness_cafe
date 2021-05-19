import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import './models/models.dart' show GeneratorPack;

// TODO: Reduce boilerplate like 200, etc
class GeneratorRepository {
  GeneratorRepository(this.prefs);

  final SharedPreferences prefs;

  static Future<List<GeneratorPack>> fetchGeneratorPack() async {
    final String baseUrl = "192.168.2.6:3000";
    final String tail = "/generators";

    final response = await http.get(Uri.http(baseUrl, tail));

    if (response.statusCode == 200) {
      List<GeneratorPack> list = GeneratorPack.toList(jsonDecode(response.body));
      return list;
    } else {
      throw Exception('Failed to load generator packs');
    }
  }

  void moveToGenerator(String name) async {
    await prefs.setString("current", name);
  }

  Future<String> getCurrentGenerator() async {
    return prefs.getString("current") ?? '';
  }
}
