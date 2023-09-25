import 'package:flutter/widgets.dart';
import 'package:petner_web/pages/home/home_page.dart';
import 'package:petner_web/pages/service/consultation_room.dart';
import 'package:petner_web/pages/service/service_query.dart';
import 'package:petner_web/pages/splashScreen_page.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> list =
      <String, WidgetBuilder>{
    '/splash': (_) => const SplashScreen(),
    '/serviceQuery': (_) => const ServiceQueryPage(),
    '/home': (_) => const HomePage(),
    '/consultationRoom': (context) {
      final args = ModalRoute.of(context)!.settings.arguments as Map;
      return ConsultationRoomPage(
        token: args['token'],
        channel: args['channel'],
        crmv: args['crmv'],
      );
    },
  };

  static String initial = '/splash';

  static GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();
}
