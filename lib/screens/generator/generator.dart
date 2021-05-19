import 'package:flutter/material.dart';
// import 'package:flutter_xlider/flutter_xlider.dart';

import '../../domain/models/models.dart' show GeneratorAudio, GeneratorPack, GeneratorInfo;
import '../../domain/repositories.dart';
import '../../widgets/buttons.dart' show MyBackButton;

import './widgets/auxiliary_buttons.dart';
import './widgets/countdown.dart';
import './widgets/slider.dart';
import './widgets/timer_button.dart';

// TODO: Refactor - Audio to Generator.
class Generator extends StatefulWidget {
  // const Generator({Key? key, required this.audios}) : super(key: key);

  // final List<GeneratorAudio> audios;

  @override
  _GeneratorState createState() => _GeneratorState();
}

class _GeneratorState extends State<Generator> {
  bool _isPlaying = true;
  Duration duration = Duration(hours: 2);
  // late SliderController _controller;
  late ControllersManager _controllersManager;
  late Future<List<GeneratorPack>> futureGeneratorPack;
  // final GlobalKey<_MynoiseSlider> _state = GlobalKey<_MynoiseSlider>();

  @override
  void initState() {
    super.initState();
    futureGeneratorPack = GeneratorRepository.fetchGeneratorPack();
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
        padding: EdgeInsets.only(top: 16, left: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 32),
            Container(
              height: 200,
              child: FutureBuilder(
                future: futureGeneratorPack,
                builder: (context, AsyncSnapshot<List<GeneratorPack>> snapshot) {
                  if (snapshot.hasData) {
                    // return Text(snapshot.data!.title);
                    return ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 26),
                      // itemCount: HomeMockData.cardItems.length,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        // final item = HomeMockData.cardItems[index];
                        // List<String> audios = snapshot.data![0].generators[0].audios
                        //     .map<String>((value) => value.sound1).toList();
                        List<GeneratorAudio> audios = snapshot.data![0].generators[0].audios;

                        final item = snapshot.data![index];
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            audios.length,
                            (i) => MynoiseSlider(
                              audioAsset: audios[i].sound1,
                              thumbColor: MynoiseSlider.sliderColors[i][0],
                              activeColor: MynoiseSlider.sliderColors[i][1],
                              inactiveColor: MynoiseSlider.sliderColors[i][2],
                              controller: _controllersManager.controllers[i],
                            ),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }

                  // By default, show a loading spinner.
                  return CircularProgressIndicator();
                },
              ),
            ),
            Center(
              child: CountdownFormatted(
                duration: this.duration,
                builder: (BuildContext ctx, String remaining) {
                  return Text(remaining); // 01:00:00
                },
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // GeneratorSwitchButton(),
                // GeneratorAddButton(),
                PlayPauseButton(
                    isPlaying: _isPlaying,
                    onPressed: () {
                      setState(() => this._isPlaying = !this._isPlaying);
                      if (_isPlaying)
                        _controllersManager.controllers.forEach((controller) {
                          controller.pause!();
                        });
                      else
                        _controllersManager.controllers.forEach((controller) {
                          controller.play!();
                        });
                    }),
                SizedBox(width: 16),
                VolumeDown(onPressed: () {
                  _controllersManager.controllers.forEach((controller) {
                    controller.volumeDown!();
                  });
                }),
                SizedBox(width: 16),
                VolumeUp(onPressed: () {
                  _controllersManager.controllers.forEach((controller) {
                    controller.volumeUp!();
                  });
                }),
                SizedBox(width: 16),
                // FIXME: Why the below cause null error?
                // ResetButton(onPressed: _controller.reset!),
                ResetButton(onPressed: () {
                  _controllersManager.controllers.forEach((controller) {
                    controller.reset!();
                  });
                }),
                SizedBox(width: 16),
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
          ],
        ),
      ),
    );
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
