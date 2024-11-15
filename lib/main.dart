import 'package:fichas_med_app/firebase_options.dart';
import 'package:fichas_med_app/routes/applicationRoutes.dart';
import 'package:fichas_med_app/sharePreferences/userPreferences.dart';
import 'package:fichas_med_app/store/AppStore.dart';
import 'package:fichas_med_app/utils/AppTheme.dart';
import 'package:fichas_med_app/utils/MLDataProvider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

AppStore appStore = AppStore();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Background Message: ${message.notification?.title} - ${message.notification?.body}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Retrieve and print the FCM token
  final token = await FirebaseMessaging.instance.getToken();
  print("Firebase Messaging Token: $token");

  // Register background message handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Setup in-app message listeners
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print("Foreground Message: ${message.notification?.title} - ${message.notification?.body}");
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print("Opened App from Message: ${message.notification?.title} - ${message.notification?.body}");
  });

  // Initialize other services
  await initialize(aLocaleLanguageList: languageList());
  appStore.toggleDarkMode(value: getBoolAsync('isDarkModeOnPref'));

  defaultRadius = 10;
  defaultToastGravityGlobal = ToastGravity.BOTTOM;

  final prefs = UserPreferences();
  await prefs.initPrefs();

    runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: '${'MediLab'}${!isMobile ? ' ${platformName()}' : ''}',
        initialRoute: '/',
        routes: getApplicationRoutes(),
        theme: appStore.isDarkModeOn ? AppThemeData.darkTheme : AppThemeData.lightTheme,
        navigatorKey: navigatorKey,
        scrollBehavior: SBehavior(),
      ),
    );
  }
}
