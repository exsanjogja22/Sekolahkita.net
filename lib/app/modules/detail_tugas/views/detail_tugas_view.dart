import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../../modules/detail_soal/views/detail_soal_view.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_image.dart';
import '../../../config/app_sisze.dart';
import '../../../data/models/tugas/detail_tugas_model.dart';
import '../../../data/models/tugas/get_tugas_model.dart';
import '../controllers/detail_tugas_controller.dart';

class DetailTugasView extends StatelessWidget {
  const DetailTugasView(this.id, this.pelajaran, this.judul, this.jenisSoal,
      this.totalSoal, this.statusTugas, this.status,
      {Key? key})
      : super(key: key);
  final String? id;
  final String? pelajaran;
  final String? judul;
  final String? jenisSoal;
  final String? totalSoal;
  final String? statusTugas;
  final bool? status;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final DetailTugasController controller = Get.put(DetailTugasController());
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
      bottomNavigationBar: FutureBuilder<DataDetail?>(
          future: controller.getDataDetailTugas(id!),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.jawabanSaya!.status == "lanjutkan" ||
                  snapshot.data!.jawabanSaya!.status == "kerjakan") {
                return Container(
                  color: Colors.white,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                    child: Material(
                      borderRadius: BorderRadius.circular(10.r),
                      color: AppColors.appGreenlight,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10.r),
                        onTap: () => Get.to(
                          DetailSoalView(
                            id,
                            jenisSoal,
                            pelajaran,
                            judul,
                            "${snapshot.data!.kelas} ${snapshot.data!.jurusan}",
                            totalSoal,
                          ),
                        ),
                        child: Container(
                          height: 40.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Center(
                            child: Text(
                              "Kerjakan >>",
                              style: GoogleFonts.quicksand(
                                fontSize: 12.w,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }
              return const SizedBox();
            }
            return const SizedBox();
          }),
      body: SizedBox(
        width: SizeConfig.screenWidth,
        child: SingleChildScrollView(
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
                      gradient:
                          LinearGradient(colors: AppColors.gradientColors),
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
                                    "Detail Tugas",
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
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                height: 70.h,
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
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/icons/Ic_detail_tipe.png",
                                        height: 30,
                                        width: 41,
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      if (jenisSoal == "option")
                                        Text(
                                          "Pilihan Ganda",
                                          style: GoogleFonts.quicksand(
                                              fontSize: 10,
                                              color: const Color(0xff5E5E5E),
                                              fontWeight: FontWeight.w500),
                                        ),
                                      if (jenisSoal == "essay")
                                        Text(
                                          "Essay",
                                          style: GoogleFonts.quicksand(
                                              fontSize: 10,
                                              color: const Color(0xff5E5E5E),
                                              fontWeight: FontWeight.w500),
                                        )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 24.w,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                height: 70.h,
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
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/icons/ic_soal.png",
                                        height: 30,
                                        width: 41,
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      if (totalSoal.toString() != "")
                                        Text(
                                          "$totalSoal Soal",
                                          style: GoogleFonts.quicksand(
                                              fontSize: 10,
                                              color: const Color(0xff5E5E5E),
                                              fontWeight: FontWeight.w500),
                                        ),
                                      if (totalSoal.toString() == "")
                                        Text(
                                          "0 Soal",
                                          style: GoogleFonts.quicksand(
                                              fontSize: 10,
                                              color: const Color(0xff5E5E5E),
                                              fontWeight: FontWeight.w500),
                                        )
                                    ],
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
              FutureBuilder<DataDetail?>(
                future: controller.getDataDetailTugas(id!),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.data!;
                    return Column(
                      children: [
                        SizedBox(
                          height: 15.h,
                        ),
                        if (statusTugas == "aktif")
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
                                          "Hi, Siswa Semangat mengerjakan tugas ya! Jangan lupa untuk mengakhiri tugasmu dengan memilih tombol Simpan & Akhiri. Selamat mengerjakan!",
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
                        if (statusTugas != "aktif")
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.symmetric(horizontal: 15.w),
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 10.h,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.red,
                                width: 1.w,
                              ),
                              color: Colors.red.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.error,
                                  size: 25,
                                  color: Colors.red,
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Hi, Siswa! Periksa info waktu pengerjaan ditugas ini ya. Apakah Kamu belum mengerjakan tugas ini? Tombol kerjakan hanya tampil saat waktu mengerjakan masih tersedia. Hubungi Bpk/Ibu guru terkait untuk mendapatkan tes susulan/remidial! Semangat belajar!",
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
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10.w),
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 15.h),
                          width: double.infinity,
                          height: 70.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 40.h,
                                width: 40.w,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(data.guru!.avatar!),
                                  ),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                              SizedBox(
                                width: 15.w,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            data.guru!.nama!.toTitleCase(),
                                            style: GoogleFonts.quicksand(
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            data.judul!.toTitleCase(),
                                            style: GoogleFonts.quicksand(
                                              fontSize: 10.sp,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        if (status == true || statusTugas == "kadaluarsa")
                          Stack(
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    height: 80.h,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 15.w),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 15.w,
                                      vertical: 15.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                "Progres mengerjakan",
                                                style: GoogleFonts.quicksand(
                                                  color:
                                                      AppColors.appGreenlight,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            if (data.soal!.soalJumlah! != 0)
                                              Text(
                                                "${(data.jawabanSaya!.totalJawab!.toDouble() / data.soal!.soalJumlah!.toDouble() * 100).toInt()} %",
                                                style: GoogleFonts.quicksand(
                                                  color:
                                                      AppColors.appGreenlight,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            if (data.soal!.soalJumlah! == 0)
                                              Text(
                                                "0 %",
                                                style: GoogleFonts.quicksand(
                                                  color:
                                                      AppColors.appGreenlight,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 15.h,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: LinearPercentIndicator(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 0.w),
                                                barRadius:
                                                    const Radius.circular(10),
                                                lineHeight: 8.0,
                                                animation: true,
                                                animationDuration: 500,
                                                percent:
                                                    data.soal!.soalJumlah! != 0
                                                        ? data.jawabanSaya!
                                                                .totalJawab!
                                                                .toDouble() /
                                                            data.soal!
                                                                .soalJumlah!
                                                                .toDouble()
                                                        : 0.0,
                                                progressColor:
                                                    AppColors.appGreenlight,
                                                backgroundColor: AppColors
                                                    .appGreenlight
                                                    .withOpacity(0.4),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 15.h,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              children: [
                                                Text(
                                                  "Terjawab",
                                                  style: GoogleFonts.quicksand(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                Text(
                                                  data.jawabanSaya!.totalJawab
                                                      .toString(),
                                                  style: GoogleFonts.quicksand(
                                                      color: AppColors
                                                          .appGreenlight,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  "Belum Terjawab",
                                                  style: GoogleFonts.quicksand(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                Text(
                                                  "${data.soal!.soalJumlah! - data.jawabanSaya!.totalJawab!}",
                                                  style: GoogleFonts.quicksand(
                                                      color: Colors.red,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  "Total Soal",
                                                  style: GoogleFonts.quicksand(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                Text(
                                                  data.soal!.soalJumlah
                                                      .toString(),
                                                  style: GoogleFonts.quicksand(
                                                      color: Colors.blue,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 22.h,
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.w, vertical: 10.h),
                                          height: 50.h,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Colors.blue.withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                          ),
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.timer_outlined,
                                                size: 20,
                                                color: Colors.black87,
                                              ),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              if (data.waktu!.tipe ==
                                                  "waktu_jadwal")
                                                Text(
                                                  DateFormat("d MMMM yyyy",
                                                          "id_ID")
                                                      .format(DateTime.parse(
                                                          data.waktu!.dataWaktu!
                                                              .tanggal
                                                              .toString())),
                                                  style: GoogleFonts.quicksand(
                                                    fontSize: 12.sp,
                                                  ),
                                                ),
                                              if (data.waktu!.tipe ==
                                                  "waktu_range")
                                                Text(
                                                  "${DateFormat("d MMMM yyyy", "id_ID").format(DateTime.parse(RangeTanggal.fromJson(data.waktu!.dataWaktu!.tanggal).mulai!))} s.d. ${DateFormat("d MMMM yyyy", "id_ID").format(DateTime.parse(RangeTanggal.fromJson(data.waktu!.dataWaktu!.tanggal).selesai!))}",
                                                  style: GoogleFonts.quicksand(
                                                    fontSize: 12.sp,
                                                  ),
                                                ),
                                              if (data.waktu!.tipe ==
                                                  "waktu_bebas")
                                                Text(
                                                  "Tidak ada batasan waktu",
                                                  style: GoogleFonts.quicksand(
                                                    fontSize: 12.sp,
                                                  ),
                                                ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 100.h,
                                    width: 120.w,
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                          begin: Alignment.bottomLeft,
                                          end: Alignment.topRight,
                                          stops: [
                                            0.0,
                                            0.75,
                                            1.0
                                          ],
                                          colors: [
                                            Color(0xffF6C400),
                                            Color(0xffFFD842),
                                            Color(0xffFFF4C9),
                                          ]),
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 85.w,
                                          decoration: BoxDecoration(
                                              color: const Color(0xffF97276),
                                              borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(10.r),
                                                  bottomRight:
                                                      Radius.circular(10.r))),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                AppImage.iconsJadwal3,
                                                width: 30.w,
                                              ),
                                              SizedBox(
                                                width: 5.w,
                                              ),
                                              Text(
                                                "Nilai",
                                                style: GoogleFonts.quicksand(
                                                    color: Colors.white,
                                                    fontSize: 12.sp,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        ),
                                        if (data.showNilai == true)
                                          Expanded(
                                              child: Center(
                                            child: Text(
                                              data.resumGuru!.nilai.toString(),
                                              style: GoogleFonts.quicksand(
                                                  fontSize: 40.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          )),
                                        if (data.showNilai == false)
                                          Expanded(
                                              child: Center(
                                            child: Text(
                                              "-",
                                              style: GoogleFonts.quicksand(
                                                  fontSize: 40.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ))
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20.w,
                                  ),
                                  Container(
                                    height: 100.h,
                                    width: 170.w,
                                    decoration: BoxDecoration(
                                        color: const Color(0xff6C99F6),
                                        borderRadius:
                                            BorderRadius.circular(10.r)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 122.w,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5.w, vertical: 5.h),
                                          decoration: BoxDecoration(
                                              color: const Color(0xffF97276),
                                              borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(10.r),
                                                  bottomRight:
                                                      Radius.circular(10.r))),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.help_outline_sharp,
                                                color: Colors.white,
                                                size: 20.w,
                                              ),
                                              SizedBox(
                                                width: 5.w,
                                              ),
                                              Text(
                                                "Catatan Guru",
                                                style: GoogleFonts.quicksand(
                                                    color: Colors.white,
                                                    fontSize: 12.sp,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        ),
                                        if (data.resumGuru!.catatan != "")
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 8.0.w,
                                                vertical: 8.0.h,
                                              ),
                                              child: HtmlWidget(
                                                data.resumGuru!.catatan!,
                                                textStyle:
                                                    GoogleFonts.quicksand(
                                                  fontSize: 12.sp,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        if (data.resumGuru!.catatan == "")
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 8.0.w,
                                                vertical: 8.0.h,
                                              ),
                                              child: Text(
                                                "Tidak ada catatan!",
                                                style: GoogleFonts.quicksand(
                                                  fontSize: 12.sp,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          )
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        if (status == false && statusTugas != "kadaluarsa")
                          Container(
                            height: 200.h,
                            width: double.infinity,
                            margin: EdgeInsets.symmetric(horizontal: 15.w),
                            padding: EdgeInsets.symmetric(
                              horizontal: 15.w,
                              vertical: 15.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Progres mengerjakan",
                                        style: GoogleFonts.quicksand(
                                          color: AppColors.appGreenlight,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    if (data.soal!.soalJumlah! != 0)
                                      Text(
                                        "${(data.jawabanSaya!.totalJawab!.toDouble() / data.soal!.soalJumlah!.toDouble() * 100).toInt()} %",
                                        style: GoogleFonts.quicksand(
                                          color: AppColors.appGreenlight,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    if (data.soal!.soalJumlah! == 0)
                                      Text(
                                        "0 %",
                                        style: GoogleFonts.quicksand(
                                          color: AppColors.appGreenlight,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                  ],
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: LinearPercentIndicator(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 0.w),
                                        barRadius: const Radius.circular(10),
                                        lineHeight: 8.0,
                                        animation: true,
                                        animationDuration: 500,
                                        percent: data.soal!.soalJumlah! != 0
                                            ? data.jawabanSaya!.totalJawab!
                                                    .toDouble() /
                                                data.soal!.soalJumlah!
                                                    .toDouble()
                                            : 0.0,
                                        progressColor: AppColors.appGreenlight,
                                        backgroundColor: AppColors.appGreenlight
                                            .withOpacity(0.4),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          "Terjawab",
                                          style: GoogleFonts.quicksand(
                                            color: Colors.black,
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          data.jawabanSaya!.totalJawab
                                              .toString(),
                                          style: GoogleFonts.quicksand(
                                              color: AppColors.appGreenlight,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "Belum Terjawab",
                                          style: GoogleFonts.quicksand(
                                            color: Colors.black,
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          "${data.soal!.soalJumlah! - data.jawabanSaya!.totalJawab!}",
                                          style: GoogleFonts.quicksand(
                                              color: Colors.red,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "Total Soal",
                                          style: GoogleFonts.quicksand(
                                            color: Colors.black,
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          data.soal!.soalJumlah.toString(),
                                          style: GoogleFonts.quicksand(
                                              color: Colors.blue,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 22.h,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.w, vertical: 10.h),
                                  height: 50.h,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.blue.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.timer_outlined,
                                        size: 20,
                                        color: Colors.black87,
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      if (data.waktu!.tipe == "waktu_jadwal")
                                        Text(
                                          DateFormat("d MMMM yyyy", "id_ID")
                                              .format(DateTime.parse(data
                                                  .waktu!.dataWaktu!.tanggal
                                                  .toString())),
                                          style: GoogleFonts.quicksand(
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                      if (data.waktu!.tipe == "waktu_range")
                                        Text(
                                          "${DateFormat("d MMMM yyyy", "id_ID").format(DateTime.parse(RangeTanggal.fromJson(data.waktu!.dataWaktu!.tanggal).mulai!))} s.d. ${DateFormat("d MMMM yyyy", "id_ID").format(DateTime.parse(RangeTanggal.fromJson(data.waktu!.dataWaktu!.tanggal).selesai!))}",
                                          style: GoogleFonts.quicksand(
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                      if (data.waktu!.tipe == "waktu_bebas")
                                        Text(
                                          "Tidak ada batasan waktu",
                                          style: GoogleFonts.quicksand(
                                            fontSize: 12.sp,
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
                                        data.keterangan!,
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
                        ),
                        SizedBox(
                          height: 10.h,
                        )
                      ],
                    );
                  }
                  if (kDebugMode) {
                    print(snapshot.error);
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}
