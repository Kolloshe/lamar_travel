// ignore_for_file: unused_element

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_number_picker/flutter_number_picker.dart';
import 'package:lamar_travel_packages/Datahandler/app_data.dart';
import 'package:provider/provider.dart';

class MyCustomNumberPicker<T extends num> extends StatefulWidget {
  final ShapeBorder? shape;
  final TextStyle? valueTextStyle;
  final Function(T, DoAction) onValue;
  final Widget? customAddButton;
  final Widget? customMinusButton;

  final T maxValue;
  final T minValue;
  final T initialValue;
  final T step;
  final double w;

  ///default vale true
  final bool enable;

  MyCustomNumberPicker(
      {Key? key,
      this.shape,
      this.valueTextStyle,
      required this.onValue,
      required this.initialValue,
      required this.maxValue,
      required this.minValue,
      required this.step,
      required this.w,
      this.customAddButton,
      this.customMinusButton,
      this.enable = true})
      : assert(initialValue.runtimeType != String),
        assert(maxValue.runtimeType == initialValue.runtimeType),
        assert(minValue.runtimeType == initialValue.runtimeType),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MyCustomNumberPickerState();
  }
}

class MyCustomNumberPickerState<T extends num> extends State<MyCustomNumberPicker<T>> {
  late num _maxValue;
  late num _minValue;
  late num _step;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _maxValue = widget.maxValue;
    _minValue = widget.minValue;
    _step = widget.step;
  }

  @override
  Widget build(BuildContext context) {

    return IgnorePointer(
      ignoring: !widget.enable,
      child: Card(
        shadowColor: Colors.transparent,
        elevation: 0.0,
        semanticContainer: true,
        color: Colors.transparent,
        shape: widget.shape ??
            const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(0.0)),
                side: BorderSide(width: 1.0, color: Color(0xffF0F0F0))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: minus,
                onTapDown: (details) {
                  onLongPress(DoAction.MINUS);
                },
                onTapUp: (details) {
                  _timer?.cancel();
                },
                onTapCancel: () {
                  _timer?.cancel();
                },
                child: widget.customMinusButton),
            SizedBox(
              width: widget.w,
              // width: _textSize(widget.valueTextStyle ?? TextStyle(fontSize: 14)).width,
              child: Text(
                context.read<AppData>().paxCount.toString(),
                style: widget.valueTextStyle ?? const TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
            GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: add,
                onTapDown: (details) {
                  onLongPress(DoAction.ADD);
                },
                onTapUp: (details) {
                  _timer?.cancel();
                },
                onTapCancel: () {
                  _timer?.cancel();
                },
                child: widget.customAddButton)
          ],
        ),
      ),
    );
  }

  Size _textSize(TextStyle style) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: _maxValue.toString(), style: style),
      maxLines: 1,
    )..layout(minWidth: 0, maxWidth: _maxValue.toString().length * style.fontSize!);
    return textPainter.size;
  }

  void minus() {
    if (canDoAction(DoAction.MINUS)) {
      setState(() {
        context.read<AppData>().setPax = context.read<AppData>().getPax - _step.toInt();
      });
    }
    widget.onValue(context.read<AppData>().getPax as T, DoAction.MINUS);
  }

  void add() {
    if (canDoAction(DoAction.ADD)) {
      setState(() {
        context.read<AppData>().setPax = context.read<AppData>().getPax + _step.toInt();
      });
    }
    widget.onValue(context.read<AppData>().getPax as T, DoAction.ADD);
  }

  void onLongPress(DoAction action) {
    var timer = Timer.periodic(const Duration(milliseconds: 300), (t) {
      action == DoAction.MINUS ? minus() : add();
    });
    setState(() {
      _timer = timer;
    });
  }

  bool canDoAction(DoAction action) {
    if (action == DoAction.MINUS) {
      return context.read<AppData>().getPax - _step >= _minValue;
    }
    if (action == DoAction.ADD) {
      return context.read<AppData>().getPax <= _maxValue;
    }
    return false;
  }
}
