import 'package:flutter/material.dart';
import 'package:petner_web/utils/firebase_messaging_service.dart';
import 'package:petner_web/utils/notification_service.dart';
import 'package:petner_web/utils/routes.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    initilizeFirebaseMessaging();
    checkNotifications();
  }

  initilizeFirebaseMessaging() async {
    await Provider.of<FirebaseMessagingService>(context, listen: false)
        .initialize();
  }

  checkNotifications() async {
    await Provider.of<NotificationService>(context, listen: false)
        .checkForNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Petner',
      routes: Routes.list,
      initialRoute: Routes.initial,
      navigatorKey: Routes.navigatorKey,
    );
  }
}
