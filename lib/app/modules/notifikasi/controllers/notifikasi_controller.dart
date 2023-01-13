import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:smkn1contoh/app/data/models/notifikasi_model.dart';
import 'package:smkn1contoh/app/data/providers/network/repository/notifikasi_repositori.dart';

import '../../../data/providers/network/api_repository.dart';

class NotifikasiController extends GetxController {
  final NotifikasiRepository _notifikasiRepository = NotifikasiRepository();
  Future<List<Data>?>? initNotifikasi;

  Future<List<Data>?> getDataNotifikasi() async {
    final dataResponse = await _notifikasiRepository.getAllNotif();
    if (dataResponse != null) {
      if (dataResponse.statusResponse == StatusResponse.success) {
        final data =
            Notifikasi.fromJson(jsonDecode(dataResponse.response!)).data;
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
    initNotifikasi = getDataNotifikasi();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.onInit();
  }
}
