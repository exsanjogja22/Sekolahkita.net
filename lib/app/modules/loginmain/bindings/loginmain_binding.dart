import 'package:get/get.dart';

import '../controllers/loginmain_controller.dart';

class LoginmainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginmainController>(
      () => LoginmainController(),
    );
  }
}
