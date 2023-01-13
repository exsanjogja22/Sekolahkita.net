import 'package:camera/camera.dart';
import 'package:get/get.dart';

class KameraHelperController extends GetxController {
  RxBool isLoading = false.obs;
  late CameraController cameraController;
  Future<void> initializationCamera(int cam) async {
    final camera = await availableCameras();
    cameraController = CameraController(camera[cam], ResolutionPreset.high);
    await cameraController.initialize();
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }
}
