import 'package:get/get.dart';

import '../controllers/komentar_status_controller.dart';

class KomentarStatusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KomentarStatusController>(
      () => KomentarStatusController(),
    );
  }
}
