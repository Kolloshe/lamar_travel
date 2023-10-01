// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import '../screen/main_screen1.dart';
import '../setting/setting.dart';

import '../config.dart';

class HolidaysHeder extends StatefulWidget {
  const HolidaysHeder({Key? key}) : super(key: key);

  @override
  _HolidaysHederState createState() => _HolidaysHederState();
}

class _HolidaysHederState extends State<HolidaysHeder> {
  bool iconControl = true;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.white,
      leading: Padding(
        padding: const EdgeInsets.only(left: 5),
        child: InkWell(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const MainScreen(),
              ),
            );
          },
          child: Image.asset(
            'assets/images/mascot+logo1.png',
            width: 72,
            height: 30,
          ),
        ),
      ),
      actions: [
        Image.asset(
          'assets/images/vectors/Vector.png',
          width: 22,
          height: 22,
        ),
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, Setting.idscreen);
          },
          icon: Icon(
            //idscreen == 'Setting' ? Icons.close :
            Icons.menu,
            size: 30.51,
            color: black,
          ),
        ),
      ],
    );
  }
}
