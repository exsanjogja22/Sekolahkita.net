import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../data/models/materi/materi_model.dart';
import '../../../data/models/materi/topik_materi_model.dart';
import '../../../data/providers/network/api_repository.dart';
import '../../../data/providers/network/repository/materi_repositori.dart';

class ListMateriController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxDouble top = 0.0.obs;
  RxInt limit = 6.obs;
  RxInt offset = 0.obs;
  RxInt max = 0.obs;
  RxString parmId = "".obs;
  RxString topikDetail = "".obs;
  String selected = "0";

  List<ListMateri> listMateri2 = [];
  List<ListMateri> listSearchMateri = [];

  final MateriRepositori _materiRepositori = MateriRepositori();
  RefreshController refreshController = RefreshController();
  List<DataTopik> topik = [];
  var listMateri = List<ListMateri>.empty().obs;

  Future<List<ListMateri>?> getDataMateri(String id) async {
    getDataTopik(id);

    final dataResponse = await _materiRepositori.getMateri(
        id, selected, limit.value, offset.value);
    if (dataResponse != null) {
      if (dataResponse.statusResponse == StatusResponse.success) {
        final data =
            Materi.fromJson(jsonDecode(dataResponse.response!)).dataMateri;
        topikDetail.value = data!.topik!;
        max.value = int.parse(data.totalData!);
        listMateri.clear();
        for (var i in data.data!) {
          listMateri.add(i);
        }
        parmId.value = id;
        return listMateri;
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

  Future<void> getDataMateriSearch(String id) async {
    final dataResponse = await _materiRepositori.getMateri(id, "", 1000, 0);
    if (dataResponse != null) {
      if (dataResponse.statusResponse == StatusResponse.success) {
        final data = Materi.fromJson(jsonDecode(dataResponse.response!))
            .dataMateri!
            .data;
        listMateri.clear();
        for (var i in data!) {
          listMateri.add(i);
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

  Future<void> getDataTopik(String id) async {
    final dataResponse = await _materiRepositori.getMateriTopik(id);
    if (dataResponse != null) {
      if (dataResponse.statusResponse == StatusResponse.success) {
        final data =
            TopikMateri.fromJson(jsonDecode(dataResponse.response!)).data;
        topik = data!;
        update([1]);
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
    limit.value = 6;
    offset.value = 0;
    listMateri.clear();
    await Future.delayed(const Duration(seconds: 2));
    update([2]);

    refreshController.refreshCompleted();
  }

  void onLoading() async {
    if (listMateri.length != max.value) {
      limit.value = limit.value + 6;
      offset.value = offset.value + 6;
      await Future.delayed(const Duration(seconds: 2));
      update([2]);
    }
    refreshController.loadComplete();
  }

  @override
  void dispose() {
    refreshController.dispose();

    super.dispose();
  }
}
