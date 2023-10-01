import 'package:flutter/material.dart';
import 'package:lamar_travel_packages/config.dart';
import 'package:sizer/sizer.dart';

class UserInputField extends StatelessWidget {
  final TextEditingController? controller;
  final String title;
  final String? Function(String?)? validator;
  final String? helpText;
  final bool? redOnly;
  final Function()? onTap;
  final Widget? prefix;
  const UserInputField(
      {Key? key,
      required this.title,
      this.controller,
      this.validator,
      this.helpText,
      this.redOnly,
      this.onTap,
      this.prefix})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      style: TextStyle(fontSize: 12.sp),
      controller: controller,
      validator: validator,
      readOnly: redOnly ?? false,
      cursorColor: primaryblue,
      decoration: InputDecoration(
        prefix: prefix,
        prefixStyle: TextStyle(fontSize: 10.sp),
        focusColor: Colors.red,
        labelStyle: TextStyle(color: blackTextColor, fontSize: 12.sp),
        filled: true,
        helperMaxLines: 1,
        labelText: title,
        helperText: helpText,
        border: InputBorder.none,
      ),
    );
  }
}
