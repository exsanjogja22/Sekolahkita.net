import 'package:get/get.dart';

import '../controllers/map_helper_controller.dart';

class MapHelperBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MapHelperController>(
      () => MapHelperController(),
    );
  }
}
