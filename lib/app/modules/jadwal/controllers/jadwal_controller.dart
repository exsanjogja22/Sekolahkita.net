import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/scedule/scedule_date_model.dart';
import '../../../data/models/scedule/scedule_day_model.dart';
import '../../../data/models/tahun_ajar_model.dart';
import '../../../data/providers/network/repository/jadwal_repositori.dart';
import '../../../data/models/scedule/scedule_model.dart';
import '../../../data/providers/network/api_repository.dart';
import '../../../data/providers/network/repository/profil_repositori.dart';

class JadwalController extends GetxController {
  RxString selectedHari = "Senin".obs;
  RxString kelas = "".obs;
  RxString tahun = "".obs;
  RxString semester = "".obs;

  RxBool isLoading = false.obs;
  Future<ResponseApi?>? _jadwalRepositori;
  Future<ResponseApi?>? _profilRepisitori;

  var listJadwalDate = List<DataJadwalDate>.empty().obs;
  var listJadwalDay = List<DataJadwalDay>.empty().obs;

  RxString tipeJadwal = "".obs;

  final List<String> listHari = [
    "Senin",
    "Selasa",
    "Rabu",
    "Kamis",
    "Jumat",
    "Sabtu"
  ];

  getDataJadwal() async {
    isLoading.value = true;
    final dataResponse = await _jadwalRepositori;
    if (dataResponse != null) {
      if (dataResponse.statusResponse == StatusResponse.success) {
        final data = Scedule.fromJson(jsonDecode(dataResponse.response!));
        tipeJadwal.value = data.data!.tipeJadwal!;
        if (data.data!.tipeJadwal == "date") {
          final dataSceduleDate =
              SceduleDate.fromJson(jsonDecode(dataResponse.response!));
          var dataListScedule = dataSceduleDate.data!.dataJadwal;
          for (var i in dataListScedule!) {
            listJadwalDate.add(i);
          }
          isLoading.value = false;
        } else {
          final dataSceduleDay =
              SceduleDay.fromJson(jsonDecode(dataResponse.response!));
          var dataListScedule = dataSceduleDay.data!.dataJadwal;
          for (var i in dataListScedule!) {
            listJadwalDay.add(i);
          }
          isLoading.value = false;
        }
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
    isLoading.value = true;
    final dataResponse = await _profilRepisitori;
    if (dataResponse != null) {
      if (dataResponse.statusResponse == StatusResponse.success) {
        final data =
            TahunAjar.fromJson(jsonDecode(dataResponse.response!)).data;
        kelas.value = "${data!.jenjang} ${data.nama}";
        tahun.value = data.tahun!;
        semester.value = data.semester!;
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

    _profilRepisitori = ProfilRepisitori().getKelasAktif();
    _jadwalRepositori = JadwalRepositori().getJadwal();
    getDataJadwal();
    getDataKelasAktif();
  }
}
