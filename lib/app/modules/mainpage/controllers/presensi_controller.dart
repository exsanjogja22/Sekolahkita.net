import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../data/models/presensi/config_siswa_model.dart';
import '../../../data/models/presensi/presensi_kegiatan_model.dart';
import '../../../data/models/presensi/riport_presensi_model.dart';
import '../../../data/models/tahun_ajar_model.dart';
import '../../../data/providers/network/repository/presensi_harian_repositori.dart';
import '../../../data/providers/network/repository/presensi_kegiatan_repositori.dart';
import '../../../data/models/presensi/presensi_harian_model.dart';
import '../../../data/providers/network/api_repository.dart';
import '../../../data/providers/network/repository/profil_repositori.dart';
import '../../../data/providers/network/repository/riport_presensi_repositori.dart';

class PresensiController extends GetxController {
  RxInt kategori = 0.obs;
  RxInt selectMenu = 0.obs;
  RxInt cobap = 0.obs;
  RxString tahunAjar = "".obs;
  String? selectedBulan;
  BuildContext? myContext;

  final pageControl = PageController();
  late StreamSubscription<InternetConnectionStatus> listener;
  // final ProfilRepisitori _profilRepisitori = ProfilRepisitori();

  Future<ResponseApi?>? _profilRepisitori;
  Future<ResponseApi?>? riportPresensiRepositori;
  Future<ResponseApi?>? riportPresensiRepositori2;
  Future<ResponseApi?>? presensiHarianRepositori;
  Future<ResponseApi?>? _aturanPresensiRepositori;
  Future<ResponseApi?>? presensiKegiatanRepositori;
  Future<DataPresensi?>? stateGetPresensiHarian;
  Future<DataConfig?>? stateGetAturanPresensi;
  Future<List<DataPresensiKegiatan>?>? stateGetPresensiKegitan;

  final GlobalKey one = GlobalKey();
  final GlobalKey two = GlobalKey();
  final GlobalKey three = GlobalKey();
  final GlobalKey four = GlobalKey();
  final GlobalKey five = GlobalKey();
  final GlobalKey six = GlobalKey();

  List menu = [
    {
      "title": "Presensi Harian",
      "icon": "assets/icons/presensi_icons/ic_presensi_harian.png",
    },
    {
      "title": "Presensi Kegiatan",
      "icon": "assets/icons/presensi_icons/ic_presensi_kegiatan.png",
    },
    {
      "title": "Riport Presensi",
      "icon": "assets/icons/presensi_icons/ic_report.png",
    }
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
    {
      "month": "Juli",
      "code": "7",
    },
    {
      "month": "Agustus",
      "code": "8",
    },
    {
      "month": "September",
      "code": "9",
    },
    {
      "month": "Oktober",
      "code": "10",
    },
    {
      "month": "November",
      "code": "11",
    },
    {
      "month": "Desember",
      "code": "12",
    },
  ];

  List izin = [
    {
      "title": "Sakit",
      "id": "S",
    },
    {
      "title": "Izin",
      "id": "I",
    },
  ];

  ontapKonten(int index) {
    selectMenu.value = index;
    update();
    pageControl.animateToPage(selectMenu.value,
        duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
    update();
  }

  Future<DataPresensi?> getDataPresensiHarian() async {
    final dataResponse = await presensiHarianRepositori;
    if (dataResponse != null) {
      if (dataResponse.statusResponse == StatusResponse.success) {
        final data =
            PresensiHarian.fromJson(jsonDecode(dataResponse.response!)).data;
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

  Future<DataRiportPresensi?> getDataReport() async {
    final dataResponse = await riportPresensiRepositori;
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

  Future<DataConfig?> getDataAturanPresensiHarian() async {
    final dataResponse = await _aturanPresensiRepositori;
    if (dataResponse != null) {
      if (dataResponse.statusResponse == StatusResponse.success) {
        final data =
            ConfigSiswa.fromJson(jsonDecode(dataResponse.response!)).data;
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

  Future<List<DataPresensiKegiatan>?> getDataPresensiKegiatan() async {
    final dataResponse = await presensiKegiatanRepositori;
    if (dataResponse != null) {
      if (dataResponse.statusResponse == StatusResponse.success) {
        final data =
            PresensiKegiatan.fromJson(jsonDecode(dataResponse.response!)).data;
        update();
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

  Future<void> skipsCase1() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    await localStorage.setBool("SkipCase2", true);
  }

  Future<bool> getCase() async {
    SharedPreferences getToken = await SharedPreferences.getInstance();
    bool? data = getToken.getBool("SkipCase2");
    if (data != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> getDataKelasAktif() async {
    final dataResponse = await _profilRepisitori;
    if (dataResponse != null) {
      if (dataResponse.statusResponse == StatusResponse.success) {
        tahunAjar.value =
            TahunAjar.fromJson(jsonDecode(dataResponse.response!)).data!.tahun!;
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
    ambiguate(WidgetsBinding.instance)?.addPostFrameCallback((_) {
      getCase().then((value) {
        if (value == false) {
          ShowCaseWidget.of(myContext!)
              .startShowCase([one, two, three, four, five, six]);
        }
      });
    });
    riportPresensiRepositori =
        RiportPresensiRepositori().getRiport(DateTime.now().month.toString());

    _aturanPresensiRepositori =
        PresensiHarianRepositori().getAturanPresensiHarian();
    presensiHarianRepositori = PresensiHarianRepositori().getPresensiHarian();
    presensiKegiatanRepositori = PresensiKegiatanRepositori().getListEvent();
    _profilRepisitori = ProfilRepisitori().getKelasAktif();
    stateGetAturanPresensi = getDataAturanPresensiHarian();
    stateGetPresensiHarian = getDataPresensiHarian();
    stateGetPresensiKegitan = getDataPresensiKegiatan();
    getDataKelasAktif();
    listener = InternetConnectionChecker().onStatusChange.listen(
      (InternetConnectionStatus status) {
        switch (status) {
          case InternetConnectionStatus.connected:
            _aturanPresensiRepositori =
                PresensiHarianRepositori().getAturanPresensiHarian();
            presensiHarianRepositori =
                PresensiHarianRepositori().getPresensiHarian();
            presensiKegiatanRepositori =
                PresensiKegiatanRepositori().getListEvent();
            stateGetAturanPresensi = getDataAturanPresensiHarian();
            stateGetPresensiHarian = getDataPresensiHarian();
            stateGetPresensiKegitan = getDataPresensiKegiatan();
            break;
          case InternetConnectionStatus.disconnected:
            Get.snackbar(
              "Gagal",
              "Koneksi Internet tidak terhubung",
              snackPosition: SnackPosition.BOTTOM,
              colorText: Colors.red,
              backgroundColor: Colors.red.withOpacity(0.4),
            );
            break;
        }
      },
    );
  }

  @override
  void dispose() {
    pageControl.dispose();
    super.dispose();
  }
}
