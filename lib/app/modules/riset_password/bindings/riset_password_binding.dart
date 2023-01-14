import 'package:get/get.dart';

import '../controllers/riset_password_controller.dart';

class RisetPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RisetPasswordController>(
      () => RisetPasswordController(),
    );
  }
}
