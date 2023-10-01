// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import '../../config.dart';

class RequestToBook extends StatefulWidget {
  const RequestToBook({Key? key}) : super(key: key);

  @override
  _RequestToBookState createState() => _RequestToBookState();
}

class _RequestToBookState extends State<RequestToBook> {
  bool requireaSmokingRoom = false;
  bool requestRoomonaLowFloor = false;
  bool honeymoonTrip = false;
  bool celebratingBirthday = false;
  bool requireaNonSmokingRoom = false;
  bool requestRoomonaHighFloor = false;
  bool requestforaBabyCot = false;
  bool celebratingAnniversary = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    return Container(
      color: cardcolor,
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: SizedBox(
              width: width,
              height: height,
              child: Column(
                children: [
                  CheckboxListTile(
                    title: const Text('Require a Smoking Room'),
                    value: requireaSmokingRoom,
                    onChanged: (v) {
                      setState(() {
                        requireaSmokingRoom = v!;
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Require a Non Smoking Room'),
                    value: requireaNonSmokingRoom,
                    onChanged: (v) {
                      setState(() {
                        requireaNonSmokingRoom = v!;
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Request Room on a Low Floor'),
                    value: requestRoomonaLowFloor,
                    onChanged: (v) {
                      setState(() {
                        requestRoomonaLowFloor = v!;
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Request Room on a High Floor'),
                    value: requestRoomonaHighFloor,
                    onChanged: (v) {
                      setState(() {
                        requestRoomonaHighFloor = v!;
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Honeymoon Trip'),
                    value: honeymoonTrip,
                    onChanged: (v) {
                      setState(() {
                        honeymoonTrip = v!;
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Request for a Baby Cot'),
                    value: requestforaBabyCot,
                    onChanged: (v) {
                      setState(() {
                        requestforaBabyCot = v!;
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Celebrating Birthday'),
                    value: celebratingBirthday,
                    onChanged: (v) {
                      setState(() {
                        celebratingBirthday = v!;
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Celebrating Anniversary'),
                    value: celebratingAnniversary,
                    onChanged: (v) {
                      setState(() {
                        celebratingAnniversary = v!;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: width,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text('Continue'),
                    ),
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
