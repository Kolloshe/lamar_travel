// ignore_for_file: implementation_imports, library_private_types_in_public_api

import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_number_picker/flutter_number_picker.dart';
import 'package:lamar_travel_packages/Datahandler/app_data.dart';
import 'package:lamar_travel_packages/Model/individual_services_model/privet_jet_category_model.dart';
import 'package:lamar_travel_packages/screen/newsearch/newSearch-datePicker.dart';
import 'package:lamar_travel_packages/screen/newsearch/new_search_room_passinger.dart';
import 'package:lamar_travel_packages/widget/individual_products/ind_user_input_field.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/src/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../config.dart';
import '../../main_screen1.dart';

class PrivetJetForm extends StatefulWidget {
  const PrivetJetForm({Key? key}) : super(key: key);

  @override
  _PrivetJetFormState createState() => _PrivetJetFormState();
}

class _PrivetJetFormState extends State<PrivetJetForm> {
  Categories? minCategory;
  TripType? _tripType = TripType.one;
  int pax = 1;
  PrivetJetCategoryModel? privetJetCategories;

  Time _time = Time(hour: 12, minute: 00);

  @override
  void initState() {
    privetJetCategories = context.read<AppData>().getPrivetJetCategories;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        foregroundColor: blackTextColor,
        backgroundColor: Colors.white,
        title: Text(
          'Privet Jet Form',
          style: TextStyle(fontSize: 10.sp),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Trip type:', style: TextStyle(fontSize: 12.sp)),
              SizedBox(height: 1.h),
              SizedBox(
                  width: 100.w,
                  height: 5.h,
                  child: Row(children: [
                    SizedBox(
                        width: 40.w,
                        child: RadioListTile<TripType>(
                            title: const Text('one'),
                            controlAffinity: ListTileControlAffinity.platform,
                            onChanged: (TripType? value) {
                              setState(() {
                                _tripType = value;
                              });
                            },
                            groupValue: _tripType,
                            value: TripType.one)),
                    SizedBox(
                        width: 40.w,
                        child: RadioListTile<TripType>(
                            title: const Text('round'),
                            onChanged: (TripType? value) {
                              setState(() {
                                _tripType = value;
                              });
                            },
                            groupValue: _tripType,
                            value: TripType.round))
                  ])),
              SizedBox(height: 1.h),
              const UserInputField(title: 'Email'),
              SizedBox(height: 1.5.h),
              const UserInputField(title: 'First name'),
              SizedBox(height: 1.5.h),
              const UserInputField(title: 'Last Name'),
              SizedBox(height: 1.5.h),
              const UserInputField(title: 'Phone number'),
              SizedBox(height: 1.5.h),
              _buildPrivetJet(),
              SizedBox(height: 2.h),
              SizedBox(child: Text('Departure Time', style: TextStyle(fontSize: 12.sp))),
              InkWell(
                onTap: () {
                  DateTime? data;
                  Navigator.of(context).push(
                    showPicker(
                      context: context,
                      value: _time,
                      sunrise: const TimeOfDay(hour: 6, minute: 0), // optional
                      sunset: const TimeOfDay(hour: 18, minute: 0), // optional
                      duskSpanInMinutes: 120, // optional
                      onChange: (v) {},
                      onChangeDateTime: (time) {
                        data = time;
                      },
                    ),
                  );

                  setState(() {});

                  // final data = await TimePicker.show(
                  //   context: context,
                  //   sheet: TimePickerSheet(
                  //     sheetTitle: 'Select departure Time',
                  //     hourTitle: 'Hour',
                  //     minuteTitle: 'Minute',
                  //     saveButtonText: 'Save',
                  //     minuteInterval: 1,
                  //     sheetCloseIconColor: primaryblue,
                  //     minuteTitleStyle: TextStyle(color: primaryblue, fontSize: 12.sp),
                  //     hourTitleStyle: TextStyle(color: primaryblue, fontSize: 12.sp),
                  //     wheelNumberSelectedStyle: TextStyle(color: primaryblue, fontSize: 12.sp),
                  //     saveButtonColor: primaryblue,
                  //   ),
                  // );
                  // if (kDebugMode) {
                  //   print(data);
                  // }
                  //showTimePicker(context: context, initialTime: TimeOfDay.now());
                  // showDatePicker(context: context,
                  //     initialDate: DateTime.now(),
                  //     firstDate: DateTime.now(), lastDate: DateTime.now().add(Duration(days: 900)));
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: const Text('date'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPrivetJet() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.pax,
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.normal),
              ),
              CustomNumberPicker(
                w: 7.w,
                valueTextStyle: TextStyle(fontSize: 14.sp),
                shape: const RoundedRectangleBorder(side: BorderSide.none),
                initialValue: pax,
                maxValue: 30,
                minValue: 1,
                step: 1,
                onValue: (step) {
                  int x = int.parse(step.toString());
                  pax = x;
                },
                customAddButton: customNumberPickerIcon(iconData: Icons.add, ontap: () {}),
                customMinusButton: customNumberPickerIcon(iconData: MdiIcons.minus, ontap: () {}),
              ),
            ],
          ),
        ),
        SizedBox(height: 1.h),
        InkWell(
          onTap: _showMinCategory,
          child: SizedBox(
            width: 100.w,
            height: 6.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.minCategory,
                      style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text(
                      minCategory?.name ?? '',
                      style: TextStyle(color: Colors.grey, fontSize: 10.sp),
                    ),
                  ],
                ),
                const Icon(Icons.keyboard_arrow_down)
              ],
            ),
          ),
        )
      ],
    );
  }

  _showMinCategory() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => Container(
              color: Colors.white,
              width: 100.w,
              padding: const EdgeInsets.all(10).copyWith(bottom: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 100.w,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        AppLocalizations.of(context)!.minCategory,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                    child: Column(
                      children: [
                        for (int i = 0; i < privetJetCategories!.data.length; i++)
                          _buildCategoryItem(privetJetCategories!.data[i])
                      ],
                    ),
                  ))
                ],
              ),
            ));
  }

  _buildCategoryItem(Categories item) => InkWell(
        onTap: () {
          minCategory = item;

          if (item.name.contains('>19 PAX')) {
            pax = 19;
            displayTostmessage(context, false,
                message: AppLocalizations.of(context)!.atLestPax, isInformation: true);
          }
          setState(() {});
          Navigator.of(context).pop();
        },
        child: ListTileTheme(
          selectedTileColor: primaryblue,
          selectedColor: primaryblue,
          child: ListTile(
            horizontalTitleGap: 0,
            minVerticalPadding: 0,
            minLeadingWidth: 1,
            selected: item == minCategory ? true : false,
            leading: item == minCategory ? const Icon(Icons.done) : null,
            title: Text(
              item.name,
              style: TextStyle(fontSize: 12.sp),
            ),
          ),
        ),
      );
}
