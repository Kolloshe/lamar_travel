// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:lamar_travel_packages/Assistants/assistant_methods.dart';
import 'package:lamar_travel_packages/config.dart';
import 'package:sizer/sizer.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();

  final password = TextEditingController();
  final oldpassword = TextEditingController();
  final confirmpassword = TextEditingController();
  @override
  void dispose() {
    password.dispose();
    oldpassword.dispose();
    confirmpassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => Container(
        color: Colors.white,
        width: 100.w,
        height: 100.h,
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              elevation: 0.1,
              title: const Text(
                'Change Password',
                style: TextStyle(color: Colors.black),
              ),
              centerTitle: true,
              backgroundColor: cardcolor,
              leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.keyboard_arrow_left,
                    size: 30.sp,
                    color: primaryblue,
                  )),
            ),
            body: Column(
              children: [_buildTextcurrentPassword()],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextcurrentPassword() => Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                obscureText: true,
                controller: oldpassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter old password';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'old password',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter new password';
                  }
                  return null;
                },
                obscureText: true,
                controller: password,
                decoration: const InputDecoration(
                  labelText: 'new password',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty || password.text != confirmpassword.text) {
                    return 'Please Confirm the password';
                  }
                  return null;
                },
                obscureText: true,
                controller: confirmpassword,
                decoration: const InputDecoration(
                  labelText: 'Confirm password',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate() == false) return;

                  await AssistantMethods.changethepassword(
                      password.text, oldpassword.text, confirmpassword.text, context);
                },
                style: ElevatedButton.styleFrom(backgroundColor: primaryblue, fixedSize: Size(100.w, 7.h)),
                child: const Text('Change Password'),
              )
            ],
          ),
        ),
      );
}
