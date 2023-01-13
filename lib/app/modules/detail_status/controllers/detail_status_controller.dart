import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/status/komentar_model.dart';
import '../../../data/models/profil_model.dart';
import '../../../data/providers/network/api_repository.dart';
import '../../../data/providers/network/repository/profil_repositori.dart';
import '../../../data/providers/network/repository/status_siswa_repositori.dart';

class DetailStatusController extends GetxController {
  final StatusSiswaRepositori statusSiswaRepositori = StatusSiswaRepositori();
  RxString namaSiswa = "".obs;
  RxString photo = "".obs;
  Future<ResponseApi?>? _profilRepisitori;

  getDataProfil() async {
    final dataResponse = await _profilRepisitori;
    if (dataResponse != null) {
      if (dataResponse.statusResponse == StatusResponse.success) {
        final data =
            Profil.fromJson(jsonDecode(dataResponse.response!)).biodata;
        namaSiswa.value = data!.namaSiswa!;
        photo.value = data.photo!;
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
  }

  Future<List<DataKomentar>?> getDataKomentar(String id, String tipe) async {
    final dataResponse = await statusSiswaRepositori.getKomentar(id, tipe);
    if (dataResponse != null) {
      if (dataResponse.statusResponse == StatusResponse.success) {
        final data = Komentar.fromJson(jsonDecode(dataResponse.response!)).data;
        return data;
      } else {
        Get.snackbar("Gagal", "Koneksi Internet tidak terhubung",
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.red,
            backgroundColor: Colors.red.withOpacity(0.4));
      }
    }
    throw dataResponse!.message.toString();
  }

  @override
  void onInit() {
    super.onInit();

    _profilRepisitori = ProfilRepisitori().getProfil();

    getDataProfil();
  }
}
