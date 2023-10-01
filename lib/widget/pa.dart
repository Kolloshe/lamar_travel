// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class Bairds extends StatefulWidget {
  static String idScreen = 'Bairds';
  const Bairds({Key? key}) : super(key: key);

  @override
  _BairdsState createState() => _BairdsState();
}

class _BairdsState extends State<Bairds> {
  late RiveAnimationController _controller;

  // Toggles between play and pause animation states
  void _togglePlay() =>
      setState(() => _controller.isActive = !_controller.isActive);

  /// Tracks if the animation is playing by whether controller is running
  bool get isPlaying => _controller.isActive;

  @override
  void initState() {
    super.initState();
    _controller = SimpleAnimation('wings');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RiveAnimation.asset(
          'assets/images/flarebarid.riv',
          controllers: [_controller],
          // Update the play state when the widget's initialized
          onInit: (_) => setState(() {}),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _togglePlay,
        tooltip: isPlaying ? 'Pause' : 'Play',
        child: Icon(
          isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
