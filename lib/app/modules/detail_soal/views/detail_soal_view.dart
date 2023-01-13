import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../../../data/models/tugas/soal_essay_model.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../data/models/tugas/soal_pg_model.dart';
import '/app/config/app_colors.dart';
import '/app/routes/app_pages.dart';
import '../../../config/app_sisze.dart';
import '../controllers/detail_soal_controller.dart';

class DetailSoalView extends StatelessWidget {
  const DetailSoalView(this.id, this.jenisSoal, this.pelajaran, this.judul,
      this.kelas, this.totalSoal,
      {Key? key})
      : super(key: key);
  final String? id;
  final String? jenisSoal;
  final String? pelajaran;
  final String? judul;
  final String? kelas;
  final String? totalSoal;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final DetailSoalController controller = Get.put(DetailSoalController());
    final GlobalKey<SfPdfViewerState> pdfViewerKey = GlobalKey();
    return Scaffold(
      backgroundColor: AppColors.appBgroudColors,
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0.0),
        child: AppBar(
          backgroundColor: AppColors.appGreenlight,
          elevation: 0,
        ),
      ),
      body: SizedBox(
        width: SizeConfig.screenWidth,
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 200.h,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  width: double.infinity,
                  height: 155.h,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: AppColors.gradientColors),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 15,
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
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Detail Soal",
                                  style: GoogleFonts.quicksand(
                                      color: AppColors.appColorWhite,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: const Icon(
                              Icons.help,
                              color: AppColors.appColorWhite,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: 75.h,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              pelajaran!,
                              style: GoogleFonts.quicksand(
                                  color: AppColors.appColorWhite,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                judul!,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.quicksand(
                                  color: AppColors.appColorWhite,
                                  fontSize: 10.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                if (jenisSoal != "option") {
                                  showModalBottomSheet(
                                    backgroundColor: Colors.transparent,
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (context) {
                                      return PopUpWidget(
                                        id: id!,
                                      );
                                    },
                                  );
                                } else {
                                  CoolAlert.show(
                                      context: context,
                                      type: CoolAlertType.warning,
                                      title: "Peringatan",
                                      text:
                                          "Metode pengiriman jawaban tidak di dukung",
                                      confirmBtnTextStyle:
                                          GoogleFonts.quicksand(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                      onConfirmBtnTap: () async {
                                        Get.back();
                                      });
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                  vertical: 8.h,
                                ),
                                width: 140.w,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 4,
                                      color: Colors.black.withOpacity(0.2),
                                      offset: const Offset(0, 2),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(15.r),
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const CircleAvatar(
                                        radius: 20,
                                        backgroundColor:
                                            AppColors.appGreenlight,
                                        child: CircleAvatar(
                                          radius: 18,
                                          backgroundColor:
                                              AppColors.appColorWhite,
                                          child: Icon(
                                            Icons.add_a_photo_outlined,
                                            color: AppColors.appGreenlight,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text(
                                        "Kirim Jawaban",
                                        style: GoogleFonts.quicksand(
                                            fontSize: 10,
                                            color: const Color(0xff5E5E5E),
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 24.w,
                            ),
                            InkWell(
                              onTap: () {
                                if (jenisSoal == "option") {
                                  Get.toNamed(
                                    Routes.LEMBAR_JAWAB,
                                    arguments: [
                                      id,
                                      pelajaran,
                                      judul,
                                      kelas,
                                      totalSoal
                                    ],
                                  );
                                } else {
                                  CoolAlert.show(
                                      context: context,
                                      type: CoolAlertType.warning,
                                      title: "Peringatan",
                                      text:
                                          "Metode pengiriman jawaban tidak di dukung",
                                      confirmBtnTextStyle:
                                          GoogleFonts.quicksand(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                      onConfirmBtnTap: () async {
                                        Get.back();
                                      });
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                  vertical: 8.h,
                                ),
                                width: 140.w,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 4,
                                      color: Colors.black.withOpacity(0.2),
                                      offset: const Offset(0, 2),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const CircleAvatar(
                                        radius: 20,
                                        backgroundColor:
                                            AppColors.appGreenlight,
                                        child: CircleAvatar(
                                          radius: 18,
                                          backgroundColor:
                                              AppColors.appColorWhite,
                                          child: Icon(
                                            Icons.upload_file_outlined,
                                            color: AppColors.appGreenlight,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text(
                                        "Masukan Jawaban",
                                        style: GoogleFonts.quicksand(
                                            fontSize: 10.sp,
                                            color: const Color(0xff5E5E5E),
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 15.h,
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 15.w),
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
                vertical: 10.h,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xff0AB19A),
                  width: 1.w,
                ),
                color: AppColors.appGreenlight.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.error,
                    size: 25,
                    color: AppColors.appGreenlight,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Tulis jawabanmu dikertas! kemudian pilih metode mengirim jawaban Kirim foto jawaban atau Masukan Jawaban",
                            style: GoogleFonts.quicksand(
                              fontSize: 10.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            if (jenisSoal == "option")
              FutureBuilder<DataSoalPg?>(
                  future: controller.getDataSoalPg(context, id!),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.soal!.ext == "pdf") {
                        return Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 15.w),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 20.h),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20.r),
                                    topRight: Radius.circular(20.r))),
                            child: SfPdfViewer.network(
                              snapshot.data!.soal!.file!,
                              key: pdfViewerKey,
                            ),
                          ),
                        );
                      } else if (snapshot.data!.soal!.ext == "jpg" ||
                          snapshot.data!.soal!.ext == "jpeg") {
                        return Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 15.w),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 20.h),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20.r),
                                    topRight: Radius.circular(20.r))),
                            child: Image.network(
                              snapshot.data!.soal!.file!,
                            ),
                          ),
                        );
                      } else if (snapshot.data!.soal!.ext == "text") {
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 15.w),
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 15.h),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Keterangan Tugas',
                                    style: GoogleFonts.quicksand(
                                      color: AppColors.appGreenlight,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                  vertical: 10.h,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xffF0F0F0),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        snapshot.data!.soal!.text!,
                                        style: GoogleFonts.quicksand(
                                          fontSize: 10.sp,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    }
                    return Center(
                      child: SizedBox(
                        height: 100.h,
                        width: 100.w,
                        child: Lottie.asset(
                          "assets/lotties/loading.json",
                        ),
                      ),
                    );
                  }),
            if (jenisSoal == "essay")
              FutureBuilder<DataSoalEssay?>(
                future: controller.getDataSoalEssay(context, id!),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.soal!.type == "umum") {
                      if (snapshot.data!.soal!.ext == "pdf") {
                        return Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 15.w),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 20.h),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20.r),
                                    topRight: Radius.circular(20.r))),
                            child: SfPdfViewer.network(
                              snapshot.data!.soal!.file!,
                              key: pdfViewerKey,
                            ),
                          ),
                        );
                      } else if (snapshot.data!.soal!.ext == "jpg" ||
                          snapshot.data!.soal!.ext == "jpeg") {
                        return Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 15.w),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 20.h),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20.r),
                                    topRight: Radius.circular(20.r))),
                            child: Image.network(
                              snapshot.data!.soal!.file!,
                            ),
                          ),
                        );
                      }
                    } else {
                      return Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 15.w),
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 15.h),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.r),
                                topRight: Radius.circular(10.r)),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Keterangan Tugas',
                                    style: GoogleFonts.quicksand(
                                      color: AppColors.appGreenlight,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.w,
                                    vertical: 10.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xffF0F0F0),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10.r),
                                        topRight: Radius.circular(10.r)),
                                  ),
                                  child: HtmlWidget(
                                    snapshot.data!.soal!.text!,
                                    textStyle: GoogleFonts.quicksand(
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  }
                  return Center(
                    child: SizedBox(
                      height: 100.h,
                      width: 100.w,
                      child: Lottie.asset(
                        "assets/lotties/loading.json",
                      ),
                    ),
                  );
                },
              )
          ],
        ),
      ),
    );
  }
}

