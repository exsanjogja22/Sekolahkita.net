import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../controllers/post_presensi_controller.dart';
import '../controllers/presensi_controller.dart';
import '../controllers/setting_controller.dart';
import '../controllers/forum_controller.dart';
import '../controllers/mainpage_controller.dart';

class MainpageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForumController>(
      () => ForumController(),
    );
    Get.lazyPut<PostPresensiController>(
      () => PostPresensiController(),
    );
    Get.lazyPut<SettingController>(
      () => SettingController(),
    );

    Get.lazyPut<PresensiController>(
      () => PresensiController(),
    );

    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<MainpageController>(
      () => MainpageController(),
    );
  }
}
