import 'package:get/get.dart';

import '../controllers/add_satatus_controller.dart';

class AddSatatusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddSatatusController>(
      () => AddSatatusController(),
    );
  }
}
