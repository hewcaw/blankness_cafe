import 'dart:convert';
import 'dart:io';

void main() async {
  final file = File('./data.json');
  file.writeAsString(json.encode(GeneratorPack.generatorBlocks));
}

// FIXME: Refactor this whole shit, please? =))
class GeneratorPack {
  static List<Map<String, dynamic>> get generatorBlocks => [
        {
          'suggestion': 'My room is too quiet',
          'generators': [
            GeneratorInfo(
              'Calm Office',
              'Some people find it surprisingly difficult to work from a quiet '
                  'home, and miss the sound of their office',
              'assets/images/generators/calm_office.jpg',
              GeneratorAudioPacks.calmOffice,
            ),
          ],
        },
      ];
}

// TODO: Rename?
class GeneratorInfo {
  const GeneratorInfo(this.name, this.description, this.thumbnail, this.audios);

  final String name;
  final String description;
  final String thumbnail;
  final List<GeneratorAudio> audios;

  GeneratorInfo.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        description = json['description'],
        thumbnail = json['thumbnail'],
        audios = List<GeneratorAudio>.from(
            json['audios'].map((model) => GeneratorAudio.fromJson(model)));

  Map<String, dynamic> toJson() =>
      {'name': name, 'description': description, 'thumbnail': thumbnail, 'audios': audios};
}

class GeneratorAudioPacks {
  static List<GeneratorAudio> get calmOffice => _generateAudios("calm_office", _calmOffice);

  static List<GeneratorAudio> _generateAudios(String fileName, List<String> generatorNames) {
    return List.generate(10, (int index) {
      final String audio1 = 'assets/audios/$fileName/a$index.ogg';
      final String audio2 = 'assets/audios/$fileName/b$index.ogg';
      return GeneratorAudio(generatorNames[index], audio1, audio2);
    });
  }

  static const List<String> _calmOffice = [
    "Room Tone",
    "Air Co",
    "Chatty Colleagues",
    "Copy Machine",
    "Printer & Scanner",
    "Office Noises",
    "Keyboard & Mouse",
    "Keyboards",
    "Writing",
    "Office Clock",
  ];
}

class GeneratorAudio {
  const GeneratorAudio(this.name, this.sound1, this.sound2);

  final String name;
  final String sound1;
  final String sound2;

  GeneratorAudio.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        sound1 = json['sound1'],
        sound2 = json['sound2'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'sound1': sound1,
        'sound2': sound2,
      };
}
