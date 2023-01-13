import 'package:get/get.dart';

import '../controllers/list_materi_controller.dart';

class ListMateriBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListMateriController>(
      () => ListMateriController(),
    );
  }
}
