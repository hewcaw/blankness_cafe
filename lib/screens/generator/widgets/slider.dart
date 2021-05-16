import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

// TODO: A way to use just 1 colors
// TODO: Turn this into Stateless via GetX
class MynoiseSlider extends StatefulWidget {
  MynoiseSlider({
    Key? key,
    required this.audioAsset,
    required this.thumbColor,
    required this.activeColor,
    required this.inactiveColor,
    required this.controller,
  }) : super(key: key);

  final String audioAsset;
  final Color thumbColor;
  final Color activeColor;
  final Color inactiveColor;
  final SliderController controller;

  static List<List<Color>> get sliderColors => [
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

  @override
  _MynoiseSlider createState() => _MynoiseSlider();
}

class _MynoiseSlider extends State<MynoiseSlider> {
  // TODO: Should I write a controller for this?
  late AudioPlayer _audioPlayer;
  double _value = 35; // default value
  late double _originalValue;

  @override
  void initState() {
    super.initState();
    _originalValue = _value;
    _audioPlayer = AudioPlayer();
    _initAudio();
    _initController();
  }

  Future<void> _initAudio() async {
    // final String source = "assets/audios/calm_office/";
    await _audioPlayer.setAsset(widget.audioAsset);
    await _audioPlayer.setLoopMode(LoopMode.one);
    await _audioPlayer.setVolume(this._value / 100);

    _audioPlayer.play();
  }

  void _initController() {
    SliderController controller = widget.controller;
    controller.reset = _onReset;
    controller.pause = _onPause;
    controller.play = _onPlay;
    controller.volumeUp = _onVolumeUp;
    controller.volumeDown = _onVolumeDown;
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _onReset() => _onVolumeChanged(35);
  void _onPause() => _audioPlayer.pause();
  void _onPlay() => _audioPlayer.play();
  void _onVolumeUp() => _onVolumeChanged(_value + 10);
  void _onVolumeDown() => _onVolumeChanged(_value - 10);

  Future<void> _onVolumeChanged(double value) async {
    if (value <= 100 && value >= 0) {
      setState(() => this._value = value);
      await _audioPlayer.setVolume(this._value / 100);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderThemeData(
        trackHeight: 12,

        thumbColor: widget.thumbColor,
        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 9),

        activeTrackColor: widget.activeColor,
        inactiveTrackColor: widget.inactiveColor,

        /// Disable ticks in between.
        activeTickMarkColor: Colors.transparent,
        inactiveTickMarkColor: Colors.transparent,
      ),
      child: SizedBox(
        height: 180,
        width: 30,
        child: RotatedBox(
          quarterTurns: 3,
          child: Slider(
            value: _value,
            max: 100,
            min: 0,
            divisions: 20,
            // label: value.round().toString(),
            onChanged: _onVolumeChanged,
          ),
        ),
      ),
    );
  }
}

// TODO: Should I use enum?
class SliderController {
  VoidCallback? reset;
  VoidCallback? pause;
  VoidCallback? play;
  VoidCallback? volumeUp;
  VoidCallback? volumeDown;

  void dispose() {
    reset = null;
    pause = null;
    play = null;
    volumeUp = null;
    volumeDown = null;
  }
}
