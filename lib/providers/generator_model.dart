import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../screens/generator/widgets/slider.dart'
    show GeneratorSliderController, GeneratorSliderValue;
import '../services/models/models.dart' show GeneratorPack, GeneratorInfo;
import '../services/generator_service.dart' show GeneratorService;

part 'generator_model.freezed.dart';
part 'generator_model.g.dart';

enum CtrlMgrEnum { play, pause, reset, up, down }

class GeneratorModel extends ChangeNotifier {
  GeneratorModel(this.service);

  final GeneratorService service;

  // TODO: [Idea] A list of currently playing generators

  List<GeneratorSliderController> _controllers = [];
  GeneratorAndSliderData _genSli = GeneratorAndSliderData(name: '', slidersData: []);

  List<GeneratorSliderController> get controllers => _controllers;
  GeneratorAndSliderData get genSli => _genSli;

  Future<List<GeneratorPack>> fetchGeneratorPack() => service.fetchGeneratorPack();
  // locator<GeneratorService>().fetchGeneratorPack();

  Future<GeneratorInfo> fetchGenerator(String name) => service.fetchGenerator(name);
  // locator<GeneratorService>().fetchGenerator(name);

  void initControllers(String name) async {
    // final GeneratorInfo genInfo = await locator<GeneratorService>().fetchGenerator(name);
    // final List<GeneratorSliderValue> genValues =
    //     await locator<GeneratorService>().loadGeneratorData();
    final GeneratorInfo genInfo = await service.fetchGenerator(name);
    final List<GeneratorSliderValue> genValues = await service.loadGeneratorData();

    _controllers = List<GeneratorSliderController>.generate(
        10,
        (index) => GeneratorSliderController.asset(
              [genInfo.audios[index].sound1, genInfo.audios[index].sound2],
              // TODO: Init data from Local Storage
              value: genValues.isNotEmpty ? genValues[index] : GeneratorSliderValue(),
            ));
    notifyListeners();
  }

  void disposeControllers() {
    _controllers.forEach((controller) {
      controller.dispose();
    });
  }

  void act(CtrlMgrEnum action) {
    switch (action) {
      case CtrlMgrEnum.play:
        controllers.forEach((controller) {
          controller.play();
        });
        break;
      case CtrlMgrEnum.pause:
        controllers.forEach((controller) {
          controller.pause();
        });
        break;
      case CtrlMgrEnum.reset:
        controllers.forEach((controller) {
          controller.reset();
        });
        break;
      case CtrlMgrEnum.down:
        controllers.forEach((controller) {
          controller.volumeDown();
        });
        break;
      case CtrlMgrEnum.up:
        controllers.forEach((controller) {
          controller.volumeUp();
        });
        break;
      default:
    }
  }

  void saveGeneratorData() {
    // locator<GeneratorService>()
    service.saveGeneratorData(_controllers.map<GeneratorSliderValue>((e) => e.value).toList());
  }

  void clearGeneratorData() {
    // locator<GeneratorService>()
    service.saveGeneratorData([]);
  }

  // void saveSliderData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('genSli', jsonEncode(_genSli));
  // }

  // GeneratorsModel() {}

  // GeneratorsModel._create() {}

  // Future<GeneratorsModel> create(String generatorName) async {
  //   var generatorsModel = GeneratorsModel._create();

  //   generatorsModel._genSli.copyWith(name: generatorName);

  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   if (prefs.getString(generatorName) != null)
  //     generatorsModel._genSli.copyWith(
  //         slidersData: prefs.getString(generatorName) != null
  //             ? GeneratorSliderValue.toList(jsonDecode(prefs.getString(generatorName)!))
  //             : List.generate(10, (index) => GeneratorSliderValue()));

  //   return generatorsModel;
  // }

  // Future<void> loadGeneratorSliderValue(String key) async {
  //   final genRepo = GeneratorRepository();
  //   final List<GeneratorSliderValue> genList = await genRepo.loadValue(key);

  //   _genSli = _genSli.copyWith(name: key);
  //   _genSli = _genSli.copyWith(slidersData: genList);
  // }

  // // TODO: Refactor
  // void saveGeneratorSliderValue(int index, GeneratorSliderValue value) async {
  //   var newSlidersData = _genSli.slidersData;
  //   newSlidersData[index] = value;
  //   _genSli = _genSli.copyWith(slidersData: newSlidersData);

  //   final genRepo = GeneratorRepository();
  //   genRepo.saveValue(_genSli.name, _genSli.slidersData);
  // }

  // void updateName(String name) {
  //   _genSli.copyWith(name: name);
  //   notifyListeners();
  // }

  // void add(GeneratorAndSliderData genSli) {
  //   _genSli = genSli;
  //   notifyListeners();
  // }

  // void add(int index, GeneratorSliderValue sD) {
  //   List<GeneratorSliderValue> slidersData = _genSli[index].slidersData;
  //   slidersData = sD;

  //   _genSli.copyWith(slidersData:
  //   notifyListeners();
  // }

}

@freezed
class GeneratorAndSliderData with _$GeneratorAndSliderData {
  const factory GeneratorAndSliderData({
    required String name,
    required List<GeneratorSliderValue> slidersData,
  }) = _GeneratorAndSliderData;

  // GeneratorAndSliderData.fromJson(Map<String, dynamic> json)
  //     : genName = json['genName'],
  //       slidersData = (jsonDecode(json['slidersData']) as List)
  //           .map<GeneratorSliderValue>((i) => GeneratorSliderValue.fromJson(i))
  //           .toList();

  factory GeneratorAndSliderData.fromJson(Map<String, dynamic> json) =>
      _$GeneratorAndSliderDataFromJson(json);
}
