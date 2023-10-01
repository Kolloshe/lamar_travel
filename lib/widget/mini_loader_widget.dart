// ignore_for_file: library_private_types_in_public_api

import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:rive/rive.dart';

class MiniLoader extends StatefulWidget {
  const MiniLoader({super.key});

  @override
  _MiniLoaderState createState() => _MiniLoaderState();
  static String idScreen = 'MiniLoader';
  static String animation = 'wings';
}

class _MiniLoaderState extends State<MiniLoader> with TickerProviderStateMixin {
  late AnimationController _animationControllerBird;
  late Animation<Offset> _animationBird;

  late AnimationController _animationControllerCloud;
  late Animation<Offset> _animationCloud;

  late RiveAnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SimpleAnimation(MiniLoader.animation);

    _birdLoadingAnimation();
    _cloudLoadingAnimation();
  }

  _birdLoadingAnimation() {
    _animationControllerBird =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));

    _animationBird = Tween<Offset>(begin: const Offset(0.03, 0.08), end: const Offset(0.0, 0.05))
        .animate(_animationControllerBird);

    _animationBird.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // print('Animation loading ');

        _animationControllerBird.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _animationControllerBird.forward();
      }
    });

    _animationControllerBird.forward();
  }

  _cloudLoadingAnimation() {
    _animationControllerCloud =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 5000));

    _animationCloud = Tween<Offset>(begin: const Offset(-3, 7), end: const Offset(4, 8))
        .animate(_animationControllerCloud);

    _animationCloud.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationControllerCloud.reset();
        _animationControllerCloud.forward();
      } else if (status == AnimationStatus.dismissed) {
        _animationControllerCloud.forward();
      }
    });

    _animationControllerCloud.forward();
  }

  Widget _buildCloud({double? top, double? right, double? bottom, double? left, double? scale}) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: SlideTransition(
        position: _animationCloud,
        child: Opacity(
          opacity: 0.5,
          child: Image.asset(
            'assets/images/loading/cloud.png',
            scale: scale,
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingContent() {
    final double deviceWidth = MediaQuery.of(context).size.width / 2;
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.white.withAlpha(130),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
          child: Visibility(
            visible: true,
            child: Stack(
              children: <Widget>[
                _buildCloud(top: -150.0, left: deviceWidth - 20, scale: 5.0),
                _buildCloud(top: -350.0, right: deviceWidth - 25, scale: 5.0),
                _buildCloud(top: -800.0, left: deviceWidth - 5, scale: 3.0),
                _buildCloud(top: -1200.0, right: deviceWidth - 5, scale: 3.0),
                //  _buildBaird(),
                Center(
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: RiveAnimation.asset(
                      'assets/images/flarbaird.riv',
                      controllers: [_controller],

                      // Update the play state when the widget's initialized
                      onInit: (_) => setState(() {
                        _controller = SimpleAnimation(MiniLoader.animation);
                      }),
                      animations: const [
                        'wings'
                            'done'
                      ],
                    ),
                  ),
                ),
                _buildCloud(top: -1600.0, left: deviceWidth - 25, scale: 5.0),
                _buildCloud(top: -1200.0, right: deviceWidth - 25, scale: 5.0),
                _buildCloud(top: -1400.0, left: deviceWidth - 5, scale: 3.0),
                _buildCloud(top: -1600.0, right: deviceWidth - 5, scale: 3.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: Colors.blue.withAlpha(130),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: <Widget>[
              // BackgroundSlider(widget.model),
              _buildLoadingContent(),
              
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationControllerBird.dispose();
    _animationControllerCloud.dispose();
    _controller.dispose();
    super.dispose();
  }
}
