import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../../data/models/profil_model.dart';
import '../../../data/providers/network/api_repository.dart';
import '../../../data/models/status/status_model.dart';
import '../../../data/providers/network/repository/profil_repositori.dart';
import '../../../data/providers/network/repository/status_siswa_repositori.dart';

class ProfilController extends GetxController {
  RxInt limit = 100.obs;
  RxInt offset = 0.obs;
  RxDouble top = 0.0.obs;
  RxString nis = "".obs;
  RxString namaSiswa = "".obs;
  RxString photo = "".obs;
  RxString token = "".obs;
  RxBool isLoading = false.obs;
  late StreamSubscription<InternetConnectionStatus> listener;
  Future<ResponseApi?>? _profilRepisitori;
  Future<ResponseApi?>? _statusSiswaRepositori;
  var listStatus = List<DataStatus>.empty().obs;

  getData() async {
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

  getDataStatus() async {
    final dataResponse = await _statusSiswaRepositori;
    if (dataResponse != null) {
      if (dataResponse.statusResponse == StatusResponse.success) {
        final data = Status.fromJson(jsonDecode(dataResponse.response!)).data;
        final dataFilter =
            data!.where((element) => element.nama == namaSiswa.value).toList();
        for (var i in dataFilter) {
          listStatus.add(i);
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

  @override
  void onInit() {
    _profilRepisitori = ProfilRepisitori().getProfil();
    _statusSiswaRepositori =
        StatusSiswaRepositori().getStatusSiswa(offset.value, limit.value, "");
    getData();
    getDataStatus();

    listener = InternetConnectionChecker().onStatusChange.listen(
      (InternetConnectionStatus status) {
        switch (status) {
          case InternetConnectionStatus.connected:
            getData();
            break;
          case InternetConnectionStatus.disconnected:
            Get.snackbar("Gagal", "Koneksi Internet tidak terhubung",
                snackPosition: SnackPosition.BOTTOM,
                colorText: Colors.red,
                backgroundColor: Colors.red.withOpacity(0.4));

            break;
        }
      },
    );

    super.onInit();
  }
}
