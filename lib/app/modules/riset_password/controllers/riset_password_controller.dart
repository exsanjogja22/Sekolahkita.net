import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/providers/network/api_repository.dart';
import '../../../data/providers/network/repository/auth_repositori.dart';
import '../../../data/providers/network/repository/ubah_password_repositori.dart';

class RisetPasswordController extends GetxController {
  RxBool isObscure = true.obs;
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController retypePassword = TextEditingController();
  final UbahPasswordRepositori _passwordRepositori = UbahPasswordRepositori();

  Future<void> postNewPassword(BuildContext context) async {
    if (retypePassword.text == newPassword.text) {
      final dataResponse = await _passwordRepositori.postPassword(
          newPassword.text, retypePassword.text);
      if (dataResponse != null) {
        if (dataResponse.statusResponse == StatusResponse.success) {
          var it = jsonDecode(dataResponse.response!);
          if (it["status"] == true) {
            CoolAlert.show(
                context: context,
                type: CoolAlertType.success,
                title: "Berhasil",
                text: it["pesan"].toString(),
                confirmBtnTextStyle: GoogleFonts.quicksand(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                onConfirmBtnTap: () {
                  ApiAuth().deleteToken();
                  Get.back();
                });
          } else {
            CoolAlert.show(
                context: context,
                type: CoolAlertType.warning,
                title: "Peringatan !",
                text: it["pesan"].toString(),
                confirmBtnTextStyle: GoogleFonts.quicksand(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                onConfirmBtnTap: () {
                  Get.back();
                  Get.back();
                });
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
    } else {
      CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          title: "Gagal",
          text: "Konfirmasi Password Salah",
          confirmBtnTextStyle: GoogleFonts.quicksand(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          onConfirmBtnTap: () {
            Get.back();
          });
    }
  }
}
