import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:pedantic/pedantic.dart';
// import 'package:flutter_xlider/flutter_xlider.dart';

part 'slider.freezed.dart';
part 'slider.g.dart';

// TODO: Turn this into Stateless via GetX
class GeneratorSlider extends StatefulWidget {
  GeneratorSlider({
    Key? key,
    required this.colorIndex,
    required this.controller,
    this.onChangeEnd,
  }) : super(key: key);

  final int colorIndex;
  final GeneratorSliderController controller;
  final Function(GeneratorSliderValue)? onChangeEnd;

  @override
  _GeneratorSlider createState() => _GeneratorSlider();
}

class _GeneratorSlider extends State<GeneratorSlider> {
  late final AudioPlayer _player;

  late double _volume;

  GeneratorSliderController get controller => widget.controller;

  static List<List<Color>> get _sliderColors => [
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
          // Colors.yellow.shade300.withOpacity(0.7),
          Colors.yellow[300]!.withOpacity(0.7),
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

  @override
  void initState() {
    super.initState();
    _volume = controller.value.volume;
    _player = AudioPlayer();
    _initAudio();
    controller.addListener(_listener);
  }

  void _initAudio() async {
    // final session = await AudioSession.instance;
    // await session.configure(AudioSessionConfiguration.speech());

    // Listen to errors during playback.
    // _player.playbackEventStream.listen((event) {}, onError: (Object e, StackTrace stackTrace) {
    //   print('A stream error occurred: $e');
    // });
    // try {
    //   await _player.setAudioSource(ConcatenatingAudioSource(
    //     children: controller.dataSources
    //         .map((e) => AudioSource.uri(Uri.parse('asset:///$e')))
    //         .toList(),
    //   ));
    //   await _player.setLoopMode(LoopMode.all);
    //   await _player.setShuffleModeEnabled(true);
    //   await _player.setVolume(this._volume);
    // } catch (e) {
    //   // Catch load errors: 404, invalid url ...
    //   print("Error loading playlist: $e");
    // }
    // await _player.setAudioSource(
    //   ConcatenatingAudioSource(
    //     useLazyPreparation: true, // default
    //     // Customise the shuffle algorithm.
    //     shuffleOrder: DefaultShuffleOrder(), // default
    //     children: [
    //       AudioSource.uri(Uri.parse('asset:///assets/audios/cafe_restaurant/a7.ogg'),
    //           tag: 'Audio 1'),
    //       AudioSource.uri(Uri.parse('asset:///assets/audios/cafe_restaurant/b7.ogg'),
    //           tag: 'Audio 2')
    //     ],
    //     // children: controller.dataSources
    //     //     .map((e) => AudioSource.uri(Uri.parse('asset:///$e')))
    //     //     .toList(),
    //   ),
    //   // Playback will be prepared to start from track1.mp3
    //   initialIndex: 0, // default
    //   // Playback will be prepared to start from position zero.
    //   initialPosition: Duration.zero, // default
    // );

    await _player.setAsset(controller.dataSources[0]);
    await _player.setLoopMode(LoopMode.all);
    await _player.setVolume(this._volume);

    _player.play();
  }

  void _listener() {
    setState(() => _volume = controller.value.volume);
    _onVolumeChanged(controller.value.volume);
    if (controller.value.isPlaying)
      _player.play();
    else
      _player.pause();
  }

  @override
  void dispose() {
    _player.dispose();
    controller.dispose();
    super.dispose();
  }

  Future<void> _onVolumeChanged(double volume) async {
    widget.controller.volume = volume;
    await _player.setVolume(_volume);
  }

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderThemeData(
        trackHeight: 12,
        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 9),
        thumbColor: _sliderColors[widget.colorIndex][0],
        activeTrackColor: _sliderColors[widget.colorIndex][1],
        inactiveTrackColor: _sliderColors[widget.colorIndex][2],

        // Disable ticks in between.
        activeTickMarkColor: Colors.transparent,
        inactiveTickMarkColor: Colors.transparent,
      ),
      child: SizedBox(
        height: 180,
        width: 30,
        child: RotatedBox(
          quarterTurns: 3,
          child: Slider(
            value: _volume * 100,
            min: 0,
            max: 100,
            divisions: 100,
            // label: value.round().toString(),
            onChanged: (value) => setState(() => _volume = value / 100),
            onChangeEnd: (value) {
              _onVolumeChanged(value / 100);
              if (widget.onChangeEnd != null)
                widget.onChangeEnd!(GeneratorSliderValue(volume: value));
            },
          ),
        ),
      ),
    );
  }
}

// TODO: Should I use enum?
// TODO: Clean this shit the proper way
class GeneratorSliderController extends ValueNotifier<GeneratorSliderValue> {
  GeneratorSliderController.asset(this.dataSources, {required GeneratorSliderValue value})
      : super(GeneratorSliderValue(
          volume: value.volume,
          isPlaying: value.isPlaying,
        ));

  final List<String> dataSources;

  double get volume => value.volume;

  set volume(double newVolume) {
    value = value.copyWith(volume: newVolume);
  }

  // TODO: How to truly dispose stuff?
  @override
  void dispose() {
    super.dispose();
  }

  // TODO: Better way to handle all of these repetitive stuff?
  void play() => value = value.copyWith(isPlaying: true);
  void pause() => value = value.copyWith(isPlaying: false);
  void reset() => value = value.copyWith(volume: GeneratorSliderValue.defaultVolume);
  void volumeDown() => value = value.copyWith(volume: _calculateVolume(value.volume - 0.1));
  void volumeUp() => value = value.copyWith(volume: _calculateVolume(value.volume + 0.1));

  static double _calculateVolume(double volume) {
    if (volume < 0) return 0;
    if (volume > 1) return 1;
    return volume;
  }
}

@freezed
class GeneratorSliderValue with _$GeneratorSliderValue {
  const factory GeneratorSliderValue({
    @Default(0.35) double volume,
    @Default(true) bool isPlaying,
    // TODO: SliderAnimation class, because there will be more value
    // @Default(false) bool isAnimated,
  }) = _GeneratorSliderValue;

  factory GeneratorSliderValue.fromJson(Map<String, dynamic> json) =>
      _$GeneratorSliderValueFromJson(json);

  static List<GeneratorSliderValue> toList(Iterable listJson) {
    return List<GeneratorSliderValue>.from(
        listJson.map((model) => GeneratorSliderValue.fromJson(model)));
  }

  static const double defaultVolume = 0.35;

  // TODO: Get volume with check

  // final double volume;

  // final bool isAnimated;

  // GeneratorSliderValue.fromJson(Map<String, dynamic> json)
  //     : volume = json['volume'],
  //       isAnimated = json['isAnimated'];

  // Map<String, dynamic> toJson() => {
  //       'volume': volume,
  //       'isAnimated': isAnimated,
  //     };
}
