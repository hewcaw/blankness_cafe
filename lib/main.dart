import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import 'common/locator.dart';
import 'common/routes.dart';
import 'common/theme.dart';
import 'providers/generator_model.dart';
import 'screens/home/home.dart';
import 'screens/generator/generator.dart';
import 'services/generator_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // FIXME: Cannot do this because the Locator isn't initialized yet
  // final current = await locator<GeneratorService>().loadGeneratorData();
  final GeneratorService service = GeneratorService(await SharedPreferences.getInstance());
  // service.saveGeneratorData([]);
  final current = await service.loadGeneratorData();

  runApp(
    MultiProvider(
        providers: [
          // ChangeNotifierProvider(create: (context) => GeneratorModel()),
          ChangeNotifierProvider.value(value: GeneratorModel(service)),
        ],
        child: MaterialApp(
          title: 'Blankness Cafe',
          theme: appTheme,
          initialRoute: current.isNotEmpty ? Routes.generator : Routes.home,
          routes: {
            Routes.home: (context) => Home(),
            Routes.generator: (context) => Generator(),
          },
        )),
  );
}
