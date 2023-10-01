// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lamar_travel_packages/Assistants/assistant_methods.dart';
import 'package:lamar_travel_packages/config.dart';
import 'package:lamar_travel_packages/screen/main_screen1.dart';
import 'package:sizer/sizer.dart';


class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Reset you password',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: cardcolor,
        centerTitle: true,
        elevation: 0.1,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.keyboard_arrow_left,
              color: primaryblue,
              size: 30.sp,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            SizedBox(
              width: 100.w,
              child: Text(
                'Please enter the Email that linked with this Account',
                style: TextStyle(fontSize: titleFontSize),
              ),
            ),
            _buildSpacer(0, 4),
            TextFormField(
              controller: email,
              decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  hintText: 'example @ example.com'),
              //   InputDecoration(border: InputBorder.none, hintText: 'example @ example.com'),
            ),
            SizedBox(
              height: 5.h,
            ),
            SizedBox(
              width: 100.w,
              height: 7.h,
              child: ElevatedButton(
                onPressed: () {
                  if (email.text.isEmpty || email.text.isEmpty) {
                    displayTostmessage(context, true, message: 'please enter your email first ');
                    return;
                  }
                  callresetPassword(email.text, context);
                },
                style: ElevatedButton.styleFrom(backgroundColor: primaryblue),
                child: Text(
                  'Reset the password',
                  style: TextStyle(fontSize: titleFontSize),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  callresetPassword(String email, BuildContext context) async {
    Map<String, dynamic> userEmail = {'email': email};
    String data = jsonEncode(userEmail);
    await AssistantMethods.resetPassword(data, context);
  }

  Widget _buildSpacer(double w, double h) => SizedBox(height: h.h, width: w.w);
}
