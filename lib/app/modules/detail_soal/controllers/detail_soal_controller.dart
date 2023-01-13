import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/tugas/soal_essay_model.dart';
import '../../../data/models/tugas/soal_pg_model.dart';
import '../../../data/providers/network/api_repository.dart';
import '../../../data/providers/network/repository/tugas_repositori.dart';

class DetailSoalController extends GetxController {
  RxString numLoading = "0".obs;
  RxString p = "".obs;
  final TugasRepositori _tugasDetailRepositori = TugasRepositori();
  final TugasRepositori _tugasDetailRepositori2 = TugasRepositori();

  Future<DataSoalPg?> getDataSoalPg(BuildContext context, String id) async {
    final dataResponse = await _tugasDetailRepositori.getDetailSoal(id);
    if (dataResponse != null) {
      if (dataResponse.statusResponse == StatusResponse.success) {
        final data = SoalPg.fromJson(jsonDecode(dataResponse.response!)).data;

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
    return null;
  }

  Future<DataSoalEssay?> getDataSoalEssay(
      BuildContext context, String id) async {
    final dataResponse = await _tugasDetailRepositori2.getDetailSoal(id);
    if (dataResponse != null) {
      if (dataResponse.statusResponse == StatusResponse.success) {
        final data =
            SoalEssay.fromJson(jsonDecode(dataResponse.response!)).data;
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
    return null;
  }
}
