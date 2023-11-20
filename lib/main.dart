import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:softpro_support/config/global/widgets/project_app_bar.dart';
import 'package:softpro_support/config/theme/app_theme.dart';
import 'package:softpro_support/contracts_notifier.dart';
import 'package:softpro_support/screens/Details/customers_details.dart';
import 'package:softpro_support/screens/logIn/checkLogInScreen.dart';
import 'package:softpro_support/screens/logIn/logInScreen.dart';

import 'package:softpro_support/screens/task/add_task.dart';
import 'package:softpro_support/task_notifier.dart';
import 'package:softpro_support/theme_notifier.dart';
import 'package:softpro_support/screens/base/base_screen.dart';
import 'package:provider/provider.dart';
import 'customers_notifier.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'firebase_options.dart';
















@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupFlutterNotifications();
  showFlutterNotification(message);
      
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print('Handling a background message ${message.messageId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;

Future<void> setupFlutterNotifications() async {
  
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );


  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
      

      

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
    
  );
  isFlutterLocalNotificationsInitialized = true;
  
}

void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null && !kIsWeb) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          // TODO add a proper drawable resource to android, for now using
          //      one that already exists in example app.
          icon: 'launch_background',
        ),
      ),
    );
  }
}

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;



void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (!kIsWeb) {
    await setupFlutterNotifications();
  }
  runApp(const MyApp());
  // runApp(
  //   DevicePreview(
  //     builder: (context) => const MyApp(),
  //     enabled: !kReleaseMode,
  //   ),
  // );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: const Size(428, 926),
      builder: (context, child) => MultiProvider(
         providers: [
        ChangeNotifierProvider<CustomerNotifier>(create: (_) => CustomerNotifier()),
        ChangeNotifierProvider<ThemeNotifier>(create: (_) => ThemeNotifier()),
          ChangeNotifierProvider<TaskNotifier>(create: (_) => TaskNotifier()),
             ChangeNotifierProvider<ContractNotifier>(create: (_) => ContractNotifier()),
      ],
        child: Consumer<ThemeNotifier>(
          builder: (context, ThemeNotifier themeNotifier, child) => MaterialApp(
            debugShowCheckedModeBanner: false,
            theme:
                themeNotifier.isDark ? AppTheme.darkMode : AppTheme.lightMode,
            home: const CheckLogInScreen(),
           
          ),
        ),
      ),
    );
  }
}
