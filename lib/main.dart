import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:smkn1contoh/app/config/app_name.dart';
import 'app/data/providers/network/repository/auth_repositori.dart';
import 'app/modules/login/views/login_view.dart';
import 'app/modules/widget/splash_screen.dart';
import 'app/routes/app_pages.dart';
import 'firebase_options.dart';

// firebase cloude messaging hendeling
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // ignore: avoid_print
  print('Handling a background message ${message.messageId}');
}

late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FlutterDownloader.initialize(debug: true, ignoreSsl: true);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
    );
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  // intl hendeling
  await initializeDateFormatting('id_ID', null)
      .then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(const Duration(seconds: 3)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ScreenUtilInit(
              designSize: const Size(360, 800),
              minTextAdapt: true,
              splitScreenMode: true,
              builder: (context, child) {
                return const MaterialApp(
                    debugShowCheckedModeBanner: false, home: SplashScreen());
              },
              child: const SplashScreen());
        } else {
          return FutureBuilder<String?>(
            future: ApiAuth().getToken(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return ScreenUtilInit(
                    designSize: const Size(360, 800),
                    minTextAdapt: true,
                    splitScreenMode: true,
                    builder: (context, child) {
                      return const MaterialApp(
                          debugShowCheckedModeBanner: false,
                          home: SplashScreen());
                    },
                    child: const SplashScreen());
              } else {
                return ScreenUtilInit(
                    designSize: const Size(360, 800),
                    minTextAdapt: true,
                    splitScreenMode: true,
                    builder: (context, child) {
                      return GetMaterialApp(
                        title: AppName.namaSekolah,
                        initialRoute: snapshot.data != null
                            ? Routes.MAINPAGE
                            : Routes.LOGIN,
                        getPages: AppPages.routes,
                        theme: ThemeData(
                          textTheme: TextTheme(
                            headline5: GoogleFonts.quicksand(fontSize: 12.sp),
                            headline6: GoogleFonts.quicksand(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        debugShowCheckedModeBanner: false,
                      );
                    },
                    child: const LoginView());
              }
            },
          );
        }
      },
    );
  }
}
