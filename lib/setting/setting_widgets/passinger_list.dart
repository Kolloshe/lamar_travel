// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:lamar_travel_packages/Assistants/assistant_methods.dart';
import 'package:lamar_travel_packages/Datahandler/app_data.dart';
import 'package:lamar_travel_packages/Model/login/user.dart';
import 'package:lamar_travel_packages/screen/customize/new-customize/new_customize.dart';
import 'package:lamar_travel_packages/setting/setting_widgets/editing-passinger.dart';
import 'package:provider/provider.dart';
import '../../config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:sizer/sizer.dart';

class PassingerList extends StatefulWidget {
  const PassingerList({Key? key}) : super(key: key);

  @override
  _PassingerListState createState() => _PassingerListState();
}

class _PassingerListState extends State<PassingerList> {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation, DeviceType deviceType) => Scaffold(
        appBar: AppBar(
          backgroundColor: cardcolor,
          elevation: 0.2,
          centerTitle: true,
          title: Text(
            AppLocalizations.of(context)!.passengers,
            style: TextStyle(color: Colors.black, fontSize: titleFontSize),
          ),
          leading: IconButton(
            icon: Icon(
              Provider.of<AppData>(context, listen: false).locale == const Locale('en')
                  ? Icons.keyboard_arrow_left
                  : Icons.keyboard_arrow_right,
              color: primaryblue,
              size: 30.sp,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 80.h,
                  child: users.data.passengers != null && users.data.passengers!.isNotEmpty
                      ? Consumer<AppData>(
                          builder: (context, data, child) => ListView.separated(
                            separatorBuilder: (context, index) => SizedBox(
                              width: 100.w,
                              child: Divider(
                                color: Colors.black.withOpacity(0.1),
                              ),
                            ),
                            itemCount:
                                users.data.passengers != null ? users.data.passengers!.length : 0,
                            itemBuilder: (context, index) => _buildPassingerCard(
                                index, data.userupadate!.data.passengers![index]),
                          ),
                        )
                      : const Center(
                          child: Text('No Saved Passenger yet.. '),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPassingerCard(int index, Passengers? data) {
    return Container(
      width: 100.w,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        boxShadow: [shadow],
        color: cardcolor,
      ),
      child: Row(
        children: [
          Container(
              margin: const EdgeInsets.only(right: 5),
              padding: const EdgeInsets.all(10),
              decoration:
                  BoxDecoration(color: blackTextColor.withOpacity(0.5), shape: BoxShape.circle),
              child: const Icon(
                Icons.person,
                color: Colors.white,
              )),
          SizedBox(
            width: 2.w,
          ),
          SizedBox(
            width: 50.w,
            child: Text(
              data != null
                  ? '${data.name} ${data.surname}'
                  : '${users.data.passengers![index].name} ${users.data.passengers![index].surname}',
              style: TextStyle(
                  fontSize: titleFontSize, fontWeight: FontWeight.w500, letterSpacing: 0.5),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () async {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        content: Text(
                          AppLocalizations.of(context)!.rUSureToRemovePassenger,
                          style: TextStyle(fontSize: titleFontSize),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                AppLocalizations.of(context)!.cancel,
                                style: TextStyle(
                                  color: greencolor,
                                ),
                              )),
                          TextButton(
                              onPressed: () async {
                                //  Navigator.of(context).pop();
                                pressIndcatorDialog(context);

                                await AssistantMethods.removePassenger(
                                    users.data.passengers![index].id, context);
                                    if (!mounted) return;
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                AppLocalizations.of(context)!.remove,
                                style: const TextStyle(
                                  color: Colors.redAccent,
                                ),
                              ))
                        ],
                      ));

              setState(() {});
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.redAccent,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => EditingPassenger(
                        passengers: users.data.passengers![index],
                      )));
            },
            icon: Icon(
              Icons.edit,
              color: primaryblue,
            ),
          ),
        ],
      ),
    );

    // Card(
    //   elevation: 7,
    //   color: cardcolor,
    //   child: Padding(
    //     padding: EdgeInsets.all(2.h),
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.start,
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Row(
    //           children: [
    //             Text(
    //               'Name : ',
    //               style: TextStyle(
    //                   fontSize: fontsSize, fontWeight: FontWeight.w500),
    //             ),
    //             SizedBox(
    //               width: 65.w,
    //               child: Text(
    //                 users.data.passengers![index].name +
    //                     ' ' +
    //                     users.data.passengers![index].surname,
    //                 style: TextStyle(fontSize: fontsSize),
    //                 maxLines: 1,
    //                 overflow: TextOverflow.ellipsis,
    //                 softWrap: false,
    //               ),
    //             ),
    //           ],
    //         ),
    //         Row(
    //           children: [
    //             Text(
    //               'Passport Number : ',
    //               style: TextStyle(
    //                   fontSize: fontsSize, fontWeight: FontWeight.w500),
    //             ),
    //             SizedBox(
    //               width: 35.w,
    //               child: Text(
    //                 users.data.passengers![index].passportNumber,
    //                 style: TextStyle(fontSize: fontsSize),
    //                 maxLines: 1,
    //                 overflow: TextOverflow.ellipsis,
    //                 softWrap: false,
    //               ),
    //             ),
    //           ],
    //         ),
    //   users.data.passengers![index].passportExpirityDate!= null?      Row(
    //           children: [
    //             Text('Passport Expiry : ',
    //                 style: TextStyle(
    //                     fontSize: fontsSize, fontWeight: FontWeight.w500)),
    //             Text(
    //               DateFormat('yyyy-MM-dd')
    //                   .format(users.data.passengers![index].passportExpirityDate!),
    //               style: TextStyle(fontSize: fontsSize),
    //             )
    //           ],
    //         ):SizedBox(),
    //         users.data.passengers![index].birthdate!=null?
    //         Row(
    //           children: [
    //             Text('birthdate : ',
    //                 style: TextStyle(
    //                     fontSize: fontsSize, fontWeight: FontWeight.w500)),
    //             Text(
    //               DateFormat('yyyy-MM-dd')
    //                   .format(users.data.passengers![index].birthdate!),
    //               style: TextStyle(fontSize: fontsSize),
    //             )
    //           ],
    //         ):SizedBox(),
    //       ],
    //     ),
    //   ),
    // );
  }
}
