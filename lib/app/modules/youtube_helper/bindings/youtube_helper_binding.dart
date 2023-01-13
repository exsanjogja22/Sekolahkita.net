import 'package:get/get.dart';

import '../controllers/youtube_helper_controller.dart';

class YoutubeHelperBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<YoutubeHelperController>(
      () => YoutubeHelperController(),
    );
  }
}
