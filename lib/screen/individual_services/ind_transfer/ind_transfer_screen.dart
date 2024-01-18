// ignore_for_file: library_private_types_in_public_api

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lamar_travel_packages/Assistants/assistant_methods.dart';
import 'package:lamar_travel_packages/Model/individual_services_model/indv_packages_listing_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lamar_travel_packages/screen/individual_services/ind_transfer/ind_transfer_customize_screen.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../../config.dart';

class IndTransferScreen extends StatefulWidget {
  const IndTransferScreen({Key? key, required this.transfer, required this.price, required this.id})
      : super(key: key);
  final List<IndTransfer> transfer;
  final num price;
  final String id;

  @override
  _IndTransferScreenState createState() => _IndTransferScreenState();
}

class _IndTransferScreenState extends State<IndTransferScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final result = await AssistantMethods.indTransferCustomize(widget.id);
        if (result != null) {
          if (!mounted) return;
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => IndTransferCustomizeScreen(
                    customize: result,
                    id: widget.id,
                  )));
        }
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(5),
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white, boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              spreadRadius: 1,
              offset: const Offset(2, 2))
        ]),
        child: _buildTransferData(widget.transfer),
      ),
    );
  }

  Widget _buildTransferData(List<IndTransfer> transfer) {
    return Column(
      children: [
        for (int i = 0; i < transfer.length; i++)
          Row(
            children: [
              SizedBox(
                width: 20.w,
                height: 20.h,
                child: CachedNetworkImage(
                  imageUrl: transfer[i].image,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(width: 2.w),
              SizedBox(
                  width: 47.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.type,
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: subtitleFontSize),
                      ),
                      Text("${transfer[i].serviceTypeName} ${transfer[i].vehicleTypeName}",
                          style: TextStyle(
                            fontSize: detailsFontSize,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          softWrap: false),
                      Text(
                        AppLocalizations.of(context)?.dates ?? "",
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: subtitleFontSize),
                      ),
                      Text(DateFormat('dd MMM EEEE').format(transfer[i].date),
                          style: TextStyle(
                            fontSize: detailsFontSize,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          softWrap: false),
                      Text(AppLocalizations.of(context)!.pickup,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: subtitleFontSize,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          softWrap: false),
                      Text(transfer[i].pickUp,
                          style: TextStyle(
                            fontSize: detailsFontSize,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          softWrap: false),
                      Text(AppLocalizations.of(context)!.dropOff,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: subtitleFontSize,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          softWrap: false),
                      Text(transfer[i].dropOff,
                          style: TextStyle(
                            fontSize: detailsFontSize,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          softWrap: false),
                      const SizedBox(height: 10),
                      transfer.last == transfer[i]
                          ? const SizedBox(height: 0)
                          : Divider(
                              color: Colors.black.withOpacity(.3),
                            ),
                    ],
                  )),
              transfer.last == transfer[i]
                  ? SizedBox(
                      height: 20.h,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        children: [Text("${widget.price} ${transfer[i].currency}")],
                      ),
                    )
                  : const SizedBox()
            ],
          )
      ],
    );
  }
}
