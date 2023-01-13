import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/app/data/providers/network/api_repository.dart';
import '/app/data/providers/network/path_api_endpoints.dart';
import '../entpoint_repository.dart';

class KelasRepository extends EnpointRepository {
  Future<ResponseApi> getAllKelas() async {
    final response = await apiRepository.getMetod(PathAPIEndpoint.apiKelas);
    if (response != null) {
      if (response.statusCode == 200) {
        final data = ResponseApi.success(data: response.body);
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
