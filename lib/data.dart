import 'package:flutter/material.dart' show Color, Colors;

class HomeMockData {
  static const List<CardItemModel> cardItems = [
    CardItemModel(
      guide: 'My room is too quiet',
      items: [
        ItemModel(
          'Calm Office',
          'Some people find it surprisingly difficult to work from a quiet '
              'home, and miss the sound of their office.',
          'assets/images/generators/calm_office.jpg',
        ),
      ],
    ),
  ];
}

class CardItemModel {
  const CardItemModel({required this.guide, required this.items});

  final String guide;
  final List<ItemModel> items;
}

class ItemModel {
  const ItemModel(this.title, this.subtitle, this.img);

  final String title;
  final String subtitle;
  final String img;
}

class GeneratorAudio {
  const GeneratorAudio(this.name, this.sound1, this.sound2);

  final String name;
  final String sound1;
  final String sound2;
}

// FIXME: Really?
class GeneratorData {
  static const List audios = [
    GeneratorAudio("Room Tone", "a0.ogg", "0b.ogg"),
    GeneratorAudio("Air Co", "a1.ogg", "1b.ogg"),
    GeneratorAudio("Chatty Colleagues", "a2.ogg", "2b.ogg"),
    GeneratorAudio("Copy Machine", "a3.ogg", "3b.ogg"),
    GeneratorAudio("Printer & Scanner", "a4.ogg", "4b.ogg"),
    GeneratorAudio("Office Noises", "a5.ogg", "5b.ogg"),
    GeneratorAudio("Keyboard & Mouse", "a6.ogg", "6b.ogg"),
    GeneratorAudio("Keyboards", "a7.ogg", "7b.ogg"),
    GeneratorAudio("Writing", "a8.ogg", "8b.ogg"),
    GeneratorAudio("Office Clock", "a9.ogg", "9b.ogg"),
  ];

  List<List<Color>> get sliderColors {
    return [
      [
        Colors.deepOrange,
        Colors.deepOrange.shade300,
        Colors.deepOrange.shade300.withOpacity(0.7),
      ],
      [
        Colors.red,
        Colors.red.shade300,
        Colors.red.shade300.withOpacity(0.7),
      ],
      [
        Colors.yellow,
        Colors.yellow.shade300,
        Colors.yellow.shade300.withOpacity(0.7),
      ],
      [
        Colors.lime,
        Colors.lime.shade300,
        Colors.lime.shade300.withOpacity(0.7),
      ],
      [
        Colors.green,
        Colors.green.shade300,
        Colors.green.shade300.withOpacity(0.7),
      ],
      [
        Colors.teal,
        Colors.teal.shade300,
        Colors.teal.shade300.withOpacity(0.7),
      ],
      [
        Colors.cyan,
        Colors.cyan.shade300,
        Colors.cyan.shade300.withOpacity(0.7),
      ],
      [
        Colors.blue,
        Colors.blue.shade300,
        Colors.blue.shade300.withOpacity(0.7),
      ],
      [
        Colors.deepPurple,
        Colors.deepPurple.shade300,
        Colors.deepPurple.shade300.withOpacity(0.7),
      ],
      [
        Colors.purple.shade400,
        Colors.purple.shade300,
        Colors.purple.shade300.withOpacity(0.7),
      ],
    ];
  }
}
