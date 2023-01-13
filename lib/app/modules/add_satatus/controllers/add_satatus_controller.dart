import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/providers/network/api_repository.dart';
import '../../../data/providers/network/repository/status_siswa_repositori.dart';
import '../../status/controllers/status_controller.dart';

class AddSatatusController extends GetxController {
  List posTo = ["Privat", "Publik"];
  String selectedTo = "Privat";

  final StatusSiswaRepositori _statusSiswaRepositori = StatusSiswaRepositori();
  final TextEditingController text = TextEditingController();
  final StatusController statusC = Get.put(StatusController());

  Future<void> postDataStatus() async {
    final dataResponse =
        await _statusSiswaRepositori.postStatus(text.text, selectedTo);
    if (dataResponse != null) {
      if (dataResponse.statusResponse == StatusResponse.success) {
        statusC.onRefresh();
        Get.back();
      } else {
        Get.snackbar("Gagal", "Koneksi Internet tidak terhubung",
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.red,
            backgroundColor: Colors.red.withOpacity(0.4));
      }
    }
  }
}
