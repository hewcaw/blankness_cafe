import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

typedef SelectedIndexCallback = void Function(int);
typedef TimePickerCallback = void Function(DateTime);

// TODO: Day & Night icons at the center of the bar
// TODO: Linear gradient bars
// class TimePickerSpinner extends StatefulWidget {
//   // No need because we always pointed at 0 or the last pointed.
//   // final DateTime time;
//   // final int minutesInterval;
//   // TODO: Rename
//   final double itemHeight;
//   final double itemWidth;
//   final double spacing;
//   final AlignmentGeometry alignment;
//   // final bool isForce2Digits;
//   // TODO: Rename
//   final TimePickerCallback onTimeChange;
//
//   const TimePickerSpinner({
//     Key? key,
//     this.itemHeight = 60,
//     this.itemWidth = 45,
//     this.spacing = 20,
//     this.alignment = Alignment.centerRight,
//     // TODO: Should I put required at first?
//     required this.onTimeChange,
//   }) : super(key: key);
//
//   @override
//   _TimePickerSpinnerState createState() => _TimePickerSpinnerState();
// }
//
// class _TimePickerSpinnerState extends State<TimePickerSpinner> {
//   late ScrollController hourController;
//   late ScrollController minuteController;
//
//   @override
//   void
//
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

class _Spinner extends StatelessWidget {
  const _Spinner({
    Key? key,
    required this.controller,
    required this.selectedIndex,
    required this.onUpdateSelectedIndex,
  }) : super(key: key);

  final ScrollController controller;
  final int selectedIndex;
  final SelectedIndexCallback onUpdateSelectedIndex;

  final int max = 12;

  // FIXME: Wth is this? Remove this, always loop
  bool isLoop(int value) => value > 10;

  bool onNotif(scrollNotif) {
    if (scrollNotif is UserScrollNotification) {
      if (scrollNotif.direction == ScrollDirection.idle) {
        if (isLoop(max)) {
          int segment = (selectedIndex / max).floor();
        }
      }
    }

    return true;
  }

  // TODO: Rename
  String get _displayText {
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: NotificationListener<ScrollNotification>(
            onNotification: onNotif,
            child: ListView.builder(
              controller: controller,
              // TODO: widget.itemHeight
              physics: ItemScrollPhysics(itemHeight: 60),
              padding: EdgeInsets.zero,
              // itemCount: isLoop(max) ? max * 3 : max + 2,
              itemCount: max * 3,
              itemBuilder: (_, __) {
                return Text("Test");
              },
            ),
          ),
        ),
      ],
    );
  }
}

// --------------------------------------------------------------------------

// TODO: Create a button instead of setState on scrolling because it affects the
//       performance?
class TimePickerSpinner extends StatefulWidget {
  TimePickerSpinner({
    Key? key,
    this.time,
    this.minutesInterval = 1,
    this.secondsInterval = 1,
    this.is24HourMode = true,
    this.isShowSeconds = false,
    this.highlightedTextStyle,
    this.normalTextStyle,
    this.itemHeight = 60,
    this.itemWidth = 45,
    this.spacing = 20,
    this.alignment = Alignment.centerRight,
    this.isForce2Digits = false,
    required this.onTimeChange,
  }) : super(key: key);

  final DateTime? time;
  final int minutesInterval;
  final int secondsInterval;
  final bool is24HourMode;
  final bool isShowSeconds;
  final TextStyle? highlightedTextStyle;
  final TextStyle? normalTextStyle;
  final double itemHeight;
  final double itemWidth;
  final double spacing;
  final AlignmentGeometry? alignment;
  final bool isForce2Digits;
  final TimePickerCallback onTimeChange;

  @override
  _TimePickerSpinnerState createState() => new _TimePickerSpinnerState();
}

class _TimePickerSpinnerState extends State<TimePickerSpinner> {
  ScrollController hourController = new ScrollController();
  ScrollController minuteController = new ScrollController();
  ScrollController secondController = new ScrollController();
  ScrollController apController = new ScrollController();
  int currentSelectedHourIndex = -1;
  int currentSelectedMinuteIndex = -1;
  int currentSelectedSecondIndex = -1;
  int currentSelectedAPIndex = -1;
  DateTime? currentTime;
  bool isHourScrolling = false;
  bool isMinuteScrolling = false;
  bool isSecondsScrolling = false;
  bool isAPScrolling = false;

  /// default settings
  TextStyle defaultHighlightTextStyle = new TextStyle(fontSize: 32, color: Colors.white);
  TextStyle defaultNormalTextStyle = new TextStyle(fontSize: 32, color: Colors.white54);
  double defaultItemHeight = 60;
  double defaultItemWidth = 45;
  double defaultSpacing = 20;
  AlignmentGeometry defaultAlignment = Alignment.centerRight;

