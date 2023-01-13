import 'package:get/get.dart';

import '../controllers/lembar_jawab_controller.dart';

class LembarJawabBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LembarJawabController>(
      () => LembarJawabController(),
    );
  }
}
