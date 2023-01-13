import 'package:get/get.dart';

import '../controllers/kamera_helper_controller.dart';

class KameraHelperBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KameraHelperController>(
      () => KameraHelperController(),
    );
  }
}
