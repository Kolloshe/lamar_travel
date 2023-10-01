// ignore_for_file: library_private_types_in_public_api

import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

class ImageSpinning extends StatefulWidget {
  const ImageSpinning({Key? key, required this.withOpasity}) : super(key: key);

  final bool withOpasity;

  @override
  _ImageSpinningState createState() => _ImageSpinningState();
}

class _ImageSpinningState extends State<ImageSpinning> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 3))..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:   const Color.fromARGB(240, 255, 255, 255),
        body: Center(
      child: Container(
        color: const Color.fromARGB(240, 255, 255, 255),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (_, child) {
            return Transform.rotate(
              angle: _controller.value * 5 * math.pi,
              child: Opacity(
                  opacity: widget.withOpasity ? 0.5 : 1,
                  child: Image.asset(
                    'assets/images/lamarlogo/spininglogo.png',
                    width: 15.w,
                  )),
            );
          },
          child: Container(
        color:  const Color.fromARGB(240, 255, 255, 255),
            child: Image.asset(
              'assets/images/lamarlogo/spininglogo.png',
              width: 15.w,
            ),
          ),
        ),
      ),
    ));
  }
}
