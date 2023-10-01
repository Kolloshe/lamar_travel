
 class DynamicLinksService {

//
//    static Future<Uri?> initDynamicLinks(BuildContext context) async {
//      //final PendingDynamicLinkData? data = await FirebaseDynamicLinks.instance.getInitialLink();
// Uri? deep;
//    //  _handleDynamicLink(data!);
//  FirebaseDynamicLinks.instance.onLink;
//      FirebaseDynamicLinks.instance.onLink(
//          onSuccess: (PendingDynamicLinkData? dynamicLink) async {
//          final deep=  await _handleDynamicLink(dynamicLink!);
//
//          return deep;
//          },
//          onError: ( e) async {
//        print('onLinkError');
//        print(e.message);
// deep =null;
//      });
//      return deep;
//    }
//
//    static _handleDynamicLink(PendingDynamicLinkData? data) async {
//
//      final Uri? deepLink = data!.link;
//      print(deepLink.toString()+'>>>>');
//      if (deepLink == null) return;
//
//        return deepLink;
//      if (deepLink.pathSegments.contains('refer')) {
//        var title = deepLink.queryParameters['code'];
//        if (title != null) {
//          print("refercode=$title");
//
//
//        }
//      }
//
//    }


//    static Future<void> initDynamicLinks() async {
//      FirebaseDynamicLinks.instance.onLink(
//          onSuccess: (PendingDynamicLinkData? dynamicLink) async {
//            final Uri? deepLink = dynamicLink?.link;
// print(dynamicLink!.link);
//            if (deepLink != null) {
//              // ignore: unawaited_futures
//
//            }
//          }, onError: (OnLinkErrorException e) async {
//        print('onLinkError');
//        print(e.message);
//      });
//    }

 }