  /// getter

  TextStyle? _getHighlightedTextStyle() {
    return widget.highlightedTextStyle != null
        ? widget.highlightedTextStyle
        : defaultHighlightTextStyle;
  }

  TextStyle? _getNormalTextStyle() {
    return widget.normalTextStyle != null ? widget.normalTextStyle : defaultNormalTextStyle;
  }

  int _getHourCount() {
    return widget.is24HourMode ? 24 : 12;
  }

  int _getMinuteCount() {
    return (60 / widget.minutesInterval).floor();
  }

  int _getSecondCount() {
    return (60 / widget.secondsInterval).floor();
  }

  double _getItemHeight() {
    return widget.itemHeight != null ? widget.itemHeight : defaultItemHeight;
  }

  double? _getItemWidth() {
    return widget.itemWidth != null ? widget.itemWidth : defaultItemWidth;
  }

  double? _getSpacing() {
    return widget.spacing != null ? widget.spacing : defaultSpacing;
  }

  AlignmentGeometry? _getAlignment() {
    return widget.alignment != null ? widget.alignment : defaultAlignment;
  }

  bool isLoop(int value) {
    return value > 10;
  }

  DateTime getDateTime() {
    int hour = currentSelectedHourIndex - _getHourCount();
    if (!widget.is24HourMode && currentSelectedAPIndex == 2) hour += 12;
    int minute =
        (currentSelectedMinuteIndex - (isLoop(_getMinuteCount()) ? _getMinuteCount() : 1)) *
            widget.minutesInterval;
    int second =
        (currentSelectedSecondIndex - (isLoop(_getSecondCount()) ? _getSecondCount() : 1)) *
            widget.secondsInterval;
    return DateTime(
        currentTime!.year, currentTime!.month, currentTime!.day, hour, minute, second);
  }

  @override
  void initState() {
    currentTime = widget.time == null ? DateTime.now() : widget.time;

    currentSelectedHourIndex =
        (currentTime!.hour % (widget.is24HourMode ? 24 : 12)) + _getHourCount();
    hourController = new ScrollController(
        initialScrollOffset: (currentSelectedHourIndex - 1) * _getItemHeight());

    currentSelectedMinuteIndex = (currentTime!.minute / widget.minutesInterval).floor() +
        (isLoop(_getMinuteCount()) ? _getMinuteCount() : 1);
    minuteController = new ScrollController(
        initialScrollOffset: (currentSelectedMinuteIndex - 1) * _getItemHeight());
    print(currentSelectedMinuteIndex);
    print((currentSelectedMinuteIndex - 1) * _getItemHeight());

    currentSelectedSecondIndex = (currentTime!.second / widget.secondsInterval).floor() +
        (isLoop(_getSecondCount()) ? _getSecondCount() : 1);
    secondController = new ScrollController(
        initialScrollOffset: (currentSelectedSecondIndex - 1) * _getItemHeight());

    currentSelectedAPIndex = currentTime!.hour >= 12 ? 2 : 1;
    apController = new ScrollController(
        initialScrollOffset: (currentSelectedAPIndex - 1) * _getItemHeight());

    super.initState();

    if (widget.onTimeChange != null) {
      WidgetsBinding.instance!.addPostFrameCallback((_) => widget.onTimeChange(getDateTime()));
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(minuteController.offset);
    List<Widget> contents = [
      new SizedBox(
        width: _getItemWidth(),
        height: _getItemHeight() * 3,
        child: spinner(
          hourController,
          _getHourCount(),
          currentSelectedHourIndex,
          isHourScrolling,
          1,
          (index) {
            currentSelectedHourIndex = index;
            isHourScrolling = true;
          },
          () => isHourScrolling = false,
        ),
      ),
      spacer(),
      new SizedBox(
        width: _getItemWidth(),
        height: _getItemHeight() * 3,
        child: spinner(
          minuteController,
          _getMinuteCount(),
          currentSelectedMinuteIndex,
          isMinuteScrolling,
          widget.minutesInterval,
          (index) {
            currentSelectedMinuteIndex = index;
            isMinuteScrolling = true;
          },
          () => isMinuteScrolling = false,
        ),
      ),
    ];

    if (widget.isShowSeconds) {
      contents.add(spacer());
      contents.add(new SizedBox(
        width: _getItemWidth(),
        height: _getItemHeight() * 3,
        child: spinner(
          secondController,
          _getSecondCount(),
          currentSelectedSecondIndex,
          isSecondsScrolling,
          widget.secondsInterval,
          (index) {
            currentSelectedSecondIndex = index;
            isSecondsScrolling = true;
          },
          () => isSecondsScrolling = false,
        ),
      ));
    }

    if (!widget.is24HourMode) {
      contents.add(spacer());
      contents.add(new SizedBox(
        width: _getItemWidth()! * 1.2,
        // width: widget.itemWidth * 1.2,
        height: _getItemHeight() * 3,
        child: apSpinner(),
      ));
    }

    return new Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: contents,
    );
  }

