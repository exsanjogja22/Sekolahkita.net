import 'package:get/get.dart';

import '../controllers/tugas_aktif_controller.dart';

class TugasAktifBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TugasAktifController>(
      () => TugasAktifController(),
    );
  }
}
