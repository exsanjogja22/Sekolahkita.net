import 'package:get/get.dart';

import '../controllers/e_konseling_controller.dart';

class EKonselingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EKonselingController>(
      () => EKonselingController(),
    );
  }
}
