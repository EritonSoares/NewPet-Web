import 'package:flutter/widgets.dart';
import 'package:petner_web/pages/splashScreen_page.dart';


class Routes {
  static Map<String, Widget Function(BuildContext)> list =
      <String, WidgetBuilder>{
    '/splash': (_) => const SplashScreen(),
  };

  static String initial = '/splash';

  static GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();
}
