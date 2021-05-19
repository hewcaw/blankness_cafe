import 'package:flutter/material.dart';

class PlayPauseButton extends StatelessWidget {
  PlayPauseButton({
    required this.isPlaying,
    required this.onPressed,
  });

  final bool isPlaying;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return MynoiseButton(
      child: isPlaying
          ? IconButton(
              icon: Icon(Icons.pause, color: Colors.white, size: 16),
              onPressed: onPressed,
            )
          : IconButton(
              icon: Icon(Icons.play_arrow, color: Colors.white, size: 16),
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
        icon: Icon(Icons.subdirectory_arrow_left, color: Colors.white, size: 14),
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
        icon: Icon(Icons.volume_down, color: Colors.white, size: 14),
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
        icon: Icon(Icons.volume_up, color: Colors.white, size: 14),
        onPressed: onPressed,
      ),
    );
  }
}

class AddGenerator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Add another generator"),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          child: Container(
            height: 32,
            width: 32,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.black),
              color: Colors.grey,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(
                Icons.add,
                size: 14,
              ),
              onPressed: () {},
            ),
          ),
        ),
      ],
    );
  }
}

class SaveButton extends StatefulWidget {
  const SaveButton({Key? key, required this.onPressed}) : super(key: key);

  final Function(String) onPressed;

  @override
  _SaveButtonState createState() => _SaveButtonState();
}

class _SaveButtonState extends State<SaveButton> {
  late TextEditingController _controller;

  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void _showDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            content: TextField(
              controller: _controller,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.white),
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(),
                labelText: 'Enter the name...',
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Approve'),
                onPressed: () => widget.onPressed(_controller.text),
              ),
            ],
          );
        },
      );
    }

    return MynoiseButton(
      child: IconButton(
        icon: Icon(Icons.save, color: Colors.white, size: 14),
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
      height: 38,
      width: 38,
      decoration: BoxDecoration(
        color: Colors.grey.shade700,
        border: Border.all(width: 2, color: Colors.grey.shade300),
        shape: BoxShape.circle,
      ),
      child: child,
    );
  }
}
