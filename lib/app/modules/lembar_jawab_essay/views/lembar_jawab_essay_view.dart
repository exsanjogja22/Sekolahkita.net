import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_image.dart';
import '../../../routes/app_pages.dart';
import '../controllers/lembar_jawab_essay_controller.dart';

class LembarJawabEssayView extends GetView<LembarJawabEssayController> {
  const LembarJawabEssayView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final GlobalKey<SfPdfViewerState> pdfViewerKey = GlobalKey();
    final status = Get.arguments[0];
    final id = Get.arguments[1];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.appBgroudColors,
      appBar: AppBar(
        backgroundColor: AppColors.appGreenlight,
        title: Text(
          'Kirim Dokumen',
          style: GoogleFonts.quicksand(color: Colors.white, fontSize: 14.sp),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(13),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.arrow_back_rounded,
                size: 15.w,
                color: AppColors.appGreenlight,
              ),
            ),
          ),
        ),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Obx(
          () => Column(
            children: [
              if (status == "photo")
                Expanded(
                  flex: 6,
                  child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 15.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 7,
                            child: InkWell(
                              onTap: () async {
                                var result = await Get.toNamed(
                                    Routes.KAMERA_HELPER,
                                    arguments: [0]);
                                controller.pathFile.value = result.toString();
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                  top: 10.h,
                                  left: 20.w,
                                  right: 20.w,
                                  bottom: 20.h,
                                ),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                ),
                                child: DottedBorder(
                                  color: Colors.grey,
                                  dashPattern: const [8, 4],
                                  strokeWidth: 2,
                                  borderType: BorderType.RRect,
                                  child: Stack(
                                    children: [
                                      if (controller.pathFile.value != "null")
                                        Center(
                                          child: Image.file(
                                            File(controller.pathFile.value),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      if (controller.pathFile.value == "null")
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 20.h),
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  AppImage.iconCameraPresensi,
                                                  height: 50.h,
                                                  color: Colors.white,
                                                ),
                                                Text(
                                                  "Ambil Foto",
                                                  style: GoogleFonts.quicksand(
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
              if (status == "file")
                Expanded(
                  flex: 6,
                  child: Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: controller.extensionName.value == ""
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Upload File !",
                                style: GoogleFonts.quicksand(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              Text(
                                "Type file yang diizinkan: (doc, docx, xls, xlsx, ppt, pptx, jpg, jpeg, png, pdf) Ukuran maksimal : 3 MB ",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.quicksand(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              if (controller.extensionName.value == "pdf")
                                Expanded(
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 15.w),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20.w, vertical: 20.h),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20.r),
                                            topRight: Radius.circular(20.r))),
                                    child: SfPdfViewer.file(
                                      File(controller.pathFile.value),
                                      key: pdfViewerKey,
                                    ),
                                  ),
                                ),
                              if (controller.extensionName.value == "png" ||
                                  controller.extensionName.value == "jpg" ||
                                  controller.extensionName.value == "jpeg")
                                Expanded(
                                    child: Image.file(
                                        File(controller.pathFile.value))),
                              if (controller.extensionName.value == "doc" ||
                                  controller.extensionName.value == "docx" ||
                                  controller.extensionName.value == "xls" ||
                                  controller.extensionName.value == "ppt" ||
                                  controller.extensionName.value == " pptx" ||
                                  controller.extensionName.value == "xlsx")
                                Expanded(
                                    child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        controller.basename.value,
                                        style: GoogleFonts.quicksand(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                      Text(
                                        "File tidak di dukung prevew",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.quicksand(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ))
                            ],
                          ),
                  ),
                ),
              Expanded(
                flex: 2,
                child: Container(
                  margin: EdgeInsets.only(
                      top: 0.h, left: 15.w, right: 15.w, bottom: 15.h),
                  padding: const EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: Colors.grey[200]),
                  child: TextField(
                    controller: controller.desc,
                    decoration: InputDecoration(
                      disabledBorder: InputBorder.none,
                      border: InputBorder.none,
                      hintText: "Tulis jawaban singkat disini....",
                      hintStyle: GoogleFonts.quicksand(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.only(
                      top: 0.h, left: 15.w, right: 15.w, bottom: 15.h),
                  padding: EdgeInsets.all(10.w),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: Colors.grey[200]),
                  child: TextField(
                    controller: controller.linkEx,
                    decoration: InputDecoration(
                      disabledBorder: InputBorder.none,
                      border: InputBorder.none,
                      hintText: "Masukan link External pendukung (Optional)",
                      hintStyle: GoogleFonts.quicksand(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ),
                ),
              ),
              if (status == "file")
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Material(
                      color: const Color(0xffFBD02B),
                      borderRadius: BorderRadius.circular(10.r),
                      child: InkWell(
                        onTap: () {
                          controller.selectFile();
                        },
                        borderRadius: BorderRadius.circular(10.r),
                        child: Container(
                          height: 50.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.document_scanner_rounded,
                                size: 20.w,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                "Pilih File",
                                style: GoogleFonts.quicksand(
                                  fontSize: 12.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Material(
                          color: const Color(0xff6C99F6),
                          borderRadius: BorderRadius.circular(10.r),
                          child: InkWell(
                            onTap: () {
                              controller.kirimfileJawaban(context, id, false);
                            },
                            borderRadius: BorderRadius.circular(10.r),
                            child: Container(
                              height: 50.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Center(
                                child: Text(
                                  "Simpan Sementara",
                                  style: GoogleFonts.quicksand(
                                    fontSize: 12.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
                        child: Material(
                          color: AppColors.appGreenlight,
                          borderRadius: BorderRadius.circular(10.r),
                          child: InkWell(
                            onTap: () {
                              controller.kirimfileJawaban(context, id, true);
                            },
                            borderRadius: BorderRadius.circular(10.r),
                            child: Container(
                              height: 50.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  "Simpan & Akhiri",
                                  style: GoogleFonts.quicksand(
                                    fontSize: 12.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
