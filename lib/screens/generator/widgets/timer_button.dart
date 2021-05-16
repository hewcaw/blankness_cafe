import 'package:flutter/material.dart';

import 'time_picker_spinner.dart';

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
        icon: Icon(Icons.play_arrow, color: Colors.white, size: 14),
        onPressed: _showDialog,
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
