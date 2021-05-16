import 'dart:async';
import 'package:flutter/material.dart';

/// Based on https://pub.dev/packages/countdown_flutter
class Countdown extends StatefulWidget {
  const Countdown({
    Key? key,
    required this.duration,
    required this.builder,
    this.onFinish,
    this.interval = const Duration(seconds: 1),
  }) : super(key: key);

  final Duration duration;
  final Duration interval;
  final VoidCallback? onFinish;
  final Widget Function(BuildContext context, Duration remaining) builder;
  @override
  _CountdownState createState() => _CountdownState();
}

class _CountdownState extends State<Countdown> {
  late Timer _timer;
  late Duration _duration;

  @override
  void initState() {
    super.initState();
    _duration = widget.duration;
    _startTimer();
  }

  @override
  void didUpdateWidget(Countdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.duration != oldWidget.duration) {
      setState(() {
        _duration = widget.duration;
      });
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(widget.interval, timerCallback);
  }

  void timerCallback(Timer timer) {
    setState(() {
      if (_duration.inSeconds == 0) {
        timer.cancel();
        if (widget.onFinish != null) widget.onFinish!;
      } else {
        _duration = Duration(seconds: _duration.inSeconds - 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _duration);
  }
}

class CountdownFormatted extends StatelessWidget {
  const CountdownFormatted({
    Key? key,
    required this.duration,
    required this.builder,
    this.onFinish,
    this.interval = const Duration(seconds: 1),
    this.formatter,
  }) : super(key: key);

  final Duration duration;
  final Duration interval;
  final VoidCallback? onFinish;

  /// An function to format the remaining time
  final String Function(Duration)? formatter;

  final Widget Function(BuildContext context, String remaining) builder;

  static String twoDigits(int n) {
    if (n >= 10) return '$n';
    return '0$n';
  }

  static String formatBySeconds(Duration duration) =>
      twoDigits(duration.inSeconds.remainder(60));

  static String formatByMinutes(Duration duration) {
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    return '$twoDigitMinutes:${formatBySeconds(duration)}';
  }

  static String formatByHours(Duration duration) {
    return '${twoDigits(duration.inHours)}:${formatByMinutes(duration)}';
  }

  Function(Duration) _formatter() {
    if (formatter != null) return formatter!;
    if (duration.inHours >= 1) return formatByHours;
    if (duration.inMinutes >= 1) return formatByMinutes;

    return formatBySeconds;
  }

  @override
  Widget build(BuildContext context) {
    return Countdown(
      interval: interval,
      onFinish: onFinish,
      duration: duration,
      builder: (BuildContext ctx, Duration remaining) {
        return builder(ctx, _formatter()(remaining));
      },
    );
  }
}
