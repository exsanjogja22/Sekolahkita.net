import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../config/app_location_service.dart';
import '../../../data/providers/network/api_repository.dart';
import '../../../data/providers/network/repository/presensi_harian_repositori.dart';
import '../../../data/providers/network/repository/presensi_kegiatan_repositori.dart';
import '../widget/presensi/presensi_kegitan_widget.dart';
import 'presensi_controller.dart';

class PostPresensiController extends GetxController {
  RxBool isLoadingUpload = false.obs;
  RxBool isLoadingEvent = false.obs;

  String? selectedIzin;
  File? file;
  late StreamSubscription<InternetConnectionStatus> listener;

  RxString basename = "no choose file".obs;
  RxString pathCameraImage = "null".obs;

  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;

  final TextEditingController mkNote = TextEditingController(text: "");

  final LocationService locationService = LocationService();

  final PresensiHarianRepositori _presensiHarianRepositori =
      PresensiHarianRepositori();
  final PresensiKegiatanRepositori _presensiKegiatanRepositori =
      PresensiKegiatanRepositori();

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;
    basename.value = path.split('/').last;
    file = File(path);
  }

  postSuratIzinPresensi(BuildContext context) async {
    isLoadingUpload.value = true;
    if (selectedIzin != null && file != null) {
      final dataResponse = await _presensiHarianRepositori.postSuratIzin(
          selectedIzin!, File(file!.path));
      if (dataResponse != null) {
        if (dataResponse.statusResponse == StatusResponse.success) {
          var it = jsonDecode(dataResponse.response!);
          if (it['status'] == true) {
            isLoadingUpload.value = false;
            CoolAlert.show(
                context: context,
                type: CoolAlertType.success,
                title: "Berhasil",
                text: "Terkirim!",
                onConfirmBtnTap: () {
                  Get.back();
                });
          } else {
            isLoadingUpload.value = false;
            CoolAlert.show(
                context: context,
                type: CoolAlertType.error,
                title: "Gagal",
                text: it['pesan'],
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
        isLoadingUpload.value = false;
        Get.snackbar("Gagal", "Koneksi Internet tidak terhubung",
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.red,
            backgroundColor: Colors.red.withOpacity(0.4));
      }
    } else {
      isLoadingUpload.value = false;
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        title: "Gagal",
        text: "Keterangan & File tidak boleh kosong",
        confirmBtnTextStyle: GoogleFonts.quicksand(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        onConfirmBtnTap: () async {
          Get.back();
        },
      );
    }
  }

  postEvenUseFile(BuildContext context, String mkKode,
      PresensiController presensiController) async {
    isLoadingEvent.value = true;
    if (pathCameraImage.value != "null") {
      final dataResponse = await _presensiKegiatanRepositori.postEventUseFile(
        File(pathCameraImage.value),
        mkKode,
        mkNote.text,
        latitude.value.toString(),
        longitude.value.toString(),
      );
      if (dataResponse != null) {
        if (dataResponse.statusResponse == StatusResponse.success) {
          var it = jsonDecode(dataResponse.response!);
          if (it["status"] == true) {
            isLoadingEvent.value = false;
            CoolAlert.show(
                context: context,
                type: CoolAlertType.success,
                title: "Berhasil",
                text: it["pesan"].toString(),
                confirmBtnTextStyle: GoogleFonts.quicksand(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                onConfirmBtnTap: () {
                  presensiController.presensiKegiatanRepositori =
                      _presensiKegiatanRepositori.getListEvent();
                  presensiController.stateGetPresensiKegitan =
                      presensiController.getDataPresensiKegiatan();

                  presensiController.update([2]);
                  Get.back();
                  Get.back();
                });
          } else {
            isLoadingEvent.value = false;
            CoolAlert.show(
                context: context,
                type: CoolAlertType.warning,
                title: "Peringatan !",
                text: it["pesan"].toString(),
                confirmBtnTextStyle: GoogleFonts.quicksand(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                onConfirmBtnTap: () {
                  presensiController.presensiKegiatanRepositori =
                      _presensiKegiatanRepositori.getListEvent();
                  presensiController.stateGetPresensiKegitan =
                      presensiController.getDataPresensiKegiatan();

                  presensiController.update([2]);
                  Get.back();
                  Get.back();
                });
          }
        } else {
          if (kDebugMode) {
            print(dataResponse.message);
          }
        }
      } else {
        isLoadingEvent.value = false;
        Get.snackbar("Gagal", "Koneksi Internet tidak terhubung",
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.red,
            backgroundColor: Colors.red.withOpacity(0.4));
      }
    } else {
      isLoadingEvent.value = false;
      CoolAlert.show(
        context: context,
        type: CoolAlertType.warning,
        title: "Peringatan",
        text: "Presensi harus di sertai foto ya !",
        confirmBtnTextStyle: GoogleFonts.quicksand(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        onConfirmBtnTap: () async {
          Get.back();
        },
      );
    }
  }

  postEvent(
      BuildContext context,
      bool sudahPresensi,
      bool buttonStatus,
      bool usePhoto,
      bool useGps,
      String mkKode,
      PresensiController presensiController) async {
    var status = await Permission.locationAlways.status;
    var status2 = await Permission.locationWhenInUse.status;
    bool jailbroken = await FlutterJailbreakDetection.jailbroken;
    bool developerMode = await FlutterJailbreakDetection.developerMode;
    if (buttonStatus == true) {
      if (sudahPresensi == false) {
        if (usePhoto == true && useGps == true) {
          if (!status.isGranted && !status2.isGranted) {
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
              showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    return PopUpCamera(
                      useGps: useGps,
                      mkKode: mkKode,
                      controller: presensiController,
                    );
                  });
            } else {
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
                  });
            }
          }
        } else if (usePhoto == true && useGps == false) {
          showModalBottomSheet(
              backgroundColor: Colors.transparent,
              context: context,
              isScrollControlled: true,
              builder: (context) {
                return PopUpCamera(
                  useGps: useGps,
                  mkKode: mkKode,
                  controller: presensiController,
                );
              });
        } else if (usePhoto == false && useGps == true) {
          if (!status.isGranted && !status2.isGranted) {
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
              final dataResponse = await _presensiKegiatanRepositori.postEvent(
                mkKode,
                mkNote.text,
                latitude.value.toString(),
                longitude.value.toString(),
              );
              if (dataResponse != null) {
                if (dataResponse.statusResponse == StatusResponse.success) {
                  var it = jsonDecode(dataResponse.response!);
                  if (it["status"] == true) {
                    CoolAlert.show(
                        context: context,
                        type: CoolAlertType.success,
                        title: "Berhasil",
                        text: it["pesan"].toString(),
                        confirmBtnTextStyle: GoogleFonts.quicksand(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        onConfirmBtnTap: () {
                          presensiController.presensiKegiatanRepositori =
                              _presensiKegiatanRepositori.getListEvent();
                          presensiController.stateGetPresensiKegitan =
                              presensiController.getDataPresensiKegiatan();
                          presensiController.update([2]);
                          Get.back();
                        });
                  } else {
                    CoolAlert.show(
                        context: context,
                        type: CoolAlertType.warning,
                        title: "Peringatan !",
                        text: it["pesan"].toString(),
                        confirmBtnTextStyle: GoogleFonts.quicksand(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        onConfirmBtnTap: () {
                          presensiController.presensiKegiatanRepositori =
                              _presensiKegiatanRepositori.getListEvent();
                          presensiController.stateGetPresensiKegitan =
                              presensiController.getDataPresensiKegiatan();
                          presensiController.update([2]);
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
                  });
            }
          }
        } else {
          final dataResponse = await _presensiKegiatanRepositori.postEvent(
            mkKode,
            mkNote.text,
            latitude.value.toString(),
            longitude.value.toString(),
          );
          if (dataResponse != null) {
            if (dataResponse.statusResponse == StatusResponse.success) {
              var it = jsonDecode(dataResponse.response!);
              if (it["status"] == true) {
                CoolAlert.show(
                    context: context,
                    type: CoolAlertType.success,
                    title: "Berhasil",
                    text: it["pesan"].toString(),
                    confirmBtnTextStyle: GoogleFonts.quicksand(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    onConfirmBtnTap: () {
                      presensiController.presensiKegiatanRepositori =
                          _presensiKegiatanRepositori.getListEvent();
                      presensiController.stateGetPresensiKegitan =
                          presensiController.getDataPresensiKegiatan();
                      presensiController.update([2]);
                      Get.back();
                    });
              } else {
                CoolAlert.show(
                    context: context,
                    type: CoolAlertType.warning,
                    title: "Peringatan !",
                    text: it["pesan"].toString(),
                    confirmBtnTextStyle: GoogleFonts.quicksand(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    onConfirmBtnTap: () {
                      presensiController.presensiKegiatanRepositori =
                          _presensiKegiatanRepositori.getListEvent();
                      presensiController.stateGetPresensiKegitan =
                          presensiController.getDataPresensiKegiatan();
                      presensiController.update([2]);
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
      } else {
        CoolAlert.show(
            context: context,
            type: CoolAlertType.warning,
            title: "Peringatan !",
            text: "Anda sudah melakukan presensi",
            confirmBtnTextStyle: GoogleFonts.quicksand(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            onConfirmBtnTap: () {
              Get.back();
            });
      }
    } else {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.warning,
        title: "Peringatan !",
        text:
            "Presensi untuk kegiatan ini belum aktif silahkan presensi sesuai waktu yang sudah di tentukan",
        confirmBtnTextStyle: GoogleFonts.quicksand(
            fontWeight: FontWeight.bold, color: Colors.white),
        onConfirmBtnTap: () {
          Get.back();
        },
      );
    }
  }

  @override
  void onInit() {
    super.onInit();
    locationService.locationStream.listen((userLocation) {
      latitude.value = userLocation.latitude!;
      longitude.value = userLocation.longtitude!;
    });
  }
}
