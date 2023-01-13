import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/models/profil_model.dart';
import '../../../data/models/tahun_ajar_model.dart';
import '../../../data/providers/network/api_repository.dart';
import '../../../data/providers/network/repository/profil_repositori.dart';

class SettingController extends GetxController {
  RxString nis = "".obs;
  RxString namaSiswa = "".obs;
  RxString photo = "".obs;
  RxString kelas = "".obs;

  Future<void> launchURL(String url) async {
    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  Future<ResponseApi?>? _profilRepisitori;
  Future<ResponseApi?>? _profilRepisitori1;

  getDataProfil() async {
    final dataResponse = await _profilRepisitori;
    if (dataResponse != null) {
      if (dataResponse.statusResponse == StatusResponse.success) {
        final data =
            Profil.fromJson(jsonDecode(dataResponse.response!)).biodata;
        namaSiswa.value = data!.namaSiswa!;
        photo.value = data.photo!;
        nis.value = data.nis!;
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

  getDataKelasAktif() async {
    final dataResponse = await _profilRepisitori1;
    if (dataResponse != null) {
      if (dataResponse.statusResponse == StatusResponse.success) {
        final data =
            TahunAjar.fromJson(jsonDecode(dataResponse.response!)).data;
        kelas.value = "${data!.jenjang!} ${data.nama} /";
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

  @override
  void onInit() {
    super.onInit();
    _profilRepisitori = ProfilRepisitori().getProfil();
    _profilRepisitori1 = ProfilRepisitori().getKelasAktif();
    getDataProfil();
    getDataKelasAktif();
  }
}
