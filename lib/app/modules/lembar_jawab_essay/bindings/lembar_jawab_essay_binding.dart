import 'package:get/get.dart';

import '../controllers/lembar_jawab_essay_controller.dart';

class LembarJawabEssayBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LembarJawabEssayController>(
      () => LembarJawabEssayController(),
    );
  }
}
