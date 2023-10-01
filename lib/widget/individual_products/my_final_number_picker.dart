// ignore_for_file: library_private_types_in_public_api, unused_element

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_number_picker/flutter_number_picker.dart';

class MyFinalNumberPicker<T extends num> extends StatefulWidget {
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

  MyFinalNumberPicker(
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
  _MyFinalNumberPickerState createState() => _MyFinalNumberPickerState();
}

class _MyFinalNumberPickerState<T extends num> extends State<MyFinalNumberPicker> {
  late num _initialValue;
  late num _maxValue;
  late num _minValue;
  late num _step;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _initialValue = widget.initialValue;
    _maxValue = widget.maxValue;
    _minValue = widget.minValue;
    _step = widget.step;
  }

  @override
  Widget build(BuildContext context) {
    _maxValue = widget.maxValue;
    _minValue = widget.minValue;
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
              child: widget.customMinusButton ??
                  const Padding(
                      padding: EdgeInsets.only(left: 6, right: 6, bottom: 6, top: 6),
                      child: Icon(Icons.remove)),
            ),
            SizedBox(
              width: widget.w,
              // width: _textSize(widget.valueTextStyle ?? TextStyle(fontSize: 14)).width,
              child: Text(
                "$_initialValue",
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
              child: widget.customAddButton ??
                  const Padding(
                      padding: EdgeInsets.only(left: 6, right: 6, bottom: 6, top: 6),
                      child: Icon(Icons.add)),
            )
          ],
        ),
      ),
    );
  }

  Size _textSize(TextStyle style) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: _maxValue.toString(), style: style),
        maxLines: 1,
        textDirection: TextDirection.rtl)
      ..layout(minWidth: 0, maxWidth: _maxValue.toString().length * style.fontSize!);
    return textPainter.size;
  }

  void minus() {
    if (canDoAction(DoAction.MINUS)) {
      setState(() {
        _initialValue -= _step;
      });
      widget.onValue(_initialValue as T, DoAction.MINUS);
    } else {
      widget.onValue(_initialValue as T, DoAction.LIMIT);
    }
  }

  void add() {
    if (canDoAction(DoAction.ADD)) {
      setState(() {
        _initialValue += _step;
      });
      widget.onValue(_initialValue as T, DoAction.ADD);
    } else {
      widget.onValue(_initialValue as T, DoAction.LIMIT);
    }
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
      return _initialValue - _step >= _minValue;
    }
    if (action == DoAction.ADD) {
      return _initialValue + _step <= _maxValue;
    }
    return false;
  }
}
