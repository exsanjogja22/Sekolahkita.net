import 'dart:async';
import 'dart:convert';

import 'dart:io';
import 'dart:isolate';
import 'dart:math';
import 'dart:ui';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../../data/models/materi/materi_detail_model.dart';
import '../../../data/providers/network/api_repository.dart';
import '../../../data/providers/network/repository/materi_repositori.dart';
import '../data/models/post_kuisioner_model.dart';

class DetailMateriController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxInt currIndexYoutube = 0.obs;
  RxBool currYoutube = false.obs;
  RxInt currIndexDocument = 0.obs;
  RxBool currDocument = false.obs;
  RxInt currIndexGoogleDrive = 0.obs;
  RxBool currGoogleDrive = false.obs;
  RxInt currIndexImage = 0.obs;
  RxBool currImage = false.obs;
  RxInt currIndexLainya = 0.obs;
  RxBool currLainya = false.obs;
  RxDouble top = 0.0.obs;
  RxInt time = 0.obs;
  RxBool statusTime = false.obs;

  RxBool isKuisioner = false.obs;
  RxBool isLauncePopUp = false.obs;

  RxBool isLoadingDownload = false.obs;
  RxInt isLoadingProgres = 0.obs;
  List<FileMateri> listMateri = [];
  List<FileMateri> listSearchMateri = [];
  List<PostKuisioner> listKuisioner = [];

  final MateriRepositori _materiRepositori = MateriRepositori();
  static const colldownTime = Duration(minutes: 10);
  Duration duration = const Duration();
  Timer? timer;

  Future<DataMateriDetail?> getDataMateri(String id) async {
    final dataResponse = await _materiRepositori.getMateriDetail(id);
    await getDataMateriSearch(id);
    if (dataResponse != null) {
      if (dataResponse.statusResponse == StatusResponse.success) {
        final data =
            MateriDetail.fromJson(jsonDecode(dataResponse.response!)).data!;
        if (data.kuisioner!.row!.isNotEmpty &&
            data.kuisioner!.statusIsian! == false) {
          isLauncePopUp.value = true;
        } else {
          isLauncePopUp.value = false;
        }
        isKuisioner.value = data.kuisioner!.wajibIsi!;
        for (var i in data.kuisioner!.row!) {
          listKuisioner.addAll({
            PostKuisioner(
              id: i.mcId,
              judul: i.mcJudul!,
              opsi: [
                "belum_paham",
                "kurang_paham",
                "cukup_paham",
                "sangat_paham",
              ],
            )
          });
        }
        data.kuisioner!.row!.asMap().forEach((index, value) {
          for (var e in value.opsiJawaban!) {
            if (e.status == "selected") {
              listKuisioner[index].key = e.opsi;
            }
          }
        });

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

  Future<void> getDataMateriSearch(String id) async {
    final dataResponse = await _materiRepositori.getMateriDetail(id);
    if (dataResponse != null) {
      if (dataResponse.statusResponse == StatusResponse.success) {
        final data = MateriDetail.fromJson(jsonDecode(dataResponse.response!))
            .data!
            .file;
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

  Future<void> launchURL(String url) async {
    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  Future<void> downloadFile(
      BuildContext context, String url, String fileName) async {
    try {
      Directory? savedDir;
      if (Platform.isIOS) {
        savedDir = await getApplicationDocumentsDirectory();
      } else {
        savedDir = Directory('/storage/emulated/0/Download');
        if (!await savedDir.exists()) {
          savedDir = await getExternalStorageDirectory();
        }
      }
      var rng = Random();
      await FlutterDownloader.enqueue(
        url: url,
        savedDir: savedDir!.path,
        headers: {"auth": "Downloader"},
        fileName: "download(${rng.nextInt(100)}).$fileName",
        showNotification: true,
        openFileFromNotification: true,
      ).then((value) async {
        bool waitTask = true;
        isLoadingDownload.value = true;
        while (waitTask) {
          String query = "SELECT * FROM task WHERE task_id='${value!}'";
          var tasks =
              await FlutterDownloader.loadTasksWithRawQuery(query: query);
          String taskStatus = tasks![0].status.toString();
          int taskProgress = tasks[0].progress;
          isLoadingProgres.value = taskProgress;
          if (taskStatus == "DownloadTaskStatus(3)" && taskProgress == 100) {
            waitTask = false;
          }
          await Future.delayed(const Duration(milliseconds: 100));
        }
        isLoadingDownload.value = false;
        CoolAlert.show(
            context: context,
            type: CoolAlertType.success,
            confirmBtnText: "Buka",
            title: "Sukses",
            text: "File berhasil di download!",
            showCancelBtn: true,
            onConfirmBtnTap: () async {
              Get.back();
              await FlutterDownloader.open(taskId: value!);
            },
            onCancelBtnTap: () {
              Get.back();
              Get.back();
            });
      });
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<void> postDataKuisioner(BuildContext context) async {
    Map<String, String?> body = {};
    for (var i in listKuisioner) {
      body.addAll({
        'jawab[${i.id}]': '${i.key}',
      });
    }
    final dataResponse = await _materiRepositori.postKuisioner(body);
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
                Get.back(result: true);
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
      Get.snackbar("Gagal", "Koneksi Internet tidak terhubung",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.red,
          backgroundColor: Colors.red.withOpacity(0.4));
    }
  }

  Future<void> postDataDurasi(String id) async {
    Map<String, String?> body = {
      'id_materi': id,
      'durasi_baca': time.value.toString()
    };
    print("Durasi Baca : ${time.value} s");
    final dataResponse = await _materiRepositori.postMateriKunjungan(body);
    if (dataResponse != null) {
      if (dataResponse.statusResponse == StatusResponse.success) {
        var it = jsonDecode(dataResponse.response!);
        if (it['status'] == true) {
          time.value = 0;
          timer!.cancel();
          print("Berhasil Mengirim Durasi");
        } else {
          print("------Gagal------");
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

  ReceivePort port = ReceivePort();

  Future<void> startTimer() async {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      const addSeconds = 1;
      time.value = duration.inSeconds + addSeconds;
      duration = Duration(seconds: time.value);
    });
  }

  @override
  void onInit() {
    super.onInit();
    startTimer();
    IsolateNameServer.registerPortWithName(
        port.sendPort, 'downloader_send_port');
    port.listen(
      (dynamic data) {
        DownloadTaskStatus status = data[1];
        if (status == DownloadTaskStatus.failed) {
          Get.snackbar(
            "Gagal",
            "Download gagal",
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.red,
            backgroundColor: Colors.red.withOpacity(0.4),
          );
        }
      },
    );
    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    timer!.cancel();
    super.dispose();
  }

  @pragma('vm:entry-point')
  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send?.send([id, status, progress]);
  }
}
