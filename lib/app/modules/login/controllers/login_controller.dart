import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginController extends GetxController {
  RxString version = "".obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<void> launchURLStore() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String packageName = packageInfo.packageName;

    if (!await launchUrl(
        Uri.parse("https://play.google.com/store/apps/details?id=$packageName"),
        mode: LaunchMode.externalApplication)) {
      throw 'Could not launch https://play.google.com/store/apps/details?id=$packageName';
    }
  }

  Future<void> launchURL(String url) async {
    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
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
}
