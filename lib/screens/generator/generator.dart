import 'package:flutter/material.dart';
// import 'package:flutter_xlider/flutter_xlider.dart';

import '../../domain/models/models.dart' show GeneratorAudio;
import '../../widgets/buttons.dart' show MyBackButton;

import './widgets/countdown.dart';
import './widgets/slider.dart';
import './widgets/timer_button.dart';

// TODO: Refactor - Audio to Generator.
class Generator extends StatefulWidget {
  const Generator({Key? key, required this.audios}) : super(key: key);

  final List<GeneratorAudio> audios;

  @override
  _GeneratorState createState() => _GeneratorState();
}

class _GeneratorState extends State<Generator> {
  bool _isPaused = false;
  Duration duration = Duration(hours: 2);
  // late SliderController _controller;
  late ControllersManager _controllersManager;
  // final GlobalKey<_MynoiseSlider> _state = GlobalKey<_MynoiseSlider>();

  @override
  void initState() {
    super.initState();
    _controllersManager = ControllersManager();
    _controllersManager.init();
    // _controller = SliderController();
  }

  @override
  void dispose() {
    // _controller.dispose();
    _controllersManager.dispose();
    super.dispose();
  }

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
                PauseButton(onPressed: () {
                  setState(() => this._isPaused = !this._isPaused);
                  if (_isPaused)
                    _controllersManager.controllers.forEach((controller) {
                      controller.pause!();
                    });
                  else
                    _controllersManager.controllers.forEach((controller) {
                      controller.play!();
                    });
                }),
                VolumeDown(onPressed: () {
                  _controllersManager.controllers.forEach((controller) {
                    controller.volumeDown!();
                  });
                }),
                VolumeUp(onPressed: () {
                  _controllersManager.controllers.forEach((controller) {
                    controller.volumeUp!();
                  });
                }),
                // FIXME: Why the below cause null error?
                // ResetButton(onPressed: _controller.reset!),
                ResetButton(onPressed: () {
                  _controllersManager.controllers.forEach((controller) {
                    controller.reset!();
                  });
                }),
                TimerButton(
                  onTimeChange: (DateTime time) {
                    setState(() {
                      this.duration = Duration(hours: time.hour, minutes: time.minute);
                      print("Duration >>> " + this.duration.toString());
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.audios.length,
                (i) => MynoiseSlider(
                  audioAsset: widget.audios[i].sound1,
                  thumbColor: MynoiseSlider.sliderColors[i][0],
                  activeColor: MynoiseSlider.sliderColors[i][1],
                  inactiveColor: MynoiseSlider.sliderColors[i][2],
                  controller: _controllersManager.controllers[i],
                ),
              ),
            ),
            CountdownFormatted(
              duration: this.duration,
              builder: (BuildContext ctx, String remaining) {
                return Text(remaining); // 01:00:00
              },
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

class ControllersManager {
  // late SliderController controller1;
  // late List<SliderController> controllers = [controller1];

  List<SliderController> controllers = List<SliderController>.generate(10, (index) {
    return SliderController();
  });

  void init() {
    controllers.forEach((controller) {
      controller = SliderController();
    });
  }

  void dispose() {
    controllers.forEach((controller) {
      controller.dispose();
    });
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

class MynoiseButton extends StatelessWidget {
  const MynoiseButton({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      width: 32,
      decoration: BoxDecoration(
        color: Colors.grey.shade700,
        border: Border.all(width: 2, color: Colors.grey.shade300),
        shape: BoxShape.circle,
      ),
      child: child,
    );
  }
}

class PauseButton extends StatelessWidget {
  PauseButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return MynoiseButton(
      child: IconButton(
        icon: Icon(Icons.play_arrow, color: Colors.white, size: 14),
        onPressed: onPressed,
      ),
    );
  }
}

class VolumeDown extends StatelessWidget {
  VolumeDown({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return MynoiseButton(
      child: IconButton(
        icon: Icon(Icons.volume_down_outlined, color: Colors.white, size: 14),
        onPressed: onPressed,
      ),
    );
  }
}

class VolumeUp extends StatelessWidget {
  VolumeUp({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return MynoiseButton(
      child: IconButton(
        icon: Icon(Icons.volume_up_outlined, color: Colors.white, size: 14),
        onPressed: onPressed,
      ),
    );
  }
}

class ResetButton extends StatelessWidget {
  ResetButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return MynoiseButton(
      child: IconButton(
        icon: Icon(Icons.arrow_circle_down_outlined, color: Colors.white, size: 14),
        onPressed: onPressed,
      ),
    );
  }
}
