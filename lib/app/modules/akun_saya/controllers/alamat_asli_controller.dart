import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../data/models/kabupaten_model.dart';
import '../../../data/models/kecamatan_model.dart';
import '../../../data/models/provinsi_model.dart';
import '../../../data/providers/network/api_repository.dart';
import '../../../data/providers/network/repository/profil_repositori.dart';
import 'akun_saya_controller.dart';

class AlamatAsliController extends GetxController {
  String? selecteProvinsi;
  String? selecteKabupaten;
  String? selecteKecamatan;

  RxString sprovinsi = "".obs;
  RxString skabupaten = "".obs;
  RxString skecamatan = "".obs;

  RxBool isLoadingProvinsi = false.obs;
  RxBool isLoadingKabupatenKoata = false.obs;
  RxBool isLoadingKecamatanKoata = false.obs;

  var listProvinsi = <Provinsi>[].obs;
  var listKabupatenKota = <KotaKabupaten>[].obs;
  var listKecamatanKota = <Kecamatan>[].obs;

  final _akunSayaController = Get.find<AkunSayaController>();
  final ProfilRepisitori _profilRepisitori = ProfilRepisitori();
  final TextEditingController alamatLengkap = TextEditingController();

  Future<void> provinsi() async {
    isLoadingProvinsi.value = true;
    final response = await http.get(
      Uri.parse('https://dev.farizdotid.com/api/daerahindonesia/provinsi'),
    );
    if (response.statusCode == 200) {
      final data = ProvinsiData.fromJson(jsonDecode(response.body)).provinsi;
      for (var i in data!) {
        listProvinsi.add(i);
      }
      isLoadingProvinsi.value = false;
      update();
    }
  }

  Future<void> kabupatenKota(String id) async {
    isLoadingKabupatenKoata.value = true;
    final response = await http.get(
      Uri.parse(
          'https://dev.farizdotid.com/api/daerahindonesia/kota?id_provinsi=$id'),
    );
    if (response.statusCode == 200) {
      final data =
          KabupatenData.fromJson(jsonDecode(response.body)).kotaKabupaten;
      for (var i in data!) {
        listKabupatenKota.add(i);
      }
      isLoadingKabupatenKoata.value = false;

      update();
    }
  }

  Future<void> kecamatanKota(String id) async {
    isLoadingKecamatanKoata.value = true;
    final response = await http.get(
      Uri.parse(
          'https://dev.farizdotid.com/api/daerahindonesia/kecamatan?id_kota=$id'),
    );
    if (response.statusCode == 200) {
      final data = KecamatanData.fromJson(jsonDecode(response.body)).kecamatan;
      for (var i in data!) {
        listKecamatanKota.add(i);
      }
      isLoadingKecamatanKoata.value = false;
      update();
    }
  }

  Future<void> updateProfil(BuildContext context) async {
    final response1 = await http.get(
      Uri.parse('https://dev.farizdotid.com/api/daerahindonesia/provinsi'),
    );
    if (response1.statusCode == 200) {
      final data = ProvinsiData.fromJson(jsonDecode(response1.body)).provinsi;
      final p =
          data!.where((element) => element.id.toString() == selecteProvinsi);
      for (var i in p) {
        sprovinsi.value = i.nama!;
      }
    }

    final response2 = await http.get(
      Uri.parse(
          'https://dev.farizdotid.com/api/daerahindonesia/kota?id_provinsi=$selecteProvinsi'),
    );
    if (response2.statusCode == 200) {
      final data =
          KabupatenData.fromJson(jsonDecode(response2.body)).kotaKabupaten;
      final p =
          data!.where((element) => element.id.toString() == selecteKabupaten);
      for (var i in p) {
        skabupaten.value = i.nama!;
      }
    }

    final response3 = await http.get(
      Uri.parse(
          'https://dev.farizdotid.com/api/daerahindonesia/kecamatan?id_kota=$selecteKabupaten'),
    );
    if (response3.statusCode == 200) {
      final data = KecamatanData.fromJson(jsonDecode(response3.body)).kecamatan;
      final p =
          data!.where((element) => element.id.toString() == selecteKecamatan);
      for (var i in p) {
        skecamatan.value = i.nama!;
      }
    }
    final data = ({
      'alamat_asli':
          '${alamatLengkap.text}, ${skecamatan.value}, ${skabupaten.value}, ${sprovinsi.value}'
    });

    final dataResponse = await _profilRepisitori.postProfil(data);
    if (dataResponse != null) {
      if (dataResponse.statusResponse == StatusResponse.success) {
        var it = jsonDecode(dataResponse.response!);
        if (it["status"] == true) {
          _akunSayaController.getDataProfil();

          Get.back();
        } else {
          CoolAlert.show(
              context: context,
              type: CoolAlertType.error,
              title: "Gagal",
              text: it["pesan"].toString(),
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
  }

  @override
  void onInit() {
    super.onInit();
    provinsi();
  }
}
