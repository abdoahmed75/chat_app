import 'dart:async';

import 'package:chat_app/constants/app_theme.dart';
import 'package:chat_app/constants/strings.dart';
import 'package:chat_app/pages/landing_page.dart';
import 'package:chat_app/services/auth.dart';
import 'package:chat_app/services/notification.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:chat_app/localization/app_localization.dart';
import 'package:chat_app/routes/app_pages.dart';
import 'package:chat_app/routes/app_routes.dart';
import 'package:chat_app/utils/constants.dart';
import 'controllers/localization_controller.dart';
import 'controllers/theme_controller.dart';

RemoteMessage? initMsg;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

Future<void> main() async {

  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await GetStorage.init();
    Get.put(ThemeController());
    Get.put(LocalizationController());
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    initMsg = await FirebaseMessaging.instance.getInitialMessage();
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    runApp(DevicePreview(
      builder: (context) => MyApp(),
      enabled: !kReleaseMode,
    ));
  },
      (error, stack) =>
          FirebaseCrashlytics.instance.recordError(error, stack, fatal: true));
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final NotificationBase notification = FirebaseNotification()..initialize();
  final _controllerT = Get.find<ThemeController>();
  final _controllerL = Get.find<LocalizationController>();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controllerL.changeLanguage( GetStorage().read(Keys.LOCALIZATION_KEY));
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthBase>(create: (_) => Auth()),
        Provider<NotificationBase>(create: (_) => notification),
      ],
      child:  GetMaterialApp(
      title: 'Targlob',
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      theme: ThemeController.lightThemeData,
      darkTheme: ThemeController.darkThemeData,
      themeMode: _controllerT.theme,
      translationsKeys: AppTranslation.translationsKeys,
      getPages: AppPages.pages,
      initialRoute: Routes.INITIAL,
      locale:Locale( _controllerL.lang),
    ),
    );
  }
}
