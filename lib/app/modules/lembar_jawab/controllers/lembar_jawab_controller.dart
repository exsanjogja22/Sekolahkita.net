import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:smkn1contoh/app/routes/app_pages.dart';

import '../../../config/app_options.dart';
import '../../../data/models/tugas/soal_pg_model.dart';
import '../../../data/providers/network/api_repository.dart';
import '../../../data/providers/network/repository/tugas_repositori.dart';

class LembarJawabController extends GetxController {
  final scrollcontroller = ItemScrollController();
  final scrollListener = ItemPositionsListener.create();
  final TugasRepositori _tugasDetailRepositori = TugasRepositori();
  RxInt off = 0.obs;
  RxDouble jumlahSoal = 20.0.obs;
  List<Data> optionSoal = [];

  Future<void> getDataSoalPg(
      BuildContext context, String id, int jumlahSoal) async {
    final dataResponse = await _tugasDetailRepositori.getDetailSoal(id);
    if (dataResponse != null) {
      if (dataResponse.statusResponse == StatusResponse.success) {
        final data = SoalPg.fromJson(jsonDecode(dataResponse.response!))
            .data!
            .opsijawaban;
        for (var i = 1; i <= data!.length; i++) {
          optionSoal.addAll({
            Data(nomor: i, option: ["A", "B", "C", "D", "E"]),
          });
        }
        for (var element in data) {
          for (var e in element.opsi!) {
            if (e.status == "selected") {
              optionSoal[element.nomor! - 1].key = e.key;
            }
          }
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

  kirimOption(BuildContext context, bool simpanAkhir, String id) async {
    final data = optionSoal.where((element) => element.key != null).toList();
    var body = {'idtugas': id, 'simpan_akhir': '$simpanAkhir'};
    for (var i in data) {
      body.addAll({
        'jawab[${i.nomor! - 1}]': '${i.key}',
      });
    }
    final dataResponse = await _tugasDetailRepositori.postJawabanPg(body);
    if (dataResponse != null) {
      if (dataResponse.statusResponse == StatusResponse.success) {
        var it = jsonDecode(dataResponse.response!);
        if (it['status'] == true) {
          CoolAlert.show(
              context: context,
              type: CoolAlertType.success,
              title: "Berhasil",
              text: "Kamu berhasil menyimpan jawaban",
              confirmBtnTextStyle: GoogleFonts.quicksand(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              onConfirmBtnTap: () {
                Get.offAllNamed(Routes.TUGAS);
                Get.back();
              });
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

  Future scrollTo() async {
    off.value = off.value + 5;
    await scrollcontroller.scrollTo(
        index: off.value, duration: const Duration(seconds: 1));
  }

  Future scrollBack() async {
    off.value = off.value - 5;
    await scrollcontroller.scrollTo(
        index: off.value, duration: const Duration(seconds: 1));
  }
}
