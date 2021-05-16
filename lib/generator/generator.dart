import 'package:flutter/material.dart';

import 'package:blankness_cafe/widgets/buttons.dart' show MyBackButton;
// import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:just_audio/just_audio.dart';

import '../data.dart';

// TODO: Refactor - Audio to Generator.
class Generator extends StatefulWidget {
  @override
  _GeneratorState createState() => _GeneratorState();
}

class _GeneratorState extends State<Generator> {
  bool isPaused = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: MyBackButton(
          onPressed: () => Navigator.pop(context),
        ),
        brightness: Brightness.dark,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 16, left: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GeneratorSwitchButton(),
                GeneratorAddButton(),
                PauseButton(
                  onPressed: () => setState(() => this.isPaused = !this.isPaused),
                ),
              ],
            ),
            SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                GeneratorData.audios.length,
                (i) => MynoiseSlider(
                  audioAsset: GeneratorData.audios[i].sound1,
                  thumbColor: GeneratorData().sliderColors[i][0],
                  activeColor: GeneratorData().sliderColors[i][1],
                  inactiveColor: GeneratorData().sliderColors[i][2],
                  isPaused: this.isPaused,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// TODO: Use 3D icon instead of Image Button.
class GeneratorSwitchButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Image.asset(
          'assets/images/generators/calm_office.jpg',
          height: 32.0,
          width: 32.0,
        ),
      ),
      onPressed: () {},
    );
    // return Container(
    //   height: 40,
    //   width: 40,
    //   decoration: BoxDecoration(
    //     color: Colors.grey, shape: BoxShape.circle,
    //   ),
    // );
  }
}

class PauseButton extends StatelessWidget {
  PauseButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      width: 32,
      child: IconButton(
        icon: Icon(Icons.play_arrow, color: Colors.white),
        onPressed: onPressed,
      ),
    );
  }
}

// TODO: Stop this ugly.
class GeneratorAddButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      width: 32,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.black),
        color: Colors.grey,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(Icons.add, size: 14),
        onPressed: () {},
      ),
    );
  }
}

// TODO: Turn this into Stateless via GetX.
class MynoiseSlider extends StatefulWidget {
  MynoiseSlider({
    required this.audioAsset,
    required this.thumbColor,
    required this.activeColor,
    required this.inactiveColor,
    this.isPaused = false,
  });

  final String audioAsset;
  final Color thumbColor;
  final Color activeColor;
  final Color inactiveColor;
  final bool isPaused;

  @override
  _MynoiseSlider createState() => _MynoiseSlider();
}

class _MynoiseSlider extends State<MynoiseSlider> {
  late AudioPlayer _audioPlayer;

  double value = 35; // default value

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _init();
  }

  Future<void> _init() async {
    await _audioPlayer.setAsset("assets/audios/calm_office/" + widget.audioAsset);
    await _audioPlayer.setLoopMode(LoopMode.one);
    await _audioPlayer.setVolume(this.value / 100);

    _audioPlayer.play();
  }

  @override
  void didUpdateWidget(MynoiseSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isPaused != oldWidget.isPaused) {
      if (widget.isPaused == true) {
        _audioPlayer.pause();
      } else {
        _audioPlayer.play();
      }
    }
  }

  @override
  void dispose() {
    // _audioPlayer.pause();
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _onVolumeChanged(double value) async {
    setState(() => this.value = value);
    await _audioPlayer.setVolume(this.value / 100);
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
            value: value,
            max: 100,
            min: 0,
            divisions: 20,
            // label: value.round().toString(),
            onChanged: _onVolumeChanged,
          ),
        ),
      ),
    );

    // return SizedBox(
    //   height: 180,
    //   width: 80,
    //   child: FlutterSlider(
    //     trackBar: FlutterSliderTrackBar(
    //       activeTrackBar: BoxDecoration(
    //           gradient: LinearGradient(colors: [Colors.black, Colors.white]),
    //           borderRadius: BorderRadius.circular(5)),
    //       activeTrackBarHeight: 6,
    //     ),
    //     axis: Axis.vertical,
    //     handler: FlutterSliderHandler(disabled: true),
    //     values: [this.value],
    //     min: 0,
    //     max: 100,
    //     onDragging: (handlerIndex, lowerValue, upperValue) async {
    //       setState(() => this.value = lowerValue);
    //       await _audioPlayer.setVolume(this.value / 100);
    //     },
    //   ),
    // );
  }
}
