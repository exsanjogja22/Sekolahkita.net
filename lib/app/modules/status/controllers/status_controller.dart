import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../data/models/profil_model.dart';
import '../../../data/models/status/status_model.dart';
import '../../../data/providers/network/api_repository.dart';
import '../../../data/providers/network/repository/profil_repositori.dart';
import '../../../data/providers/network/repository/status_siswa_repositori.dart';

class StatusController extends GetxController {
  RxInt limit = 5.obs;
  RxInt offset = 0.obs;
  RxString namaSiswa = "".obs;
  RxString photo = "".obs;
  RefreshController refreshController = RefreshController();

  final ProfilRepisitori _profilRepisitori = ProfilRepisitori();
  final StatusSiswaRepositori statusSiswaRepositori = StatusSiswaRepositori();

  var listStatus = List<DataStatus>.empty().obs;

  Future<void> getDataProfil() async {
    final dataResponse = await _profilRepisitori.getProfil();
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

  Future<void> getDataStatus() async {
    final dataResponse = await statusSiswaRepositori.getStatusSiswa(
        offset.value, limit.value, "");
    if (dataResponse != null) {
      if (dataResponse.statusResponse == StatusResponse.success) {
        final data = Status.fromJson(jsonDecode(dataResponse.response!)).data;
        final dataFilter = data!
            .where((element) =>
                element.tipe == "status" || element.tipe == "pengumuman")
            .toList();
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

  void onRefresh() async {
    limit.value = 5;
    offset.value = 0;
    listStatus.clear();
    statusSiswaRepositori.getStatusSiswa(offset.value, limit.value, "");
    await getDataStatus();
    refreshController.refreshCompleted();
  }

  void onLoading() async {
    limit.value = limit.value + 5;
    offset.value = offset.value + 5;
    statusSiswaRepositori.getStatusSiswa(offset.value, limit.value, "");
    await getDataStatus();
    refreshController.loadComplete();
  }

  @override
  void onInit() {
    super.onInit();

    getDataProfil();
    getDataStatus();
  }

  @override
  void dispose() {
    super.dispose();
    refreshController.dispose();
  }
}
