import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../data/models/materi/mapel_model.dart';
import '../../../data/models/tugas/get_tugas_model.dart';
import '../../../data/providers/network/api_repository.dart';
import '../../../data/providers/network/repository/tugas_repositori.dart';

class TugasAktifController extends GetxController
    with GetSingleTickerProviderStateMixin {
  TabController? tabController;
  RxDouble titleHeight = 20.0.obs;

  RefreshController refreshController = RefreshController();
  final TugasRepositori _tugasRepositori = TugasRepositori();

  List<Tugas> listTugas2 = [];
  List<Tugas> listSearch = [];

  RxInt selected = 0.obs;
  RxInt limit = 5.obs;
  RxInt offset = 0.obs;
  RxInt max = 0.obs;

  var listTugas = List<Tugas>.empty().obs;
  var listMapel = List<DataMapel>.empty().obs;

  Future<void> getDataTugasAktifSearch() async {
    final dataResponse = await _tugasRepositori.getTugasAktif(0, 100);
    if (dataResponse != null) {
      if (dataResponse.statusResponse == StatusResponse.success) {
        final data =
            GetTugas.fromJson(jsonDecode(dataResponse.response!)).data!.tugas;

        for (var i in data!) {
          listTugas2.add(i);
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

  Future<void> getDataTugasAktif() async {
    final dataResponse =
        await _tugasRepositori.getTugasAktif(offset.value, limit.value);
    if (dataResponse != null) {
      if (dataResponse.statusResponse == StatusResponse.success) {
        final data =
            GetTugas.fromJson(jsonDecode(dataResponse.response!)).data!.tugas;
        max.value = GetTugas.fromJson(jsonDecode(dataResponse.response!))
            .data!
            .totalTugas!;
        for (var i in data!) {
          listTugas.add(i);
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
    listTugas.clear();
    await getDataTugasAktif();
    refreshController.refreshCompleted();
  }

  void onLoading() async {
    limit.value = limit.value + 5;
    offset.value = offset.value + 5;
    if (listTugas.length != max.value) {
      await getDataTugasAktif();
    }
    refreshController.loadComplete();
  }

  @override
  void onInit() {
    super.onInit();

    getDataTugasAktif();
    getDataTugasAktifSearch();
  }
}
