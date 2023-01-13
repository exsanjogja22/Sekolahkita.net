import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/providers/network/api_repository.dart';
import '../../../data/providers/network/repository/profil_repositori.dart';
import 'akun_saya_controller.dart';

class TanggalLahirController extends GetxController {
  final TextEditingController tanggalC = TextEditingController();
  final ProfilRepisitori _profilRepisitori = ProfilRepisitori();
  final _akunSayaController = Get.find<AkunSayaController>();
  RxString tanggalRl = "".obs;

  Future<void> updateProfil(BuildContext context, String date) async {
    final data = ({
      'tgl_lahir': date,
    });
    final dataResponse = await _profilRepisitori.postProfil(data);
    if (dataResponse != null) {
      if (dataResponse.statusResponse == StatusResponse.success) {
        var it = jsonDecode(dataResponse.response!);
        if (it["status"] == true) {
          _akunSayaController.getDataProfil();
          Get.back();
        } else {
          CoolAlert.show(
              context: context,
              type: CoolAlertType.error,
              title: "Gagal",
              text: it["pesan"].toString(),
              confirmBtnTextStyle: GoogleFonts.quicksand(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              onConfirmBtnTap: () {
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
  }
}
