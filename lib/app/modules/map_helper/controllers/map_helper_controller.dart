import 'dart:convert';

import 'package:app_settings/app_settings.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';

import '../../../data/models/presensi/config_siswa_model.dart';
import '../../../config/app_location_service.dart';
import '../../../data/providers/network/api_repository.dart';
import '../../../data/providers/network/repository/presensi_harian_repositori.dart';
import '../../mainpage/controllers/presensi_controller.dart';

class MapHelperController extends GetxController {
  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;
  RxDouble systemLatitude = (-7.8687593385440910).obs;
  RxDouble systemLongitude = 110.39520564055954.obs;
  RxDouble systemRadius = 0.0.obs;
  RxBool isLoading = false.obs;

  final LocationService locationService = LocationService();

  Completer<GoogleMapController> controllerMap = Completer();

  GoogleMapController? controller;
  PresensiHarianRepositori? _presensiHarianRepositori;

  final presensiC = Get.put(PresensiController());

  Future<void> goToTheLake(double latitude, double longitude) async {
    final GoogleMapController controller = await controllerMap.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(latitude, longitude), zoom: 16.0)));
  }

  getDataAturanPresensiHarian() async {
    final dataResponse =
        await _presensiHarianRepositori?.getAturanPresensiHarian();
    if (dataResponse != null) {
      if (dataResponse.statusResponse == StatusResponse.success) {
        final data =
            ConfigSiswa.fromJson(jsonDecode(dataResponse.response!)).data;
        systemLatitude.value = data!.systemLatitude!;
        systemLongitude.value = data.systemLongitude!;
        systemRadius.value = data.systemRadius!.toDouble();

        goToTheLake(data.systemLatitude!, data.systemLongitude!);
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

  postDataPresensi(BuildContext context, String t) async {
    isLoading.value = true;
    var status = await Permission.locationAlways.status;
    var status2 = await Permission.locationWhenInUse.status;
    bool jailbroken = await FlutterJailbreakDetection.jailbroken;
    bool developerMode = await FlutterJailbreakDetection.developerMode;
    if (!status.isGranted && !status2.isGranted) {
      isLoading.value = false;
      CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          title: "Gagal",
          text: "Hidupkan Gps anda pastikan gps anda mode akurasi tinggi",
          confirmBtnTextStyle: GoogleFonts.quicksand(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          onConfirmBtnTap: () async {
            await Permission.locationAlways.request();
            await Permission.locationWhenInUse.request();
            AppSettings.openLocationSettings();
            Get.back();
          });
    } else {
      if (jailbroken != true && developerMode != true) {
        final dataResponse = await _presensiHarianRepositori
            ?.postPresensiHarian(latitude.value, longitude.value, t);
        if (dataResponse != null) {
          var it = jsonDecode(dataResponse.response!);
          if (it['status'] == true) {
            isLoading.value = false;
            CoolAlert.show(
                context: context,
                type: CoolAlertType.success,
                title: "Berhasil",
                text: "Kamu berhasil absen!",
                confirmBtnTextStyle: GoogleFonts.quicksand(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                onConfirmBtnTap: () {
                  presensiC.presensiHarianRepositori =
                      _presensiHarianRepositori?.getPresensiHarian();
                  presensiC.stateGetPresensiHarian =
                      presensiC.getDataPresensiHarian();
                  presensiC.update([1]);
                  Get.back();
                  Get.back();
                });
          } else {
            isLoading.value = false;
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
                  Get.back();
                });
          }
        } else {
          isLoading.value = false;
          CoolAlert.show(
            context: context,
            type: CoolAlertType.warning,
            title: "Internet",
            text: "Tejadi kesalahan, priksa koneksi internet anda",
            confirmBtnTextStyle: GoogleFonts.quicksand(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            onConfirmBtnTap: () async {
              Get.back();
            },
          );
        }
      } else {
        isLoading.value = false;
        CoolAlert.show(
          context: context,
          type: CoolAlertType.warning,
          title: "Peringatan",
          text:
              "Matikan fitur opsi pengembang pada pengaturan hp anda, apabila tidak bisa gunakan perangkat lain yang tidak di modifikasi",
          confirmBtnTextStyle: GoogleFonts.quicksand(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          onConfirmBtnTap: () async {
            AppSettings.openDevelopmentSettings();
            Get.back();
          },
        );
      }
    }
  }

  @override
  void onInit() {
    _presensiHarianRepositori = PresensiHarianRepositori();
    locationService.locationStream.listen((userLocation) {
      latitude.value = userLocation.latitude!;
      longitude.value = userLocation.longtitude!;
    });
    getDataAturanPresensiHarian();
    super.onInit();
  }

  @override
  void dispose() {
    locationService.dispose();
    super.dispose();
  }
}
