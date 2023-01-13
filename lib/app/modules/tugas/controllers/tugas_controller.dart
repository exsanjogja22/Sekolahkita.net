import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/models/tugas/statistik_tugas_model.dart';
import '../../../data/models/tugas/get_tugas_model.dart';
import '../../../data/providers/network/api_repository.dart';
import '../../../data/providers/network/repository/tugas_repositori.dart';

class TugasController extends GetxController {
  RxBool isLoading = false.obs;
  final TugasRepositori _tugasRepositori = TugasRepositori();

  Future<DataStatistikTugas?>? initGetDataStatistik;
  Future<List<Tugas>?>? initTugasAktif;
  Future<List<Tugas>?>? initTugasSelesai;

  Future<DataStatistikTugas?> getDataStatistikTugas() async {
    isLoading.value = true;
    final dataResponse = await _tugasRepositori.getStatistikTugas();
    if (dataResponse != null) {
      if (dataResponse.statusResponse == StatusResponse.success) {
        final data =
            StatistikTugas.fromJson(jsonDecode(dataResponse.response!)).data;
        isLoading.value = false;
        return data;
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
    throw "data gagal di ambil";
  }

  Future<List<Tugas>?> getDataTugasAktif() async {
    isLoading.value = true;
    final dataResponse = await _tugasRepositori.getTugasAktif(0, 5);
    if (dataResponse != null) {
      if (dataResponse.statusResponse == StatusResponse.success) {
        final data =
            GetTugas.fromJson(jsonDecode(dataResponse.response!)).data!.tugas;
        isLoading.value = false;
        return data;
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
    throw "data gagal di ambil";
  }

  Future<List<Tugas>?> getDataTugasSelesai() async {
    isLoading.value = true;
    final dataResponse = await _tugasRepositori.getTugasSelesai(0, 6);
    if (dataResponse != null) {
      if (dataResponse.statusResponse == StatusResponse.success) {
        final data =
            GetTugas.fromJson(jsonDecode(dataResponse.response!)).data!.tugas;
        isLoading.value = false;
        return data;
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
    throw "data gagal di ambil";
  }

  @override
  void onInit() {
    super.onInit();

    initGetDataStatistik = getDataStatistikTugas();
    initTugasAktif = getDataTugasAktif();
    initTugasSelesai = getDataTugasSelesai();
  }
}
