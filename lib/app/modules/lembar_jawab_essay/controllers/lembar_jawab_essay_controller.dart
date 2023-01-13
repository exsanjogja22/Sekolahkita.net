import 'dart:convert';
import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/providers/network/api_repository.dart';
import '../../../data/providers/network/repository/tugas_repositori.dart';
import '../../../routes/app_pages.dart';

class LembarJawabEssayController extends GetxController {
  RxString basename = "no choose file".obs;
  RxString pathFile = "null".obs;
  RxString extensionName = "".obs;
  File? file;
  final TugasRepositori _tugasRepositori = TugasRepositori();
  final TextEditingController desc = TextEditingController();
  final TextEditingController linkEx = TextEditingController();

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;
    final path = result.files.single.path!;
    PlatformFile fl = result.files.first;
    basename.value = path.split('/').last;
    pathFile.value = fl.path!;
    extensionName.value = fl.extension!;
    file = File(path);
  }

  kirimfileJawaban(BuildContext context, String id, bool simpanAkhir) async {
    var body = {
      'tugasid': id,
      'jawaban': desc.text,
      'simpan_akhir': simpanAkhir.toString(),
      'linkjawaban': linkEx.text,
    };

    if (pathFile.value != "null") {
      final dataResponse =
          await _tugasRepositori.postJawabanEssay(body, File(pathFile.value));
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
          } else {
            CoolAlert.show(
                context: context,
                type: CoolAlertType.error,
                title: "Gagal",
                text: it['pesan'],
                confirmBtnTextStyle: GoogleFonts.quicksand(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                onConfirmBtnTap: () {
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
    } else {
      CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          title: "Gagal",
          text: "File gagal terkirim",
          confirmBtnTextStyle: GoogleFonts.quicksand(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          onConfirmBtnTap: () {
            Get.back();
          });
    }
  }
}
