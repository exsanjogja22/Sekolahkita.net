import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';
import '../api_repository.dart';
import '../path_api_endpoints.dart';
import '../entpoint_repository.dart';

class StatusSiswaRepositori extends EnpointRepository {
  StreamController<ResponseApi?> repositoriController =
      StreamController<ResponseApi?>();
  Stream<ResponseApi?> get repositoriStream => repositoriController.stream;

  Future<ResponseApi?> getStatusSiswa(
      int offset, int limit, String type) async {
    final auth = await apiAuth.getToken();
    final response = await apiRepository.getMetod(
        "${PathAPIEndpoint.status}?limit=$limit&offset=$offset&tipe=$type",
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

  Future<ResponseApi?> getStatusSiswaByid(String id) async {
    final auth = await apiAuth.getToken();
    final response =
        await apiRepository.getMetod("${PathAPIEndpoint.status}?id=$id", auth);
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

  Future<ResponseApi?> getKomentar(String id, String tipe) async {
    final auth = await apiAuth.getToken();
    final response = await apiRepository.getMetod(
        "${PathAPIEndpoint.status}/komen?id=$id&tipe=$tipe&offset=0", auth);
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

  Future<ResponseApi?> postKomentar(String id, String tipe, String text) async {
    final auth = await apiAuth.getToken();
    var body = {'id': id, 'tipe': tipe, 'text': text};

    final response = await apiRepository.postMetod(
        "${PathAPIEndpoint.status}/komen", body, auth);
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

  Future<ResponseApi?> postStatus(String text, String tipe) async {
    final auth = await apiAuth.getToken();
    var body = {'post-text': text, 'post-privacy': tipe};
    final response =
        await apiRepository.postMetod(PathAPIEndpoint.status, body, auth);
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
