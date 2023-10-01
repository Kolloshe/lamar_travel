// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import '../../Datahandler/adaptive_texts_size.dart';
import '../../config.dart';
import '../../widget/userdetails.dart';

class Yourdetails extends StatefulWidget {
  const Yourdetails({Key? key}) : super(key: key);

  @override
  _YourdetailsState createState() => _YourdetailsState();
}

class _YourdetailsState extends State<Yourdetails> {
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    return Container(
      color: cardcolor,
      child: SafeArea(
        child: Scaffold(
          body: Card(
            child: SizedBox(
              width: width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 10).copyWith(bottom: 5),
                    child: Text(
                      'Enter User Details',
                      style: TextStyle(
                          fontSize: const AdaptiveTextSize().getadaptiveTextSize(context, 30),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(height: 20),
                  UserTextfom(
                    keybordType: TextInputType.name,
                    controller: firstname,
                    title: 'First Name',
                  ),
                  UserTextfom(
                    keybordType: TextInputType.name,
                    controller: lastname,
                    title: 'Last name / Surname',
                  ),
                  UserTextfom(
                    keybordType: TextInputType.emailAddress,
                    controller: email,
                    title: 'Email',
                  ),
                  UserTextfom(
                    keybordType: TextInputType.phone,
                    controller: phoneNumber,
                    title: 'Phone with ISD Code',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
