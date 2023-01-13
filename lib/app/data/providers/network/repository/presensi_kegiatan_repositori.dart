import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';
import '../api_repository.dart';
import '../path_api_endpoints.dart';
import '../entpoint_repository.dart';

class PresensiKegiatanRepositori extends EnpointRepository {
  Future<ResponseApi?> getListEvent() async {
    final auth = await apiAuth.getToken();
    final response = await apiRepository.getMetod(
        "${PathAPIEndpoint.presensiKegiatan}/user_list_event", auth);
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

  Future<ResponseApi?> postEventUseFile(File file, String mkKode, String mkNote,
      [String? latitude, String? longitude]) async {
    final auth = await apiAuth.getToken();
    var headers = {'Authorization': auth.toString()};
    var fields = {
      'mk_kode': mkKode,
      'app': 'mobile',
      'latitude': latitude!,
      'longitude': longitude!,
      'mk_note': mkNote
    };
    final response = await apiRepository.postMetodFile(headers, fields,
        "${PathAPIEndpoint.presensiKegiatan}/presensi", file, "file");
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

  Future<ResponseApi?> postEvent(String mkKode, String mkNote,
      [String? latitude, String? longitude]) async {
    final auth = await apiAuth.getToken();

    var body = {
      'mk_kode': mkKode,
      'app': 'mobile',
      'latitude': latitude,
      'longitude': longitude,
      'mk_note': mkNote
    };

    final response = await apiRepository.postMetod(
        "${PathAPIEndpoint.presensiKegiatan}/presensi", body, auth);
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
