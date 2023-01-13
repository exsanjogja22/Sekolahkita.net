import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/kamera_helper_controller.dart';

class KameraHelperView extends GetView<KameraHelperController> {
  const KameraHelperView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final cam = Get.arguments[0];
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(
        future: controller.initializationCamera(cam),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Obx(() => Stack(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width *
                              controller.cameraController.value.aspectRatio,
                          child: CameraPreview(controller.cameraController),
                        ),
                        Container(
                          width: 70.w,
                          height: 70.h,
                          margin: const EdgeInsets.only(top: 50),
                          child: ElevatedButton(
                            onPressed: () async {
                              controller.isLoading.value = true;
                              if (!controller
                                  .cameraController.value.isTakingPicture) {
                                await controller.initializationCamera(cam);
                                final result = await controller.cameraController
                                    .takePicture();

                                controller.isLoading.value = true;
                                Get.back(result: result.path);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                backgroundColor: Colors.white),
                            child: Icon(
                              Icons.camera_alt,
                              size: 30.w,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width *
                          controller.cameraController.value.aspectRatio,
                      child: Image.asset(
                        "assets/images/layer.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    if (controller.isLoading.isTrue)
                      SizedBox(
                        height: 500.h,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: SizedBox(
                            height: 40.w,
                            width: 40.w,
                            child: const CircularProgressIndicator(),
                          ),
                        ),
                      )
                  ],
                ));
          } else {
            return Center(
              child: SizedBox(
                height: 40.h,
                width: 40.w,
                child: const CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
