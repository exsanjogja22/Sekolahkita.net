import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smkn1contoh/app/data/models/riport_point_pelangaran_model.dart';

import '../../../data/models/presensi/riport_presensi_model.dart';
import '../../../data/models/profil_model.dart';
import '../../../data/models/riport_keaktifan_kbm_model.dart';
import '../../../data/models/riport_kelas_online_model.dart';
import '../../../data/models/tahun_ajar_model.dart';
import '../../../data/providers/network/api_repository.dart';
import '../../../data/providers/network/repository/profil_repositori.dart';
import '../../../data/providers/network/repository/riport_presensi_repositori.dart';
import '../../../data/providers/network/repository/riport_repositori.dart';

class StatistikController extends GetxController {
  RxInt selectedMenu = 0.obs;
  RxString tahunAjar = "".obs;
  String? selectedBulan = "${DateTime.now().month}";
  String? selectedBulan1 = "${DateTime.now().month}";
  String? selectedBulan2 = "${DateTime.now().month}";
  String? selectedBulan3 = "${DateTime.now().month}";
  final RiportPresensiRepositori _riportPresensiRepositori =
      RiportPresensiRepositori();
  final RiportRepositori _riportRepositori = RiportRepositori();
  final ProfilRepisitori _profilRepisitori = ProfilRepisitori();

  Future<String?>? initGetKelasAktif;
  Future<Biodata?>? initGetProfil;

  var menu = [
    {"title": "Aktivitas\nBelajar", "image": "assets/icons/ic_komputer.png"},
    {"title": "Poin\nPelanggaran", "image": "assets/icons/ic_tugas1.png"}
  ];
  List bulan = [
    {
      "month": "Januari",
      "code": "1",
    },
    {
      "month": "Februari",
      "code": "2",
    },
    {
      "month": "Maret",
      "code": "3",
    },
    {
      "month": "April",
      "code": "4",
    },
    {
      "month": "Mei",
      "code": "5",
    },
    {
      "month": "Juni",
      "code": "6",
    },
    // {
    //   "month": "Juli",
    //   "code": "7",
    // },
    // {
    //   "month": "Agustus",
    //   "code": "8",
    // },
    // {
    //   "month": "September",
    //   "code": "9",
    // },
    // {
    //   "month": "Oktober",
    //   "code": "10",
    // },
    // {
    //   "month": "November",
    //   "code": "11",
    // },
    // {
    //   "month": "Desember",
    //   "code": "12",
    // },
  ];

  Future<DataRiportPresensi?> getDataReport() async {
    final dataResponse =
        await _riportPresensiRepositori.getRiport(selectedBulan!);
    if (dataResponse != null) {
      if (dataResponse.statusResponse == StatusResponse.success) {
        final data =
            RiportPresensi.fromJson(jsonDecode(dataResponse.response!)).data;
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

  Future<List<DataRiport>?> getDataReportKbm(String kelas) async {
    final dataResponse =
        await _riportRepositori.getRiportKbm(selectedBulan1!, kelas);
    if (dataResponse != null) {
      if (dataResponse.statusResponse == StatusResponse.success) {
        final data =
            RiportKeaktifanKbm.fromJson(jsonDecode(dataResponse.response!))
                .data;
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

  Future<DataKelasOnline?> getDataReportKbmVir(String kelas) async {
    final dataResponse =
        await _riportRepositori.getRiportKbmVir(selectedBulan2!, kelas);
    if (dataResponse != null) {
      if (dataResponse.statusResponse == StatusResponse.success) {
        final data =
            RiportKelasOnline.fromJson(jsonDecode(dataResponse.response!)).data;
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

  Future<String?> getDataKelasAktif() async {
    final dataResponse = await _profilRepisitori.getKelasAktif();
    if (dataResponse != null) {
      if (dataResponse.statusResponse == StatusResponse.success) {
        final data =
            TahunAjar.fromJson(jsonDecode(dataResponse.response!)).data!.kode;
        tahunAjar.value =
            TahunAjar.fromJson(jsonDecode(dataResponse.response!)).data!.tahun!;
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

  Future<Biodata?> getDataProfil() async {
    final dataResponse = await _profilRepisitori.getProfil();
    if (dataResponse != null) {
      if (dataResponse.statusResponse == StatusResponse.success) {
        final data =
            Profil.fromJson(jsonDecode(dataResponse.response!)).biodata;

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

  Future<DataPelangaran?> getDataRiportPel() async {
    final dataResponse =
        await _riportRepositori.getRiportPelangaran(selectedBulan3!);
    if (dataResponse != null) {
      if (dataResponse.statusResponse == StatusResponse.success) {
        final data =
            RiportPointPelangaran.fromJson(jsonDecode(dataResponse.response!))
                .data;
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

  @override
  void onInit() {
    super.onInit();
    initGetKelasAktif = getDataKelasAktif();
    initGetProfil = getDataProfil();
  }
}
