import 'package:blankness_cafe/domain/repositories.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common/routes.dart';
import 'common/theme.dart';
import 'screens/home/home.dart';
import 'screens/generator/generator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final GeneratorRepository repo = GeneratorRepository(await SharedPreferences.getInstance());
  final String current = await repo.getCurrentGenerator();

  runApp(MaterialApp(
    theme: appTheme,
    initialRoute: current.isNotEmpty ? Routes.generator : Routes.home,
    routes: {
      Routes.home: (context) => Home(),
      Routes.generator: (context) => Generator(),
    },
  ));
}
