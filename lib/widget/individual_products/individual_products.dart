import 'package:flutter/material.dart';
//import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:lamar_travel_packages/Assistants/assistant_methods.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//import 'package:facebook_app_events/facebook_app_events.dart';
import '../../Datahandler/app_data.dart';
import '../../screen/newsearch/new_search.dart';

class IndividualProducts extends StatelessWidget {
  // static final facebookAppEvents = FacebookAppEvents();

  const IndividualProducts(
      {Key? key, required this.title, required this.subtitle, required this.image})
      : super(key: key);

  final String title;
  final String subtitle;
  final String image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // facebookAppEvents.setAutoLogAppEventsEnabled(true);
        // facebookAppEvents.setAdvertiserTracking(enabled: true);
        // facebookAppEvents.logEvent(name: 'search_buttons', parameters: {"Description": this.title});

        switch (title) {
          case 'Holiday packages':
            {
              context.read<AppData>().searchMode = '';
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SearchStepper(
                        searchMode: '',
                        section: -1,
                        isFromNavBar: false,
                      )));

              break;
            }
          case 'Flights':
            {
              context.read<AppData>().searchMode = 'flight';
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SearchStepper(
                        section: -1,
                        isFromNavBar: false,
                      )));
              break;
            }
          case 'Hotels':
            {
              context.read<AppData>().searchMode = 'hotel';

              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SearchStepper(
                        searchMode: title,
                        section: 0,
                        isFromNavBar: false,
                      )));
              break;
            }
          case 'Transfers':
            {
              context.read<AppData>().searchMode = 'transfer';
              // Navigator.of(context)
              //     .push(MaterialPageRoute(builder: (context) => IndTransferScreen()));
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SearchStepper(
                        section: -2,
                        isFromNavBar: false,
                      )));
              break;
            }
          case 'Activities':
            {
              context.read<AppData>().searchMode = 'activity';
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SearchStepper(
                        searchMode: title,
                        section: 0,
                        isFromNavBar: false,
                      )));
              break;
            }
          case 'Travel insurance':
            {
              context.read<AppData>().searchMode = 'Travel insurance';
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SearchStepper(
                        searchMode: title,
                        section: -1,
                        isFromNavBar: false,
                      )));
              break;
            }
          case 'Privet jet':
            {
              context.read<AppData>().searchMode = 'privet jet';
              AssistantMethods.getPrivetJetCategories(context);

              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SearchStepper(
                        searchMode: title,
                        section: -1,
                        isFromNavBar: false,
                      )));
              break;
            }

          default:
            {
              break;
            }
        }
      },
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            width: 25.w,
            height: 25.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                )),
            child: Stack(
              children: [
                Positioned(
                    top: 10,
                    left: 10,
                    right: 10,
                    child: Text('',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white,
                            fontFamily: Provider.of<AppData>(context, listen: false).locale ==
                                    const Locale('en')
                                ? 'Lato'
                                : 'Bhaijaan'))),
                //   Positioned(bottom: 0, left: 0, right: 0, child: Text(hundelSectionName(this.subtitle,context)))
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(hundelSectionName(title, context),
              style: TextStyle(
                  fontSize: 10.sp,
                  fontFamily:
                      Provider.of<AppData>(context, listen: false).locale == const Locale('en')
                          ? 'Lato'
                          : 'Bhaijaan'))
        ],
      ),
    );
  }

  String hundelSectionName(String sectionName, BuildContext context) {
    switch (sectionName) {
      case 'Flights':
        {
          return AppLocalizations.of(context)!.flights;
        }
      case 'Hotels':
        {
          return AppLocalizations.of(context)!.hotels;
        }
      case 'Transfers':
        {
          return AppLocalizations.of(context)!.transfers;
        }
      case 'Activities':
        {
          return AppLocalizations.of(context)!.activities;
        }
      case 'Privet jet':
        {
          return AppLocalizations.of(context)!.privetJet;
        }
      case 'Travel insurance':
        {
          return AppLocalizations.of(context)!.travelInsurance;
        }
      default:
        {
          return sectionName;
        }
    }
  }
}
