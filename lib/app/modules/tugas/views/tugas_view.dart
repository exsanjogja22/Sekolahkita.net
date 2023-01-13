import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:smkn1contoh/app/config/app_image.dart';
import 'package:smkn1contoh/app/modules/detail_tugas/views/detail_tugas_view.dart';
import 'package:smkn1contoh/app/routes/app_pages.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_sisze.dart';
import '../../../data/models/tugas/get_tugas_model.dart';
import '../../../data/models/tugas/statistik_tugas_model.dart';
import '../controllers/tugas_controller.dart';

class TugasView extends GetView<TugasController> {
  const TugasView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
        height: MediaQuery.of(context).size.height,
        width: SizeConfig.screenWidth,
        child: SingleChildScrollView(
          child: Obx(
            () => Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: 200.h,
                    ),
                    Container(
                      width: double.infinity,
                      height: 150.h,
                      decoration: const BoxDecoration(
                        gradient:
                            LinearGradient(colors: AppColors.gradientColors),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                              right: 0,
                              child: Image.asset(
                                "assets/images/5145491.png",
                                width: MediaQuery.of(context).size.width,
                                height: 175.h,
                              )),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Tugas Siswa",
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
                                      child: Icon(
                                        Icons.help,
                                        color: AppColors.appColorWhite,
                                        size: 20.w,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 90.h,
                      left: 0.w,
                      right: 0.w,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 26.w),
                        width: double.infinity,
                        height: 110.h,
                        child: FutureBuilder<DataStatistikTugas?>(
                            future: controller.initGetDataStatistik,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Stack(
                                      children: [
                                        SizedBox(
                                          height: 130.h,
                                        ),
                                        Column(
                                          children: [
                                            SizedBox(
                                              height: 20.h,
                                            ),
                                            Container(
                                              height: 90.h,
                                              width: 90.w,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                    blurRadius: 4,
                                                    color: Colors.grey
                                                        .withOpacity(0.7),
                                                    offset: const Offset(3, 2),
                                                  )
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(15.r),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    snapshot.data!.statistik!
                                                        .semuaTugas
                                                        .toString(),
                                                    style: GoogleFonts
                                                        .quicksand(
                                                            color: AppColors
                                                                .appGreenlight,
                                                            fontSize: 20.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  ),
                                                  Text(
                                                    "Tugas",
                                                    style:
                                                        GoogleFonts.quicksand(
                                                            color: Colors.grey,
                                                            fontSize: 10.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Positioned(
                                          left: 25.w,
                                          right: 25.w,
                                          child: Container(
                                            height: 40.h,
                                            width: 40.w,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 2,
                                                  color: Colors.grey
                                                      .withOpacity(0.7),
                                                  offset: const Offset(1, 2),
                                                )
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(15.r),
                                            ),
                                            child: Image.asset(
                                              AppImage.iconsTugas2,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Stack(
                                      children: [
                                        SizedBox(
                                          height: 130.h,
                                        ),
                                        Column(
                                          children: [
                                            SizedBox(
                                              height: 20.h,
                                            ),
                                            Container(
                                              height: 90.h,
                                              width: 90.w,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                    blurRadius: 4,
                                                    color: Colors.grey
                                                        .withOpacity(0.7),
                                                    offset: const Offset(3, 2),
                                                  )
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(15.r),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "${(snapshot.data!.statistik!.semuaTugas! - snapshot.data!.statistik!.belumDikerjakan!).toInt()}",
                                                    style:
                                                        GoogleFonts.quicksand(
                                                      color: const Color(
                                                          0xffFCC800),
                                                      fontSize: 22.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Sudah\nDikerjakan",
                                                    textAlign: TextAlign.center,
                                                    style:
                                                        GoogleFonts.quicksand(
                                                            color: Colors.grey,
                                                            fontSize: 10.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Positioned(
                                          left: 25.w,
                                          right: 25.w,
                                          child: Container(
                                            height: 40.h,
                                            width: 40.w,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 2,
                                                  color: Colors.grey
                                                      .withOpacity(0.7),
                                                  offset: const Offset(1, 2),
                                                )
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(15.r),
                                            ),
                                            child: Image.asset(
                                                AppImage.iconsTugas3),
                                          ),
                                        )
                                      ],
                                    ),
                                    Stack(
                                      children: [
                                        SizedBox(
                                          height: 130.h,
                                        ),
                                        Column(
                                          children: [
                                            SizedBox(
                                              height: 20.h,
                                            ),
                                            Container(
                                              height: 90.h,
                                              width: 90.w,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                    blurRadius: 4,
                                                    color: Colors.grey
                                                        .withOpacity(0.7),
                                                    offset: const Offset(3, 2),
                                                  )
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(15.r),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    snapshot.data!.statistik!
                                                        .belumDikerjakan
                                                        .toString(),
                                                    style:
                                                        GoogleFonts.quicksand(
                                                            color:
                                                                const Color(
                                                                    0xffEF5354),
                                                            fontSize: 22.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  ),
                                                  Text(
                                                    "Belum\nDikerjakan",
                                                    textAlign: TextAlign.center,
                                                    style:
                                                        GoogleFonts.quicksand(
                                                            color: Colors.grey,
                                                            fontSize: 10.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Positioned(
                                          left: 25.w,
                                          right: 25.w,
                                          child: Container(
                                            height: 40.h,
                                            width: 40.w,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 2,
                                                  color: Colors.grey
                                                      .withOpacity(0.7),
                                                  offset: const Offset(1, 2),
                                                )
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(15.r),
                                            ),
                                            child: Image.asset(
                                                AppImage.iconsTugas1),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                );
                              }
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Stack(
                                    children: [
                                      SizedBox(
                                        height: 130.h,
                                      ),
                                      Column(
                                        children: [
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          Container(
                                            height: 90.h,
                                            width: 90.w,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 4,
                                                  color: Colors.grey
                                                      .withOpacity(0.7),
                                                  offset: const Offset(3, 2),
                                                )
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(15.r),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "0",
                                                  style: GoogleFonts.quicksand(
                                                      color: AppColors
                                                          .appGreenlight,
                                                      fontSize: 20.sp,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  "Tugas",
                                                  style: GoogleFonts.quicksand(
                                                      color: Colors.grey,
                                                      fontSize: 10.sp,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Positioned(
                                        left: 25.w,
                                        right: 25.w,
                                        child: Container(
                                          height: 40.h,
                                          width: 40.w,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 2,
                                                color: Colors.grey
                                                    .withOpacity(0.7),
                                                offset: const Offset(1, 2),
                                              )
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(15.r),
                                          ),
                                          child:
                                              Image.asset(AppImage.iconsTugas2),
                                        ),
                                      )
                                    ],
                                  ),
                                  Stack(
                                    children: [
                                      SizedBox(
                                        height: 130.h,
                                      ),
                                      Column(
                                        children: [
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          Container(
                                            height: 90.h,
                                            width: 90.w,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 4,
                                                  color: Colors.grey
                                                      .withOpacity(0.7),
                                                  offset: const Offset(3, 2),
                                                )
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(15.r),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "0",
                                                  style: GoogleFonts.quicksand(
                                                      color: const Color(
                                                          0xffFCC800),
                                                      fontSize: 22.sp,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  "Selesa\nDikerjakan",
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.quicksand(
                                                      color: Colors.grey,
                                                      fontSize: 10.sp,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Positioned(
                                        left: 25.w,
                                        right: 25.w,
                                        child: Container(
                                          height: 40.h,
                                          width: 40.w,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 2,
                                                color: Colors.grey
                                                    .withOpacity(0.7),
                                                offset: const Offset(1, 2),
                                              )
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(15.r),
                                          ),
                                          child:
                                              Image.asset(AppImage.iconsTugas3),
                                        ),
                                      )
                                    ],
                                  ),
                                  Stack(
                                    children: [
                                      SizedBox(
                                        height: 130.h,
                                      ),
                                      Column(
                                        children: [
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          Container(
                                            height: 90.h,
                                            width: 90.w,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 4,
                                                  color: Colors.grey
                                                      .withOpacity(0.7),
                                                  offset: const Offset(3, 2),
                                                )
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(15.r),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "0",
                                                  style: GoogleFonts.quicksand(
                                                      color: const Color(
                                                          0xffEF5354),
                                                      fontSize: 22.sp,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  "Belum\nDikerjakan",
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.quicksand(
                                                      color: Colors.grey,
                                                      fontSize: 10.sp,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Positioned(
                                        left: 25.w,
                                        right: 25.w,
                                        child: Container(
                                          height: 40.h,
                                          width: 40.w,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 2,
                                                color: Colors.grey
                                                    .withOpacity(0.7),
                                                offset: const Offset(1, 2),
                                              )
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(15.r),
                                          ),
                                          child:
                                              Image.asset(AppImage.iconsTugas1),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              );
                            }),
                      ),
                    )
                  ],
                ),
                FutureBuilder<List<Tugas>?>(
                    future: controller.initTugasAktif,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: [
                            SizedBox(
                              height: 15.h,
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 15.w),
                              height: 25.h,
                              width: double.infinity.w,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Tugas Aktif",
                                    style: GoogleFonts.quicksand(
                                      color: const Color(0xff155A5F),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () =>
                                        Get.toNamed(Routes.TUGAS_AKTIF),
                                    child: SizedBox(
                                      height: 25.h,
                                      child: Center(
                                        child: Row(
                                          children: [
                                            Text(
                                              "Lihat Semua ",
                                              style: GoogleFonts.quicksand(
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.appGreenlight,
                                                fontSize: 10.sp,
                                              ),
                                            ),
                                            Image.asset(
                                              AppImage.lihatSemua,
                                              color: AppColors.appGreenlight,
                                              height: 6.h,
                                              width: 6.w,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            SizedBox(
                              height: 190.h,
                              width: double.infinity,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  final data = snapshot.data![index];
                                  return Container(
                                    margin: EdgeInsets.only(left: 10.w),
                                    width: 250.w,
                                    decoration: BoxDecoration(
                                      color: AppColors.appColorWhite,
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                horizontal: 10.w,
                                                vertical: 10.h,
                                              ),
                                              height: 50.h,
                                              width: 50.w,
                                              decoration: BoxDecoration(
                                                image: const DecorationImage(
                                                  image: AssetImage(
                                                      AppImage.profile),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5.r),
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          data.namaPelajaran!
                                                              .toTitleCase(),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: GoogleFonts
                                                              .quicksand(
                                                            color: AppColors
                                                                .appColorBlack
                                                                .withOpacity(
                                                                    0.7),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 12.sp,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          data.namaGuru!
                                                              .toTitleCase(),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: GoogleFonts
                                                              .quicksand(
                                                            color: Colors.grey,
                                                            fontSize: 10.sp,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 5.h,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 5.w,
                                                                vertical: 2.h),
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.2)),
                                                          color: Colors.white
                                                              .withOpacity(0.2),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.r),
                                                        ),
                                                        child: Center(
                                                          child: data.soal!
                                                                      .jenisSoal ==
                                                                  "option"
                                                              ? Text(
                                                                  "pilihan ganda",
                                                                  style: GoogleFonts
                                                                      .quicksand(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        10.sp,
                                                                  ),
                                                                )
                                                              : Text(
                                                                  "essay",
                                                                  style: GoogleFonts
                                                                      .quicksand(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        10.sp,
                                                                  ),
                                                                ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 5.w,
                                                      ),
                                                      if (data.soal!
                                                              .jenisSoal ==
                                                          "option")
                                                        Text(
                                                          "${data.soal!.totalSoal} Soal",
                                                          style: GoogleFonts
                                                              .quicksand(
                                                                  fontSize:
                                                                      10.sp,
                                                                  color: AppColors
                                                                      .appColorBlack),
                                                        )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          height: 40.h,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.w),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  data.judul!.toTitleCase(),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.quicksand(
                                                      color: AppColors
                                                          .appColorBlack,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 10.sp),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        if (data.waktu!.tipe == "waktu_jadwal")
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.w),
                                            child: Row(
                                              children: [
                                                Text(
                                                  DateFormat("d MMMM yyyy",
                                                          "id_ID")
                                                      .format(DateTime.parse(
                                                          data.waktu!.dataWaktu!
                                                              .tanggal
                                                              .toString())),
                                                  style: GoogleFonts.quicksand(
                                                      color: AppColors
                                                          .appColorBlack,
                                                      fontSize: 10.sp),
                                                )
                                              ],
                                            ),
                                          ),
                                        if (data.waktu!.tipe == "waktu_range")
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.w),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "${DateFormat("d MMMM yyyy", "id_ID").format(DateTime.parse(RangeTanggal.fromJson(data.waktu!.dataWaktu!.tanggal).mulai!))} s.d. ${DateFormat("d MMMM yyyy", "id_ID").format(DateTime.parse(RangeTanggal.fromJson(data.waktu!.dataWaktu!.tanggal).selesai!))}",
                                                  style: GoogleFonts.quicksand(
                                                      color: AppColors
                                                          .appColorBlack,
                                                      fontSize: 10.sp),
                                                )
                                              ],
                                            ),
                                          ),
                                        if (data.waktu!.tipe == "waktu_bebas")
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.w),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Tidak ada batasan waktu\n  ",
                                                  style: GoogleFonts.quicksand(
                                                      color: AppColors
                                                          .appColorBlack,
                                                      fontSize: 10.sp),
                                                )
                                              ],
                                            ),
                                          ),
                                        if (data.waktu!.tipe != "waktu_bebas")
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.w),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "${data.waktu!.dataWaktu!.jam!.mulai} WIB s.d. ${data.waktu!.dataWaktu!.jam!.mulai} WIB",
                                                  style: GoogleFonts.quicksand(
                                                      color: AppColors
                                                          .appColorBlack,
                                                      fontSize: 10.sp),
                                                )
                                              ],
                                            ),
                                          ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.w, vertical: 10.h),
                                          child: Row(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10.w,
                                                    vertical: 5.h),
                                                child: Row(
                                                  children: [
                                                    if (data.statusTugas !=
                                                        "aktif")
                                                      Image.asset(
                                                        "assets/icons/presensi_icons/ic_tidak_hadir.png",
                                                        height: 12.h,
                                                        width: 12.w,
                                                      ),
                                                    if (data.statusTugas ==
                                                        "aktif")
                                                      Icon(
                                                        Icons
                                                            .notifications_active_outlined,
                                                        size: 15.w,
                                                        color: AppColors
                                                            .appGreenlight,
                                                      ),
                                                    SizedBox(
                                                      width: 5.w,
                                                    ),
                                                    if (data.statusTugas ==
                                                        "aktif")
                                                      Text(
                                                        "Tugas Aktif             ",
                                                        style: GoogleFonts
                                                            .quicksand(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: AppColors
                                                                    .appGreenlight,
                                                                fontSize:
                                                                    10.sp),
                                                      ),
                                                    if (data.statusTugas !=
                                                        "aktif")
                                                      Text(
                                                        "Tugas Kedaluwarsa",
                                                        style: GoogleFonts
                                                            .quicksand(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: const Color(
                                                                    0xffEF5354),
                                                                fontSize:
                                                                    10.sp),
                                                      ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10.h,
                                              ),
                                              Expanded(
                                                child: Material(
                                                  color: AppColors.appGreenlight
                                                      .withOpacity(0.6),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.r),
                                                  child: InkWell(
                                                    onTap: () => Get.to(
                                                      DetailTugasView(
                                                          data.idTugas,
                                                          data.namaPelajaran,
                                                          data.judul!
                                                              .toTitleCase(),
                                                          data.soal!.jenisSoal,
                                                          data.soal!.totalSoal,
                                                          data.statusTugas,
                                                          false),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.r),
                                                    child: Container(
                                                      height: 30.h,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 5.h,
                                                              horizontal: 10.w),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.r),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          "Pilih",
                                                          style: GoogleFonts
                                                              .quicksand(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      10.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                        ),
                                                      ),
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
                                },
                              ),
                            ),
                          ],
                        );
                      }
                      return const SizedBox();
                    }),
                FutureBuilder<List<Tugas>?>(
                  future: controller.initTugasSelesai,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          SizedBox(
                            height: 15.h,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10.w),
                            height: 25.h,
                            width: double.infinity.w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Tugas Selesai",
                                  style: GoogleFonts.quicksand(
                                    color: const Color(0xff155A5F),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.sp,
                                  ),
                                ),
                                InkWell(
                                  onTap: () =>
                                      Get.toNamed(Routes.TUGAS_SELESAI),
                                  child: SizedBox(
                                    height: 25.h,
                                    child: Center(
                                      child: Row(
                                        children: [
                                          Text(
                                            "Lihat Semua ",
                                            style: GoogleFonts.quicksand(
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.appGreenlight,
                                              fontSize: 10.sp,
                                            ),
                                          ),
                                          Image.asset(
                                            AppImage.lihatSemua,
                                            color: AppColors.appGreenlight,
                                            height: 6.h,
                                            width: 6.w,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 15.w),
                            width: double.infinity,
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                final data = snapshot.data![index];
                                return Container(
                                  height: 110.h,
                                  margin: EdgeInsets.only(
                                    bottom: 10.h,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.w,
                                    vertical: 10.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  child: Row(
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                            height: 50.h,
                                            width: 50.w,
                                            decoration: BoxDecoration(
                                              image: const DecorationImage(
                                                image: AssetImage(
                                                    AppImage.profile),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(5.r),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    data.namaPelajaran!,
                                                    style:
                                                        GoogleFonts.quicksand(
                                                      color: AppColors
                                                          .appColorBlack
                                                          .withOpacity(0.7),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12.sp,
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
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style:
                                                        GoogleFonts.quicksand(
                                                      color: AppColors
                                                          .appColorBlack,
                                                      fontSize: 10.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                if (data.hasilPengerjaan!
                                                        .statusRemidi ==
                                                    "1")
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 8.w,
                                                      vertical: 3.h,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: Colors.red
                                                          .withOpacity(0.4),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.r),
                                                    ),
                                                    child: Text(
                                                      "Remidi",
                                                      style:
                                                          GoogleFonts.quicksand(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.red,
                                                        fontSize: 8.sp,
                                                      ),
                                                    ),
                                                  ),
                                                SizedBox(
                                                  width: 5.w,
                                                ),
                                                if (data.hasilPengerjaan!
                                                        .statusResume ==
                                                    "1")
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 8.w,
                                                            vertical: 3.h),
                                                    decoration: BoxDecoration(
                                                      color: AppColors
                                                          .appColorGreenSoft2
                                                          .withOpacity(0.4),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.r),
                                                    ),
                                                    child: Text(
                                                      "Resume",
                                                      style:
                                                          GoogleFonts.quicksand(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.green,
                                                        fontSize: 8.sp,
                                                      ),
                                                    ),
                                                  ),
                                                if (data.hasilPengerjaan!
                                                        .statusResume !=
                                                    "1")
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 8.w,
                                                            vertical: 3.h),
                                                    decoration: BoxDecoration(
                                                      color: AppColors
                                                          .appGreenlight
                                                          .withOpacity(0.4),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.r),
                                                    ),
                                                    child: Text(
                                                      "Belum di resume",
                                                      style:
                                                          GoogleFonts.quicksand(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: AppColors
                                                            .appGreenlight,
                                                        fontSize: 8.sp,
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                            if (data.waktu!.tipe ==
                                                "waktu_jadwal")
                                              Row(
                                                children: [
                                                  Text(
                                                    DateFormat("d MMMM yyyy",
                                                            "id_ID")
                                                        .format(DateTime.parse(
                                                            data
                                                                .waktu!
                                                                .dataWaktu!
                                                                .tanggal
                                                                .toString())),
                                                    style:
                                                        GoogleFonts.quicksand(
                                                      fontSize: 10.sp,
                                                      color: AppColors
                                                          .appColorBlack,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            if (data.waktu!.tipe ==
                                                "waktu_range")
                                              Row(
                                                children: [
                                                  Text(
                                                    "${DateFormat("d MMMM yyyy", "id_ID").format(DateTime.parse(RangeTanggal.fromJson(data.waktu!.dataWaktu!.tanggal).mulai!))} s.d. ${DateFormat("d MMMM yyyy", "id_ID").format(DateTime.parse(RangeTanggal.fromJson(data.waktu!.dataWaktu!.tanggal).selesai!))}",
                                                    style:
                                                        GoogleFonts.quicksand(
                                                      fontSize: 10.sp,
                                                      color: AppColors
                                                          .appColorBlack,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            if (data.waktu!.tipe ==
                                                "waktu_bebas")
                                              Row(
                                                children: [
                                                  Text(
                                                    "Tidak ada batasan waktu",
                                                    style:
                                                        GoogleFonts.quicksand(
                                                      fontSize: 10.sp,
                                                      color: AppColors
                                                          .appColorBlack,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            if (data.waktu!.tipe !=
                                                "waktu_bebas")
                                              Row(
                                                children: [
                                                  Text(
                                                    "${data.waktu!.dataWaktu!.jam!.mulai} WIB s.d. ${data.waktu!.dataWaktu!.jam!.mulai} WIB",
                                                    style:
                                                        GoogleFonts.quicksand(
                                                      fontSize: 10.sp,
                                                      color: AppColors
                                                          .appColorBlack,
                                                    ),
                                                  )
                                                ],
                                              )
                                          ],
                                        ),
                                      ),
                                      Material(
                                        color: AppColors.appGreenlight
                                            .withOpacity(0.6),
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        child: InkWell(
                                          onTap: () => Get.to(
                                            DetailTugasView(
                                                data.idTugas,
                                                data.namaPelajaran,
                                                data.judul!.toTitleCase(),
                                                data.soal!.jenisSoal,
                                                data.soal!.totalSoal,
                                                data.statusTugas,
                                                true),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20.w,
                                                vertical: 5.h),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                            ),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Detail ",
                                                  style: GoogleFonts.quicksand(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: 10.sp,
                                                  ),
                                                ),
                                                Image.asset(
                                                  AppImage.lihatSemua,
                                                  color: Colors.white,
                                                  height: 6.h,
                                                  width: 6.w,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      );
                    }
                    return const SizedBox();
                  },
                ),
                if (controller.isLoading.isTrue)
                  SizedBox(
                    height: 20.h,
                  ),
                if (controller.isLoading.isTrue)
                  Center(
                    child: SizedBox(
                      height: 100.h,
                      width: 100.w,
                      child: Lottie.asset(
                        "assets/lotties/loading.json",
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
