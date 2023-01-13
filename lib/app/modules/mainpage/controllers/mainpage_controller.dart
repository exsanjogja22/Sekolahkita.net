import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../main.dart';

class MainpageController extends GetxController {
  final pageControl = PageController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxString version = "".obs;
  RxInt selectIndex = 0.obs;

  ontapKonten(int index) {
    selectIndex.value = index;
    update();
    pageControl.jumpToPage(
      selectIndex.value,
    );
    update();
  }

  Future<void> launchURL() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String packageName = packageInfo.packageName;
    if (!await launchUrl(
        Uri.parse("https://play.google.com/store/apps/details?id=$packageName"),
        mode: LaunchMode.externalApplication)) {
      throw 'Could not launch https://play.google.com/store/apps/details?id=$packageName';
    }
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> cekUpdateApp() async* {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version.value = packageInfo.version;
    String packageName = packageInfo.packageName;
    final documentStream = FirebaseFirestore.instance
        .collection('update-android-app')
        .doc(packageName)
        .snapshots();
    yield* documentStream;
  }

  @override
  void onInit() {
    super.onInit();
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (kDebugMode) {
        print('A new onMessageOpenedApp event was published!');
      }
      if (message?.data['url'] != null) {}
    });

    var initialzationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
        InitializationSettings(android: initialzationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                icon: android.smallIcon,
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? message) {
      if (kDebugMode) {
        print('A new onMessageOpenedApp event was published!');
      }

      if (message?.data['url'] != null) {}
    });
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            MacOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
    super.onInit();
  }
}
