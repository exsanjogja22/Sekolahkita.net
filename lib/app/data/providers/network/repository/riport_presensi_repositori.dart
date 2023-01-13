import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';
import '../api_repository.dart';
import '../path_api_endpoints.dart';
import '../entpoint_repository.dart';

class RiportPresensiRepositori extends EnpointRepository {
  Future<ResponseApi?> getRiport(String month) async {
    final auth = await apiAuth.getToken();
    final response = await apiRepository.getMetod(
        "${PathAPIEndpoint.presensi}/report?month=$month&tampilkan_kegiatan=true",
        auth);
    if (response != null) {
      if (response.statusCode == 200) {
        final data = ResponseApi.success(data: response.body);
        return data;
      } else if (response.statusCode == 401) {
        final data =
            ResponseApi.error(data: response.body, message: "Kesalahan login");
        Get.offAllNamed(Routes.LOGIN);
        return data;
      } else if (response.statusCode == 404) {
        return ResponseApi.error(message: "Kesalahan server");
      } else {
        return ResponseApi.error(
            message: "Terjadi Kesalahan di ${response.statusCode}");
      }
    } else {
      Get.snackbar("Gagal", "Koneksi Internet tidak terhubung",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.red,
          backgroundColor: Colors.red.withOpacity(0.4));
      return ResponseApi.error(message: "Tidak Ada koneksi internet");
    }
  }
}
