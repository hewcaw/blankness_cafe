import 'package:blankness_cafe/providers/generator_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_xlider/flutter_xlider.dart';

import '../../services/models/models.dart' show GeneratorAudio, GeneratorPack, GeneratorInfo;
import '../../services/generator_service.dart';
import '../../widgets/buttons.dart' show MyBackButton;

import './widgets/auxiliary_buttons.dart';
import './widgets/countdown.dart';
import './widgets/slider.dart';
import './widgets/timer_button.dart';

class Generator extends StatefulWidget {
  @override
  _GeneratorState createState() => _GeneratorState();
}

class _GeneratorState extends State<Generator> {
  late final Future<List<GeneratorPack>> futureGeneratorPack;

  bool _isPlaying = true;
  Duration duration = Duration(hours: 2);

  @override
  void initState() {
    super.initState();
    context.read<GeneratorModel>().initControllers('Cafe Restaurant');
  }

  @override
  void dispose() {
    context.read<GeneratorModel>().disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<GeneratorModel>();

    return Scaffold(
      appBar: AppBar(
        leading: MyBackButton(onPressed: () {
          Navigator.pop(context);
          vm.clearGeneratorData();
        }),
        brightness: Brightness.dark,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 16, left: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 32),
            vm.controllers.isEmpty
                ? Center(child: CircularProgressIndicator())
                : Container(
                    height: 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        10,
                        (i) => GeneratorSlider(
                          colorIndex: i,
                          controller: vm.controllers[i],
                          onChangeEnd: (_) => vm.saveGeneratorData(),
                        ),
                      ),
                    ),
                  ),
            Center(
              child: CountdownFormatted(
                duration: this.duration,
                builder: (BuildContext ctx, String remaining) {
                  return Text(remaining);
                },
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PlayPauseButton(
                    isPlaying: _isPlaying,
                    onPressed: () {
                      setState(() => this._isPlaying = !this._isPlaying);
                      if (_isPlaying)
                        vm.act(CtrlMgrEnum.play);
                      else
                        vm.act(CtrlMgrEnum.pause);
                    }),
                SizedBox(width: 16),
                VolumeDown(onPressed: () => vm.act(CtrlMgrEnum.down)),
                SizedBox(width: 16),
                VolumeUp(onPressed: () => vm.act(CtrlMgrEnum.up)),
                SizedBox(width: 16),
                // FIXME: Why the below cause null error?
                // ResetButton(onPressed: _controller.reset!),
                ResetButton(onPressed: () => vm.act(CtrlMgrEnum.reset)),
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

// class ControllersManager {
//   // late SliderController controller1;
//   // late List<SliderController> controllers = [controller1];

//   List<SliderController> controllers = List<SliderController>.generate(10, (index) {
//     return SliderController();
//   });

//   void init() {
//     controllers.forEach((controller) {
//       controller = SliderController();
//     });
//   }

//   void dispose() {
//     controllers.forEach((controller) {
//       controller.dispose();
//     });
//   }
// }
