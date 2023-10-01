import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:lamar_travel_packages/Assistants/assistant_methods.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../Datahandler/app_data.dart';
import '../../config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class BillingInformationScreen extends StatefulWidget {
  const BillingInformationScreen({super.key});

  @override
  State<BillingInformationScreen> createState() => _BillingInformationScreenState();
}

class _BillingInformationScreenState extends State<BillingInformationScreen> {
  final billingStreet1Controller = TextEditingController();
  final billingCityController = TextEditingController();
  final billingStateController = TextEditingController();
  final billingCountryController = TextEditingController();
  final billingPostCodeController = TextEditingController();

  final _billingInformationData = BillingInformationData();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    final user = context.read<AppData>().userupadate;

    if (user == null) return;
    billingCityController.text = user.data.city ?? '';
    billingCountryController.text = user.data.country ?? 'Saudi Arabia';
    _billingInformationData.billingCountry = 'SA';
    billingPostCodeController.text = user.data.postalCode ?? '';
    billingStreet1Controller.text = user.data.address ?? '';
    billingStateController.text = user.data.city ?? '';
    super.initState();
  }

  @override
  void dispose() {
    billingStreet1Controller.dispose();
    billingCityController.dispose();
    billingStateController.dispose();
    billingCountryController.dispose();
    billingPostCodeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: cardcolor,
            elevation: 0.2,
            centerTitle: true,
            title: Text(
              AppLocalizations.of(context)!.billingInformation,
              style: TextStyle(color: Colors.black, fontSize: titleFontSize),
            ),
            leading: IconButton(
                icon: Icon(
                    Provider.of<AppData>(context, listen: false).locale == const Locale('en')
                        ? Icons.keyboard_arrow_left
                        : Icons.keyboard_arrow_right,
                    color: primaryblue,
                    size: 30.sp),
                onPressed: () {
                  Navigator.of(context).pop();
                })),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInformationFeild(
                        title: 'Billing street',
                        data: '',
                        keyboard: TextInputType.streetAddress,
                        controller: billingStreet1Controller,
                        validation: (v) {
                          if (v == null || v.isEmpty) {
                            return 'This feild is required';
                          } else {
                            return null;
                          }
                        }),
                    _buildInformationFeild(
                        title: 'Billing city',
                        data: '',
                        keyboard: TextInputType.streetAddress,
                        controller: billingCityController,
                        validation: (v) {
                          if (v == null || v.isEmpty) {
                            return 'This feild is required';
                          } else {
                            return null;
                          }
                        }),
                    _buildInformationFeild(
                        title: 'Billing state',
                        data: '',
                        keyboard: TextInputType.streetAddress,
                        controller: billingStateController,
                        validation: (v) {
                          if (v == null || v.isEmpty) {
                            return 'This feild is required';
                          } else {
                            return null;
                          }
                        }),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      SizedBox(
                        width: 46.w,
                        child: _buildInformationFeild(
                            title: 'Billing postcode',
                            data: '',
                            keyboard: TextInputType.number,
                            controller: billingPostCodeController,
                            validation: (v) {
                              if (v == null || v.isEmpty) {
                                return 'This feild is required';
                              } else {
                                return null;
                              }
                            }),
                      ),
                      SizedBox(
                        width: 48.w,
                        child: _buildInformationFeild(
                            onTap: () {
                              showCountryPicker(
                                  context: context,
                                  onSelect: (country) {
                                    billingCountryController.text = country.name;
                                    _billingInformationData.billingCountry = country.countryCode;
                                    setState(() {});
                                  });
                            },
                            title: 'Billing country',
                            data: '',
                            keyboard: TextInputType.streetAddress,
                            controller: billingCountryController,
                            validation: (v) {
                              if (v == null || v.isEmpty) {
                                return 'This feild is required';
                              } else {
                                return null;
                              }
                            }),
                      ),
                    ]),
                    SizedBox(height: 5.h),
                    ElevatedButton(
                      onPressed: updateBillingInformation,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: primaryblue, fixedSize: Size(95.w, 7.h)),
                      child: Text(
                        AppLocalizations.of(context)!.update,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInformationFeild(
          {required String? Function(String?)? validation,
          required String title,
          required String data,
          void Function()? onTap,
          required TextEditingController controller,
          required TextInputType keyboard}) =>
      Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(5),
        child: TextFormField(
          onTap: onTap,
          readOnly: onTap == null ? false : true,
          onChanged: (v) {
            setState(() {});
          },
          validator: validation,
          controller: controller,
          keyboardType: keyboard,
          style: TextStyle(color: blackTextColor, fontWeight: FontWeight.w400, fontSize: 12.sp),
          decoration: InputDecoration(
            labelStyle:
                TextStyle(color: blackTextColor, fontWeight: FontWeight.bold, fontSize: 12.sp),
            labelText: title,
            hintText: data,
            hintStyle:
                TextStyle(color: blackTextColor, fontWeight: FontWeight.w600, fontSize: 12.sp),
          ),
        ),
      );

  void updateBillingInformation() async {
    final userData = context.read<AppData>().userupadate;

    if (userData == null) return;

    final req = {
      // "email": userData.data.email,
      // "first_name": userData.data.name,
      // "last_name": userData.data.lastName,
      // "phone": userData.data.phone,
      "city": billingCityController.text,
      "country": billingCountryController.text,
      "country_code": _billingInformationData.billingCountry,
      "postal_code": billingPostCodeController.text,
      "address": billingStreet1Controller.text,
      "state": billingStateController.text,
      "city_code": ""
    };

    final result = await AssistantMethods.updateBillingInformation(context, data: req);
    if (result) {
      if (!mounted) return;
      Navigator.of(context).pop(result);
    }
  }
}

class BillingInformationData {
  String billingStreet1;
  String billingCity;
  String billingState;
  String billingCountry;
  String billingPostCode;
  BillingInformationData({
    this.billingStreet1 = '',
    this.billingCity = '',
    this.billingState = '',
    this.billingCountry = 'SA',
    this.billingPostCode = '',
  });

  Map<String, dynamic> toJson() => {
        "billing.street1": billingStreet1,
        "billing.city": billingCity,
        "billing.state": billingState,
        "billing.country": billingCountry,
        "billing.postcode": billingPostCode,
      };
}
