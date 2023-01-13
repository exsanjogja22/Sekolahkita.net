import 'package:get/get.dart';

import '../controllers/pdf_helper_controller.dart';

class PdfHelperBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PdfHelperController>(
      () => PdfHelperController(),
    );
  }
}
