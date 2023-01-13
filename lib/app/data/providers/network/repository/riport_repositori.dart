import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';
import '../api_repository.dart';
import '../path_api_endpoints.dart';
import '../entpoint_repository.dart';

class RiportRepositori extends EnpointRepository {
  Future<ResponseApi?> getRiportKbm(String month, String kelasKode) async {
    final auth = await apiAuth.getToken();
    final response = await apiRepository.getMetod(
        "${PathAPIEndpoint.report}/keaktifan_kbm?filter_bulan=$month&filter_kelas=$kelasKode",
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

  Future<ResponseApi?> getRiportKbmVir(String month, String kelasKode) async {
    final auth = await apiAuth.getToken();
    final response = await apiRepository.getMetod(
        "${PathAPIEndpoint.report}/keaktifan_kelas_online?filter_kelas=$kelasKode&filter_bulan=$month",
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

  Future<ResponseApi?> getRiportPelangaran(String month) async {
    final auth = await apiAuth.getToken();
    final response = await apiRepository.getMetod(
        "${PathAPIEndpoint.report}/poin_pelanggaran?bulan=$month", auth);
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
