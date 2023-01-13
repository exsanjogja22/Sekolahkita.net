import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../config/app_colors.dart';
import '../../../data/providers/network/api_repository.dart';
import '../../../data/providers/network/repository/login_repositori.dart';
import '../../../data/providers/network/repository/profil_repositori.dart';
import '../../../routes/app_pages.dart';

class LoginmainController extends GetxController {
  RxBool validateUsername = false.obs;
  RxBool validatePassword = false.obs;

  RxBool isChecked = false.obs;
  RxBool isObscure = true.obs;
  RxBool isLoading = false.obs;

  final username = TextEditingController();
  final password = TextEditingController();

  final LoginRepositori _loginRepositori = LoginRepositori();

  final ProfilRepisitori _profilRepisitori = ProfilRepisitori();
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  late StreamSubscription<InternetConnectionStatus> listener;

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.red;
  }

  Future<bool> getCase() async {
    SharedPreferences getToken = await SharedPreferences.getInstance();
    bool? data = getToken.getBool("SkipCase1");
    if (data != null) {
      return true;
    } else {
      return false;
    }
  }

  void postData() async {
    isLoading.value = true;
    final data = await _loginRepositori.login(username.text, password.text);
    if (data != null) {
      if (data.loginStatus == LoginStatus.isLogin) {
        Get.snackbar("Berhasil", data.pesan,
            snackPosition: SnackPosition.BOTTOM,
            colorText: AppColors.appGreenlight,
            backgroundColor: AppColors.appGreenlight.withOpacity(0.4));
        isLoading.value = false;
        getCase().then((value) {
          if (value == false) {
            updateProfil();
            Get.offAllNamed(Routes.WELCOME);
          } else {
            updateProfil();
            Get.offAllNamed(Routes.MAINPAGE);
          }
        });
      } else if (data.loginStatus == LoginStatus.isLogout) {
        Get.snackbar("Gagal", data.pesan,
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.red,
            backgroundColor: Colors.red.withOpacity(0.4));
        isLoading.value = false;
      }
    } else {
      Get.snackbar("Gagal", "Koneksi Internet tidak terhubung",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.red,
          backgroundColor: Colors.red.withOpacity(0.4));
    }
  }

  Future<void> updateProfil() async {
    String? token = await messaging.getToken();
    final data = ({'notiftoken': '$token'});
    final dataResponse = await _profilRepisitori.postProfil(data);
    if (dataResponse != null) {
      if (dataResponse.statusResponse == StatusResponse.success) {
        var it = jsonDecode(dataResponse.response!);
        if (it["status"] == true) {
          if (kDebugMode) {
            print("token sucess add");
          }
        } else {
          if (kDebugMode) {
            print("token not found");
          }
        }
      } else {
        if (kDebugMode) {
          print(dataResponse.message);
        }
      }
    } else {
      Get.snackbar("Gagal", "Koneksi Internet tidak terhubung",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.red,
          backgroundColor: Colors.red.withOpacity(0.4));
    }
  }

  Future<void> launchURL(String url) async {
    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  void onInit() {
    listener = InternetConnectionChecker().onStatusChange.listen(
      (InternetConnectionStatus status) {
        switch (status) {
          case InternetConnectionStatus.connected:
            break;
          case InternetConnectionStatus.disconnected:
            Get.snackbar("Gagal", "Koneksi Internet tidak terhubung",
                snackPosition: SnackPosition.BOTTOM,
                colorText: Colors.red,
                backgroundColor: Colors.red.withOpacity(0.4));
            break;
        }
      },
    );
    super.onInit();
  }
}
