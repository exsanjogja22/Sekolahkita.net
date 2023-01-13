import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:smkn1contoh/app/config/app_colors.dart';

import '../../../data/models/profil_model.dart';
import '../../../data/providers/network/api_repository.dart';
import '../../../data/providers/network/repository/profil_repositori.dart';

class AkunSayaController extends GetxController {
  RxString nama = "".obs;
  RxString nis = "".obs;
  RxString asalSekolah = "Set Sekarang".obs;
  RxString jenisKelamin = "Set Sekarang".obs;
  RxString alamatAsli = "Set Sekarang".obs;
  RxString alamatTinggal = "Set Sekarang".obs;
  RxString phone = "Set Sekarang".obs;
  RxString agama = "Set Sekarang".obs;
  RxString photo = "".obs;
  RxString tempatLahir = "Set Sekarang".obs;
  RxString tanggalLahir = "Set Sekarang".obs;
  File? file;
  RxString tanggalLahir1 = "Set Sekarang".obs;

  final ProfilRepisitori _profilRepisitori = ProfilRepisitori();

  Future<void> getDataProfil() async {
    final dataResponse = await _profilRepisitori.getProfil();
    if (dataResponse != null) {
      if (dataResponse.statusResponse == StatusResponse.success) {
        final data =
            Profil.fromJson(jsonDecode(dataResponse.response!)).biodata;
        if (data!.namaSiswa != "") {
          nama.value = data.namaSiswa!;
        } else {
          nama.value = "Set Sekarang";
        }

        if (data.sekolahAsal != "") {
          asalSekolah.value = data.sekolahAsal!;
        } else {
          asalSekolah.value = "Set Sekarang";
        }

        if (data.jenisKelamin == "L") {
          jenisKelamin.value = "Laki-Laki";
        } else if (data.jenisKelamin == "P") {
          jenisKelamin.value = "Perempuan";
        } else {
          jenisKelamin.value = "Set Sekarang";
        }

        if (data.agama != "") {
          switch (data.agama) {
            case 'Islam':
              agama.value = "Islam";
              break;
            case 'Kristen':
              agama.value = "Kristen";
              break;
            case 'Katholik':
              agama.value = "Katholik";
              break;
            case 'Budha':
              agama.value = "Budha";
              break;
            case 'Hindu':
              agama.value = "Hindu";
              break;
            case 'Kepercayaan':
              agama.value = "Kepercayaan";
              break;
          }
        } else {
          agama.value = "Set Sekarang";
        }
        if (data.alamatAsli != "") {
          alamatAsli.value = data.alamatAsli!;
        } else {
          alamatAsli.value = "Set Sekarang";
        }

        if (data.alamatTinggal != "") {
          alamatTinggal.value = data.alamatTinggal!;
        } else {
          alamatTinggal.value = "Set Sekarang";
        }

        if (data.phone != "") {
          phone.value = data.phone!;
        } else {
          phone.value = "Set Sekarang";
        }
        if (data.photo != "") {
          photo.value = data.photo!;
        } else {
          photo.value = "Set Sekarang";
        }
        if (data.tempatLahir != "") {
          tempatLahir.value = data.tempatLahir!;
        } else {
          tempatLahir.value = "Set Sekarang";
        }

        if (data.tglLahir != null) {
          tanggalLahir.value =
              DateFormat("d MMMM yyyy", "id_ID").format(data.tglLahir!);
          tanggalLahir1.value = data.tglLahir!.toString();
        } else {
          tanggalLahir.value = "Set Sekarang";
        }

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

  Future<void> postData(File fileImg) async {
    Map<String, String> data = {};
    final dataResponse = await _profilRepisitori.postFotoProfil(data, fileImg);
    if (dataResponse != null) {
      if (dataResponse.statusResponse == StatusResponse.success) {
        var it = jsonDecode(dataResponse.response!);
        if (it["status"] == true) {
          await getDataProfil();
          update();
          Get.snackbar("Berhasil", "${it["pesan"]}",
              snackPosition: SnackPosition.BOTTOM,
              colorText: AppColors.appGreenlight,
              backgroundColor: AppColors.appGreenlight.withOpacity(0.4));
        } else {
          Get.snackbar("Gagal", "${it["pesan"]}",
              snackPosition: SnackPosition.BOTTOM,
              colorText: Colors.red,
              backgroundColor: Colors.red.withOpacity(0.4));
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

  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? cropedImage =
        await ImageCropper().cropImage(sourcePath: imageFile.path);
    if (cropedImage == null) return null;
    postData(File(cropedImage.path));
    return File(cropedImage.path);
  }

  Future<void> selectImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);
      img = await _cropImage(imageFile: img);
      file = img;
      Get.back();
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      Get.back();
    }
  }

  @override
  void onInit() {
    getDataProfil();
    super.onInit();
  }
}
