import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/models/kbm_virtual_model.dart';
import '../../../data/models/materi/mapel_model.dart';
import '../../../data/models/notifikasi_model.dart';
import '../../../data/models/presensi/riport_presensi_model.dart';
import '../../../data/models/tahun_ajar_model.dart';
import '../../../config/app_image.dart';
import '../../../data/models/status/status_model.dart';
import '../../../data/models/tugas/get_tugas_model.dart';
import '../../../data/providers/network/api_repository.dart';
import '../../../data/providers/network/repository/kbm_virtual_repositori.dart';
import '../../../data/providers/network/repository/notifikasi_repositori.dart';
import '../../../data/providers/network/repository/profil_repositori.dart';
import '../../../data/providers/network/repository/riport_presensi_repositori.dart';
import '../../../data/providers/network/repository/status_siswa_repositori.dart';
import '../../../data/providers/network/repository/tugas_repositori.dart';
import '../../../data/models/profil_model.dart';
import '../../../data/providers/network/repository/mapel_repository.dart';

class HomeController extends GetxController {
  RxString nis = "".obs;
  RxString namaSiswa = "".obs;
  RxString photo = "".obs;
  RxString kelas = "".obs;

  RxBool isLoading = false.obs;
  RxDouble hari = 0.0.obs;
  RxDouble masuk = 0.0.obs;
  RxDouble izin = 0.0.obs;
  RxDouble alfa = 0.0.obs;
  RxDouble sakit = 0.0.obs;
  RxDouble masukIC = 0.0.obs;
  RxDouble izinIC = 0.0.obs;
  RxDouble sakitIC = 0.0.obs;
  RxDouble alfaIC = 0.0.obs;
  RxDouble top = 0.0.obs;
  RxInt countNotif = 0.obs;
  BuildContext? myContext;

  final NotifikasiRepository _notifikasiRepository = NotifikasiRepository();
  final ProfilRepisitori _profilRepisitori = ProfilRepisitori();
  final KbmVirtualRepositori _kbmVirtualRepositori = KbmVirtualRepositori();
  final TugasRepositori _tugasRepositori = TugasRepositori();
  final MapelRepositori _mapelRepositori = MapelRepositori();
  final StatusSiswaRepositori _statusSiswaRepositori = StatusSiswaRepositori();
  final RiportPresensiRepositori _riportPresensiRepositori =
      RiportPresensiRepositori();
  RefreshController toRefersController = RefreshController();

  Future<List<Tugas>?>? initTugas;
  Future<List<DataStatus>?>? initStatus;
  Future<List<DataMapel>?>? initMapel;
  Future<List<DataMapel>?>? initMapelPopUp;
  Future<List<DataKbm>?>? initKbmVirtual;

  final GlobalKey one = GlobalKey();
  final GlobalKey two = GlobalKey();
  final GlobalKey three = GlobalKey();
  final GlobalKey four = GlobalKey();
  final GlobalKey five = GlobalKey();
  final GlobalKey six = GlobalKey();

  List menu = [
    {
      "title": "Jadwal Saya",
      "image": AppImage.menuHome0,
    },
    {
      "title": "Berita",
      "image": AppImage.menuHome1,
    },
    {
      "title": "E-konseling",
      "image": AppImage.menuHome2,
    },
    {
      "title": "Progres saya",
      "image": AppImage.menuHome3,
    }
  ];

