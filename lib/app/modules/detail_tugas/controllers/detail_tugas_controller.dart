import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/tugas/detail_tugas_model.dart';
import '../../../data/providers/network/repository/tugas_repositori.dart';
import '../../../data/providers/network/api_repository.dart';

class DetailTugasController extends GetxController {
  final TugasRepositori _tugasDetailRepositori = TugasRepositori();

  Future<DataDetail?> getDataDetailTugas(String id) async {
    final dataResponse = await _tugasDetailRepositori.getDetailTugas(id);
    if (dataResponse != null) {
      if (dataResponse.statusResponse == StatusResponse.success) {
        final data =
            DetailTugas.fromJson(jsonDecode(dataResponse.response!)).data;
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
}