  Widget spacer() {
    return new Container(
      width: _getSpacing(),
      height: _getItemHeight() * 3,
    );
  }

  Widget spinner(ScrollController controller, int max, int selectedIndex, bool isScrolling,
      int interval, SelectedIndexCallback onUpdateSelectedIndex, VoidCallback onScrollEnd) {
    /// wrapping the spinner with stack and add container above it when it's scrolling
    /// this thing is to prevent an error causing by some weird stuff like this
    /// flutter: Another exception was thrown: 'package:flutter/src/widgets/scrollable.dart': Failed assertion: line 469 pos 12: '_hold == null || _drag == null': is not true.
    /// maybe later we can find out why this error is happening

    Widget _spinner = NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        if (scrollNotification is UserScrollNotification) {
          if (scrollNotification.direction.toString() == "ScrollDirection.idle") {
            if (isLoop(max)) {
              int segment = (selectedIndex / max).floor();
              if (segment == 0) {
                onUpdateSelectedIndex(selectedIndex + max);
                controller.jumpTo(controller.offset + (max * _getItemHeight()));
              } else if (segment == 2) {
                onUpdateSelectedIndex(selectedIndex - max);
                controller.jumpTo(controller.offset - (max * _getItemHeight()));
              }
            }
            setState(() {
              onScrollEnd();
              if (widget.onTimeChange != null) {
                widget.onTimeChange(getDateTime());
              }
            });
          }
        } else if (scrollNotification is ScrollUpdateNotification) {
          setState(() {
            onUpdateSelectedIndex((controller.offset / _getItemHeight()).round() + 1);
          });
        }
        return true;
      },
      child: new ListView.builder(
        itemBuilder: (context, index) {
          String text = '';
          if (isLoop(max)) {
            text = ((index % max) * interval).toString();
          } else if (index != 0 && index != max + 1) {
            text = (((index - 1) % max) * interval).toString();
          }
          if (!widget.is24HourMode && controller == hourController && text == '0') {
            text = '12';
          }
          if (widget.isForce2Digits && text != '') {
            text = text.padLeft(2, '0');
          }
          return new Container(
            height: _getItemHeight(),
            alignment: _getAlignment(),
            child: new Text(
              text,
              style:
                  selectedIndex == index ? _getHighlightedTextStyle() : _getNormalTextStyle(),
            ),
          );
        },
        controller: controller,
        itemCount: isLoop(max) ? max * 3 : max + 2,
        physics: ItemScrollPhysics(itemHeight: _getItemHeight()),
        padding: EdgeInsets.zero,
      ),
    );

    return new Stack(
      children: <Widget>[
        Positioned.fill(child: _spinner),
        isScrolling
            ? Positioned.fill(
                child: new Container(
                color: Colors.black.withOpacity(0),
              ))
            : new Container()
      ],
    );
  }

  Widget apSpinner() {
    Widget _spinner = NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        if (scrollNotification is UserScrollNotification) {
          if (scrollNotification.direction.toString() == "ScrollDirection.idle") {
            isAPScrolling = false;
            if (widget.onTimeChange != null) {
              widget.onTimeChange(getDateTime());
            }
          }
        } else if (scrollNotification is ScrollUpdateNotification) {
          setState(() {
            currentSelectedAPIndex = (apController.offset / _getItemHeight()).round() + 1;
            isAPScrolling = true;
          });
        }
        return true;
      },
      child: new ListView.builder(
        itemBuilder: (context, index) {
          String text = index == 1 ? 'AM' : (index == 2 ? 'PM' : '');
          return new Container(
            height: _getItemHeight(),
            alignment: Alignment.center,
            child: new Text(
              text,
              style: currentSelectedAPIndex == index
                  ? _getHighlightedTextStyle()
                  : _getNormalTextStyle(),
            ),
          );
        },
        controller: apController,
        itemCount: 4,
        physics: ItemScrollPhysics(
          itemHeight: _getItemHeight(),
          targetPixelsLimit: 1,
        ),
      ),
    );

    return new Stack(
      children: <Widget>[
        Positioned.fill(child: _spinner),
        isAPScrolling ? Positioned.fill(child: new Container()) : new Container()
      ],
    );
  }
}