  Future<void> skipsCase1() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    await localStorage.setBool("SkipCase0", true);
  }

  Future<bool> getCase() async {
    SharedPreferences getToken = await SharedPreferences.getInstance();
    bool? data = getToken.getBool("SkipCase0");
    if (data != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> getDataProfil() async {
    isLoading.value = true;
    final dataResponse = await _profilRepisitori.getProfil();
    if (dataResponse != null) {
      if (dataResponse.statusResponse == StatusResponse.success) {
        final data =
            Profil.fromJson(jsonDecode(dataResponse.response!)).biodata;
        namaSiswa.value = data!.namaSiswa!;
        photo.value = data.photo!;
        nis.value = data.nis!;
        isLoading.value = false;
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

  Future<void> getDataKelasAktif() async {
    isLoading.value = true;
    final dataResponse = await _profilRepisitori.getKelasAktif();
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

  Future<List<Tugas>?> getDataTugas() async {
    final dataResponse = await _tugasRepositori.getTugasAktif(0, 5);
    if (dataResponse != null) {
      if (dataResponse.statusResponse == StatusResponse.success) {
        final data =
            GetTugas.fromJson(jsonDecode(dataResponse.response!)).data!.tugas;
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

  Future<List<DataMapel>?> getDataMapel() async {
    isLoading.value = true;
    final dataResponse = await _mapelRepositori.getMapel(0, 8);
    if (dataResponse != null) {
      if (dataResponse.statusResponse == StatusResponse.success) {
        final data = Mapel.fromJson(jsonDecode(dataResponse.response!)).data;
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
    throw dataResponse!.message!;
  }

  Future<List<DataStatus>?> getDataStatus() async {
    final dataResponse =
        await _statusSiswaRepositori.getStatusSiswa(0, 5, "status");
    if (dataResponse != null) {
      if (dataResponse.statusResponse == StatusResponse.success) {
        final data = Status.fromJson(jsonDecode(dataResponse.response!)).data;
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

  Future<List<DataMapel>?> getDataMapelPopUp() async {
    isLoading.value = true;
    final dataResponse = await _mapelRepositori.getMapel(0, 300);
    if (dataResponse != null) {
      if (dataResponse.statusResponse == StatusResponse.success) {
        final data = Mapel.fromJson(jsonDecode(dataResponse.response!)).data;
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
    throw dataResponse!.message!;
  }

  Future<List<DataKbm>?> getDataKbmVirtual() async {
    isLoading.value = true;
    final dataResponse = await _kbmVirtualRepositori.getKbmVirtual();
    if (dataResponse != null) {
      if (dataResponse.statusResponse == StatusResponse.success) {
        final data =
            KbmVirtual.fromJson(jsonDecode(dataResponse.response!)).data!.row;
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
    throw dataResponse!.message!;
  }

  Future<void> getDataReport() async {
    final dataResponse = await _riportPresensiRepositori
        .getRiport(DateTime.now().month.toString());
    if (dataResponse != null) {
      if (dataResponse.statusResponse == StatusResponse.success) {
        final data =
            RiportPresensi.fromJson(jsonDecode(dataResponse.response!)).data;
        hari.value = data!.presensiHarian!.jmlHariEfektif!.toDouble();
        masuk.value = data.presensiHarian!.jmlHariEfektif! != 0
            ? data.presensiHarian!.jmlHadir!.toDouble()
            : 0.0;
        izin.value = data.presensiHarian!.jmlHariEfektif! != 0
            ? data.presensiHarian!.jmlIzin!.toDouble()
            : 0.0;
        alfa.value = data.presensiHarian!.jmlHariEfektif! != 0
            ? data.presensiHarian!.jmlAlfa!.toDouble()
            : 0.0;
        sakit.value = data.presensiHarian!.jmlHariEfektif! != 0
            ? data.presensiHarian!.jmlSakit!.toDouble()
            : 0.0;
        masukIC.value = data.presensiHarian!.jmlHariEfektif! != 0
            ? masuk / hari.value
            : 0.0;
        izinIC.value = data.presensiHarian!.jmlHariEfektif! != 0
            ? masukIC.value + izin / hari.value
            : 0.0;
        sakitIC.value = data.presensiHarian!.jmlHariEfektif! != 0
            ? izinIC.value + sakit / hari.value
            : 0.0;
        alfaIC.value = data.presensiHarian!.jmlHariEfektif! != 0
            ? sakitIC.value + alfa / hari.value
            : 0.0;
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

  Future<void> getDataNotifikasi() async {
    final dataResponse = await _notifikasiRepository.getAllNotif();
    if (dataResponse != null) {
      if (dataResponse.statusResponse == StatusResponse.success) {
        final data =
            Notifikasi.fromJson(jsonDecode(dataResponse.response!)).data;
        countNotif.value = data!.length;
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

  Future<void> launchURL(String url) async {
    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  Future<void> toRefres() async {
    initTugas = getDataTugas();
    initStatus = getDataStatus();
    initMapel = getDataMapel();
    initMapelPopUp = getDataMapelPopUp();
    getDataReport();
    getDataProfil();
    getDataKelasAktif();
    toRefersController.refreshCompleted();
  }

  late StreamSubscription<InternetConnectionStatus> listener;

  @override
  void onInit() {
    super.onInit();

    initTugas = getDataTugas();
    initStatus = getDataStatus();
    initMapel = getDataMapel();
    initMapelPopUp = getDataMapelPopUp();
    initKbmVirtual = getDataKbmVirtual();

    getDataReport();
    getDataProfil();
    getDataKelasAktif();
    getDataNotifikasi();

    ambiguate(WidgetsBinding.instance)?.addPostFrameCallback((_) {
      getCase().then((value) {
        if (value == false) {
          ShowCaseWidget.of(myContext!)
              .startShowCase([one, two, three, four, five, six]);
        }
      });
    });

    listener = InternetConnectionChecker().onStatusChange.listen(
      (InternetConnectionStatus status) {
        switch (status) {
          case InternetConnectionStatus.connected:
            initTugas = getDataTugas();
            initStatus = getDataStatus();
            initMapel = getDataMapel();
            initMapelPopUp = getDataMapelPopUp();
            getDataReport();
            getDataProfil();
            getDataKelasAktif();
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
}
