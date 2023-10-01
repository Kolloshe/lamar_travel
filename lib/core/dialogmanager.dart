import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lamar_travel_packages/config.dart';
import 'package:sizer/sizer.dart';

class DialogManager {
  showPopUP(BuildContext context, {required bool flight, required bool hotel}) async {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Material(
        color: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: cardcolor,
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.all(8),
          width: 80.w,
          height: 60.h,
          child: Column(
            children: [
              SizedBox(
                width: 100.w,
                child: Row(
                  children: [
                    SizedBox(width: 70.w, height: 8.h, child: TextFormField()),
                 const   Icon(CupertinoIcons.search),
                  ],
                ),
              ),
              SizedBox(
                height: 50.h,
                width: 100.w,
                child: ListView.builder(
                    itemCount: 15,
                    itemBuilder: (_, i) => Container(
                          height: 4.h,
                          width: 100.w,
                          color: Colors.amber,
                        )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