class ItemScrollPhysics extends ScrollPhysics {
  /// Creates physics for snapping to item.
  /// Based on PageScrollPhysics
  final double itemHeight;
  final double targetPixelsLimit;

  const ItemScrollPhysics({
    ScrollPhysics? parent,
    required this.itemHeight,
    this.targetPixelsLimit = 3.0,
    // TODO: Wth is this?
    // }) : assert(itemHeight != null && itemHeight > 0),
  }) : super(parent: parent);

  @override
  ItemScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return ItemScrollPhysics(parent: buildParent(ancestor), itemHeight: itemHeight);
  }

  double _getItem(ScrollPosition position) {
    double maxScrollItem = (position.maxScrollExtent / itemHeight).floorToDouble();
    return min(max(0, position.pixels / itemHeight), maxScrollItem);
  }

  double _getPixels(ScrollPosition position, double item) {
    return item * itemHeight;
  }

  double _getTargetPixels(ScrollPosition position, Tolerance tolerance, double velocity) {
    double item = _getItem(position);
    if (velocity < -tolerance.velocity)
      item -= targetPixelsLimit;
    else if (velocity > tolerance.velocity) item += targetPixelsLimit;
    return _getPixels(position, item.roundToDouble());
  }

  @override
  Simulation? createBallisticSimulation(ScrollMetrics position, double velocity) {
    // If we're out of range and not headed back in range, defer to the parent
    // ballistics, which should put us back in range at a item boundary.
//    if ((velocity <= 0.0 && position.pixels <= position.minScrollExtent) ||
//        (velocity >= 0.0 && position.pixels >= position.maxScrollExtent))
//      return super.createBallisticSimulation(position, velocity);
    Tolerance tolerance = this.tolerance;
    final double target = _getTargetPixels(position as ScrollPosition, tolerance, velocity);
    if (target != position.pixels)
      return ScrollSpringSimulation(spring, position.pixels, target, velocity,
          tolerance: tolerance);
    return null;
  }

  @override
  bool get allowImplicitScrolling => false;
}

/// Creates physics for snapping to item based on PageScrollPhysics.
/// https://github.com/flutter/flutter/blob/b1395592de/packages/flutter/lib/src/widgets/page_view.dart#L497
// TODO: Wtf is this?
// class ItemScrollPhysics extends ScrollPhysics {
//   const ItemScrollPhysics({
//     ScrollPhysics? parent,
//     required this.itemHeight,
//     this.targetPixelsLimit = 3.0,
//   })  : assert(itemHeight > 0),
//         super(parent: parent);
//
//   final double itemHeight;
//   final double targetPixelsLimit;
//
//   @override
//   ItemScrollPhysics applyTo(ScrollPhysics? ancestor) {
//     return ItemScrollPhysics(parent: buildParent(ancestor), itemHeight: itemHeight);
//   }
//
//   double _getItem(ScrollMetrics position) {
//     double maxScrollItem = (position.maxScrollExtent / itemHeight).floorToDouble();
//     return min(max(0, position.pixels / itemHeight), maxScrollItem);
//   }
//
//   double _getPixels(ScrollMetrics position, double item) {
//     return item * itemHeight;
//   }
//
//   double _getTargetPixels(ScrollMetrics position, Tolerance tolerance, double velocity) {
//     double item = _getItem(position);
//     if (velocity < -tolerance.velocity)
//       item -= targetPixelsLimit;
//     else if (velocity > tolerance.velocity) item += targetPixelsLimit;
//     return _getPixels(position, item.roundToDouble());
//   }
//
//   @override
//   Simulation? createBallisticSimulation(ScrollMetrics position, double velocity) {
//     // If we're out of range and not headed back in range, defer to the parent
//     // ballistics, which should put us back in range at a item boundary.
//     // if ((velocity <= 0.0 && position.pixels <= position.minScrollExtent) ||
//     //     (velocity >= 0.0 && position.pixels >= position.maxScrollExtent))
//     //   return super.createBallisticSimulation(position, velocity);
//     Tolerance tolerance = this.tolerance;
//     final double target = _getTargetPixels(position, tolerance, velocity);
//     if (target != position.pixels)
//       return ScrollSpringSimulation(spring, position.pixels, target, velocity,
//           tolerance: tolerance);
//     return null;
//   }
//
//   @override
//   bool get allowImplicitScrolling => false;
// }
