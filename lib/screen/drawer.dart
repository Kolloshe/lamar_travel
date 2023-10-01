import 'package:flutter/material.dart';
import '../config.dart';

class Drawer extends StatelessWidget {
  const Drawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: background,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(),
        ),
      ),
    );
  }
}
