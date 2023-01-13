import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/providers/network/repository/status_siswa_repositori.dart';
import '../../detail_status/controllers/detail_status_controller.dart';
import '../../../data/providers/network/api_repository.dart';

class KomentarStatusController extends GetxController {
  final StatusSiswaRepositori _statusSiswaRepositori = StatusSiswaRepositori();
  TextEditingController text = TextEditingController();
  final detailController = Get.put(DetailStatusController());

  postDataKomentar(String id, String tipe) async {
    final dataResponse =
        await _statusSiswaRepositori.postKomentar(id, tipe, text.text);
    if (dataResponse != null) {
      if (dataResponse.statusResponse == StatusResponse.success) {
        detailController.getDataKomentar(id, tipe);
        detailController.update();
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