class PopUpWidget extends StatelessWidget {
  const PopUpWidget({
    Key? key,
    required this.id,
  }) : super(key: key);
  final String id;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 4.h,
      padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 15.w),
      width: SizeConfig.screenWidth,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Pilih jawaban",
                style: GoogleFonts.quicksand(
                    fontSize: 14.sp,
                    color: AppColors.appGreenDrak,
                    fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () => Get.back(),
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: const Color(0xffF97276).withOpacity(0.6),
                  child: const Icon(
                    Icons.close,
                    color: Colors.red,
                    size: 15,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10.w,
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 10.w),
            padding: EdgeInsets.symmetric(
              horizontal: 10.w,
              vertical: 10.h,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xff0AB19A),
                width: 1.w,
              ),
              color: AppColors.appGreenlight.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.error,
                  size: 25,
                  color: AppColors.appGreenlight,
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Pilih metode pengirman jawaban sesuai dengan keterangan pada soal ya !",
                          style: GoogleFonts.quicksand(
                            fontSize: 10.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff578EFE),
                      shape: const StadiumBorder(),
                    ),
                    onPressed: () {
                      Get.back();
                      Get.toNamed(Routes.LEMBAR_JAWAB_ESSAY,
                          arguments: ["file", id]);
                    },
                    child: Text(
                      "Kirim dokumen",
                      style: GoogleFonts.quicksand(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20.w,
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.appGreenlight,
                      shape: const StadiumBorder(),
                    ),
                    onPressed: () {
                      Get.toNamed(Routes.LEMBAR_JAWAB_ESSAY,
                          arguments: ["photo", id]);
                    },
                    child: Text(
                      "Kirm foto",
                      style: GoogleFonts.quicksand(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
