import 'package:flutter/widgets.dart';
import 'package:petner_web/pages/service/service_query.dart';
import 'package:petner_web/pages/splashScreen_page.dart';


class Routes {
  static Map<String, Widget Function(BuildContext)> list =
      <String, WidgetBuilder>{
    '/splash': (_) => const SplashScreen(),
    '/serviceQuery': (_) => const ServiceQueryPage(),
  };

  static String initial = '/splash';

  static GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();
}
