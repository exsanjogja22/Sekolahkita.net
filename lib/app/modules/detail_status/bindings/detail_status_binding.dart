import 'package:get/get.dart';

import '../controllers/detail_status_controller.dart';

class DetailStatusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailStatusController>(
      () => DetailStatusController(),
    );
  }
}
