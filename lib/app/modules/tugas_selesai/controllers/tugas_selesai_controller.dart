import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../data/models/tugas/get_tugas_model.dart';
import '../../../data/providers/network/api_repository.dart';
import '../../../data/providers/network/repository/tugas_repositori.dart';

class TugasSelesaiController extends GetxController {
  RxDouble titleHeight = 20.0.obs;
  RxDouble itemsHeight = 170.0.obs;
  RxInt limit = 5.obs;
  RxInt offset = 0.obs;
  RxInt selected = 0.obs;
  RxInt max = 0.obs;

  List bulan = [
    "Januari",
    "Februari",
    "Maret",
    "April",
    "Mei",
    "Juni",
    "Juli",
    "Agustus",
    "September",
    "Oktober",
    "November",
    "Desember",
  ];

  String? selectedBulan;
  TabController? tabController;
  RefreshController refreshController = RefreshController();
  Future<ResponseApi?>? _tugasRepositori;
  var listTugasSelesai = List<Tugas>.empty().obs;

  getDataTugasSelesai() async {
    final dataResponse = await _tugasRepositori;
    if (dataResponse != null) {
      if (dataResponse.statusResponse == StatusResponse.success) {
        final data =
            GetTugas.fromJson(jsonDecode(dataResponse.response!)).data!.tugas;
        max.value = GetTugas.fromJson(jsonDecode(dataResponse.response!))
            .data!
            .totalTugas!;
        listTugasSelesai.clear();
        for (var i in data!) {
          listTugasSelesai.add(i);
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
    listTugasSelesai.clear();
    _tugasRepositori = TugasRepositori().getTugasSelesai(0, 5);
    await getDataTugasSelesai();
    refreshController.refreshCompleted();
  }

  void onLoading() async {
    limit.value = limit.value + 5;
    _tugasRepositori =
        TugasRepositori().getTugasSelesai(offset.value, limit.value);
    await getDataTugasSelesai();
    refreshController.loadComplete();
  }

  @override
  void onInit() {
    super.onInit();

    _tugasRepositori = TugasRepositori().getTugasSelesai(0, 5);
    getDataTugasSelesai();
  }
}
