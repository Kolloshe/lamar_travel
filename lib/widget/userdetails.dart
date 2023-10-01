import 'package:flutter/material.dart';

import '../../config.dart';

class UserTextfom extends StatelessWidget {
  const UserTextfom(
      {Key? key,
      required this.controller,
      required this.title,
      required this.keybordType})
      : super(key: key);

  final TextEditingController controller;
  final String title;
  final TextInputType keybordType;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.all(5),
      height: size.height * 0.07,
      child: TextFormField(
        keyboardType: keybordType,
        controller: controller,
        decoration: InputDecoration(
          labelText: title,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(color: primaryblue),
          ),
          //fillColor: Colors.green
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Fill your $title.';
          }
          return null;
        },
      ),
    );
  }
}
