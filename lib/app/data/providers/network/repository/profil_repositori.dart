import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';
import '../api_repository.dart';
import '../entpoint_repository.dart';
import '../path_api_endpoints.dart';

class ProfilRepisitori extends EnpointRepository {
  Future<ResponseApi?> getProfil() async {
    final auth = await apiAuth.getToken();
    final response =
        await apiRepository.getMetod(PathAPIEndpoint.apiProfil, auth);
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

  Future<ResponseApi?> getKelasAktif() async {
    final auth = await apiAuth.getToken();
    final response = await apiRepository.getMetod(
        "${PathAPIEndpoint.jadwal}/kelas_aktif", auth);
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

  Future<ResponseApi?> postProfil(Map<String, String> data) async {
    final auth = await apiAuth.getToken();
    final response =
        await apiRepository.postMetod(PathAPIEndpoint.apiProfil, data, auth);
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

  Future<ResponseApi?> postFotoProfil(
      Map<String, String> data, File img) async {
    final auth = await apiAuth.getToken();
    var headers = {'Authorization': auth.toString()};
    final response = await apiRepository.postMetodFile(
        headers, data, PathAPIEndpoint.apiProfil, img, "file_img");
    if (response != null) {
      if (response.statusCode == 200) {
        final data =
            ResponseApi.success(data: await response.stream.bytesToString());
        return data;
      } else if (response.statusCode == 401) {
        final data = ResponseApi.error(
            data: await response.stream.bytesToString(),
            message: "Kesalahan login");
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
