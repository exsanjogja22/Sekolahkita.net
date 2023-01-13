import 'package:get/get.dart';
import 'package:flutter/material.dart' as android;
import 'package:flutter/cupertino.dart' as ios;
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeController extends GetxController {
  android.PageController? pageControllerAndroid;
  ios.PageController? pageControllerIos;
  RxInt currentPage = 0.obs;
  RxInt numPages = 3.obs;

  Future<void> skipsCase1() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    await localStorage.setBool("SkipCase1", true);
  }

  @override
  void onInit() {
    super.onInit();

    if (GetPlatform.isAndroid) {
      pageControllerAndroid = android.PageController(initialPage: 0);
    } else {
      pageControllerIos = ios.PageController(initialPage: 0);
    }
  }
}
