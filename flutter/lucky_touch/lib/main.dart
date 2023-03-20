import 'package:flutter/material.dart';
import 'package:lucky_touch/beanResponse/notification_model.dart';
import 'package:lucky_touch/globles.dart';
import 'package:lucky_touch/providers/custom_ticket_model.dart';
import 'package:lucky_touch/providers/model_add_tickets.dart';
import 'package:lucky_touch/providers/model_admin_chats.dart';
import 'package:lucky_touch/providers/model_all_users.dart';
import 'package:lucky_touch/providers/model_ban_users.dart';

import 'package:lucky_touch/providers/model_bottom_navigation_bar.dart';
import 'package:lucky_touch/providers/model_chats.dart';
import 'package:lucky_touch/providers/model_get_all_ticket_buyers.dart';
import 'package:lucky_touch/providers/model_get_golden_ticket_buyers.dart';
import 'package:lucky_touch/providers/model_get_platinum_ticket_buyers.dart';
import 'package:lucky_touch/providers/model_get_silver_ticket_buyers.dart';
import 'package:lucky_touch/providers/model_golden_ticket_screen.dart';
import 'package:lucky_touch/providers/model_my_tickets.dart';
import 'package:lucky_touch/providers/model_new_users.dart';
import 'package:lucky_touch/providers/model_online_users.dart';
import 'package:lucky_touch/providers/model_platinum_ticket_screen.dart';
import 'package:lucky_touch/providers/model_reset_password.dart';
import 'package:lucky_touch/providers/model_signin.dart';
import 'package:lucky_touch/providers/model_signup.dart';
import 'package:lucky_touch/providers/model_silver_ticket_screen.dart';
import 'package:lucky_touch/providers/model_winners_screen.dart';
import 'package:lucky_touch/screens/splash_screen.dart';
import 'package:lucky_touch/webservice/servicewrapper.dart';

import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workmanager/workmanager.dart';
import 'package:firebase_core/firebase_core.dart';

const simplePeriodicTask = "SimplePeriodicTask";

void showNotification(id, v, flp) async {
  var android = AndroidNotificationDetails('channel id', "channel Name",
      priority: Priority.high, importance: Importance.max);
  var ios = IOSNotificationDetails();
  var platform = NotificationDetails(android: android, iOS: ios);
  await flp.show(id, "Lucky Touch", '$v', platform, payload: "VIS \n $v");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await Workmanager().initialize(callbackDispatcher, isInDebugMode: false);
  await Workmanager().registerPeriodicTask("S", simplePeriodicTask,
      existingWorkPolicy: ExistingWorkPolicy.replace,
      frequency: Duration(minutes: 15),
      initialDelay: Duration(seconds: 5),
      constraints: Constraints(networkType: NetworkType.connected));
  runApp(const MyApp());

  OneSignal.shared.setLogLevel(OSLogLevel.debug, OSLogLevel.none);
  OneSignal.shared.setAppId('dd96ae3d-6e96-4ac3-890a-c8723cc03ad5');
  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    print("accespt permission: $accepted");
  });
}

void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    FlutterLocalNotificationsPlugin flp = FlutterLocalNotificationsPlugin();
    var android = AndroidInitializationSettings('@mipmap/ic_launcher');
    var ios = IOSInitializationSettings();
    var initSettings = InitializationSettings(android: android, iOS: ios);
    flp.initialize(initSettings);

    NotificationModel? model;
    Servicewrapper wrapper = new Servicewrapper();
    var res = await wrapper.getNotifications();

    final Map<String, dynamic> parsed = res;
    model = NotificationModel.fromJson(parsed);

//----------call api get data
    if (model.data != null && model.data!.length > 0) {
      for (int i = 0; i < model.data!.length; i++) {
        showNotification(i, '${model.data?[i]?.notiText ?? ''}', flp);
      }
    }

    return Future.value(true);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: ((context) => ModelBottomNavigationBar())),
        ChangeNotifierProvider(create: ((context) => ModelSignUp())),
        ChangeNotifierProvider(create: ((context) => ModelSignIn())),
        ChangeNotifierProvider(create: ((context) => ModelAddTickets())),
        ChangeNotifierProvider(
            create: ((context) => ModelGoldenTicketScreen())),
        ChangeNotifierProvider(create: ((context) => ModelCustomTicket())),
        ChangeNotifierProvider(
            create: ((context) => ModelSilverTicketScreen())),
        ChangeNotifierProvider(
            create: ((context) => ModelPlatinumTicketScreen())),
        ChangeNotifierProvider(create: ((context) => ModelMyTickets())),
        ChangeNotifierProvider(
            create: ((context) => ModelGetGoldenTicketBuyers())),
        ChangeNotifierProvider(
            create: ((context) => ModelGetSilverTicketBuyers())),
        ChangeNotifierProvider(
            create: ((context) => ModelGetPlatinumTicketBuyers())),
        ChangeNotifierProvider(create: ((context) => ModelWinnersScreen())),
        ChangeNotifierProvider(create: ((context) => ModelChats())),
        ChangeNotifierProvider(create: ((context) => ModelOnlineUsers())),
        ChangeNotifierProvider(create: ((context) => ModelNewUsers())),
        ChangeNotifierProvider(create: ((context) => ModelAdminChats())),
        ChangeNotifierProvider(create: ((context) => ModelAllUsers())),
        ChangeNotifierProvider(create: ((context) => ModelResetPassword())),
        ChangeNotifierProvider(create: ((context) => ModelBanUsers())),
        ChangeNotifierProvider(create: ((context) => ModelGetAllTicketBuyers())),
      ],
      builder: ((context, child) => MaterialApp(
          scaffoldMessengerKey: snackbarKey,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              fontFamily: 'Poppins',
              primarySwatch: Colors.red,
              primaryColor: Colors.redAccent,
              scaffoldBackgroundColor: Colors.white),
          builder: (context, child) => ResponsiveWrapper.builder(
                child,
                maxWidth: 1200,
                minWidth: 480,
                defaultScale: true,
                breakpoints: [
                  const ResponsiveBreakpoint.resize(480, name: MOBILE),
                  const ResponsiveBreakpoint.autoScale(800, name: TABLET),
                  const ResponsiveBreakpoint.resize(1000, name: DESKTOP),
                ],
                background: Container(
                  color: const Color(0xFFFF5F5),
                ),
              ),
          home: SplashScreen())),
    );
  }
}
