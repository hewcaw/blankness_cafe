import 'package:flutter/material.dart';

import './auxiliary_buttons.dart' show MynoiseButton;
import './time_picker_spinner.dart';

class TimerButton extends StatelessWidget {
  const TimerButton({Key? key, required this.onTimeChange}) : super(key: key);

  final TimePickerCallback onTimeChange;

  @override
  Widget build(BuildContext context) {
    void _showDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            content: TimePickerSpinner(
              onTimeChange: onTimeChange,
            ),
          );
        },
      );
    }

    return MynoiseButton(
      child: IconButton(
        icon: Icon(Icons.timer, color: Colors.white, size: 14),
        onPressed: _showDialog,
      ),
    );
  }
}
