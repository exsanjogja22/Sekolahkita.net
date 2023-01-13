import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:smkn1contoh/app/config/app_image.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_sisze.dart';
import '../controllers/jadwal_controller.dart';

class JadwalView extends GetView<JadwalController> {
  const JadwalView({Key? key}) : super(key: key);
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
        width: SizeConfig.screenWidth,
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 150.h,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  width: double.infinity,
                  height: 115.h,
                  decoration: const BoxDecoration(
                    gradient:
                        const LinearGradient(colors: AppColors.gradientColors),
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
                                  "Jadwal Pelajaran",
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
                  top: 70.h,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Stack(
                            children: [
                              SizedBox(
                                height: 75.h,
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  Container(
                                    height: 60.h,
                                    width: 90.w,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 4,
                                            offset: const Offset(3, 2),
                                            color:
                                                Colors.black.withOpacity(0.2))
                                      ],
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15.r),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Tahun",
                                          style: GoogleFonts.quicksand(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xff747474),
                                          ),
                                        ),
                                        Text(
                                          controller.tahun.value,
                                          style: GoogleFonts.quicksand(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xff5E5E5E),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Positioned(
                                left: 29.w,
                                right: 29.w,
                                child: Container(
                                  height: 30.h,
                                  width: 30.w,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 2,
                                        offset: const Offset(1, 2),
                                        color: Colors.black.withOpacity(0.1),
                                      )
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5).r,
                                  ),
                                  child: Image.asset(
                                    AppImage.iconsJadwal1,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Stack(
                            children: [
                              SizedBox(
                                height: 75.h,
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  Container(
                                    height: 60.h,
                                    width: 90.w,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 4,
                                            offset: const Offset(3, 2),
                                            color:
                                                Colors.black.withOpacity(0.2))
                                      ],
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15.r),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Kelas",
                                          style: GoogleFonts.quicksand(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xff747474),
                                          ),
                                        ),
                                        Text(
                                          controller.kelas.value,
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.quicksand(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xff5E5E5E),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Positioned(
                                left: 29.w,
                                right: 29.w,
                                child: Container(
                                  height: 30.h,
                                  width: 30.w,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 2,
                                        offset: const Offset(1, 2),
                                        color: Colors.black.withOpacity(0.1),
                                      )
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Image.asset(
                                    AppImage.iconsJadwal2,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Stack(
                            children: [
                              SizedBox(
                                height: 75.h,
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  Container(
                                    height: 60.h,
                                    width: 90.w,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 4,
                                          offset: const Offset(3, 2),
                                          color: Colors.black.withOpacity(0.2),
                                        )
                                      ],
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15.r),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Semester",
                                          style: GoogleFonts.quicksand(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xff747474),
                                          ),
                                        ),
                                        Text(
                                          controller.semester.value,
                                          style: GoogleFonts.quicksand(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xff5E5E5E),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Positioned(
                                left: 29.w,
                                right: 29.w,
                                child: Container(
                                  height: 30.h,
                                  width: 30.w,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 2,
                                        offset: const Offset(1, 2),
                                        color: Colors.black.withOpacity(0.1),
                                      )
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Image.asset(
                                    AppImage.iconsJadwal3,
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    height: 100.h,
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                    child: Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          controller.listHari.length,
                          (index) => Material(
                            color: controller.selectedHari.value ==
                                    controller.listHari[index]
                                ? const Color(0xff0AB19A)
                                : const Color(0xff0AB19A).withOpacity(0.3),
                            borderRadius: BorderRadius.circular(10.r),
                            child: InkWell(
                              onTap: () {
                                controller.selectedHari.value =
                                    controller.listHari[index];
                              },
                              borderRadius: BorderRadius.circular(10.r),
                              child: Container(
                                height: 70.h,
                                width: 50.w,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color(0xffE9E9E9),
                                  ),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Center(
                                  child: Text(
                                    controller.listHari[index],
                                    style: GoogleFonts.quicksand(
                                        color: controller.selectedHari.value ==
                                                controller.listHari[index]
                                            ? Colors.white
                                            : const Color(0xff5E5E5E),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10.sp),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Obx(
                        () {
                          if (controller.isLoading.isFalse) {
                            if (controller.tipeJadwal.value == "date") {
                              final data = controller.listJadwalDate
                                  .where((element) =>
                                      element.hari ==
                                      controller.selectedHari.value)
                                  .toList();
                              if (data.isNotEmpty) {
                                return ListView.builder(
                                  itemCount: data.length,
                                  itemBuilder: (context, index) {
                                    final data1 = data[index].jadwal!;
                                    return Column(
                                      children: List.generate(
                                        data1.length,
                                        (index1) => Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "${controller.selectedHari}, ${DateFormat("d MMMM yyyy", "id_ID").format(data1[index1].tanggal!)}",
                                                  style: GoogleFonts.quicksand(
                                                    fontSize: 12,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            Column(
                                              children: List.generate(
                                                data1[index1]
                                                    .dataTanggal!
                                                    .length,
                                                (index2) => Row(
                                                  children: [
                                                    SizedBox(
                                                      height: 3 == 2
                                                          ? SizeConfig
                                                                  .screenHeight! /
                                                              5.20
                                                          : SizeConfig
                                                                  .screenHeight! /
                                                              6,
                                                      width: 20,
                                                      child: TimelineTile(
                                                        alignment: TimelineAlign
                                                            .manual,
                                                        lineXY: 0,
                                                        isFirst: true,
                                                        indicatorStyle:
                                                            IndicatorStyle(
                                                                indicatorXY: 0,
                                                                width: 15,
                                                                indicator:
                                                                    Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    border: Border.all(
                                                                        width:
                                                                            5,
                                                                        color: index2.isEven
                                                                            ? AppColors.appGreenlight
                                                                            : const Color(0xff3879FE)),
                                                                  ),
                                                                )),
                                                        afterLineStyle:
                                                            LineStyle(
                                                          thickness: 2,
                                                          color: index2.isEven
                                                              ? AppColors
                                                                  .appGreenlight
                                                              : const Color(
                                                                  0xff3879FE),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                        child: Row(
                                                      children: [
                                                        Column(
                                                          children: [
                                                            Text(
                                                              data1[index1]
                                                                  .dataTanggal![
                                                                      index2]
                                                                  .jam!
                                                                  .mulai!,
                                                              style: GoogleFonts
                                                                  .quicksand(
                                                                fontSize: 10.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.7),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 90,
                                                            ),
                                                            Text(
                                                              data1[index1]
                                                                  .dataTanggal![
                                                                      index2]
                                                                  .jam!
                                                                  .selesai!,
                                                              style: GoogleFonts
                                                                  .quicksand(
                                                                fontSize: 10.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.7),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Expanded(
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(15),
                                                            margin:
                                                                const EdgeInsets
                                                                    .all(5),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: index2
                                                                      .isEven
                                                                  ? AppColors
                                                                      .appGreenlight
                                                                      .withOpacity(
                                                                          0.1)
                                                                  : const Color(
                                                                          0xff3879FE)
                                                                      .withOpacity(
                                                                          0.1),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            width:
                                                                double.infinity,
                                                            height: 100,
                                                            child: Row(
                                                              children: [
                                                                Expanded(
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Column(
                                                                        children: [
                                                                          Row(
                                                                            children: [
                                                                              Expanded(
                                                                                child: Text(
                                                                                  data1[index1].dataTanggal![index2].namaGuru!,
                                                                                  maxLines: 1,
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  style: GoogleFonts.quicksand(
                                                                                    fontSize: 10.sp,
                                                                                    fontWeight: FontWeight.bold,
                                                                                  ),
                                                                                ),
                                                                              )
                                                                            ],
                                                                          ),
                                                                          Row(
                                                                            children: [
                                                                              Expanded(
                                                                                child: Text(
                                                                                  data1[index1].dataTanggal![index2].mapel!,
                                                                                  maxLines: 2,
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  style: GoogleFonts.quicksand(
                                                                                    fontSize: 10.sp,
                                                                                    fontWeight: FontWeight.w500,
                                                                                  ),
                                                                                ),
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Text(
                                                                            "${data1[index1].dataTanggal![index2].jam!.mulai!} - ${data1[index1].dataTanggal![index2].jam!.selesai!}",
                                                                            style:
                                                                                GoogleFonts.quicksand(
                                                                              fontSize: 10.sp,
                                                                              fontWeight: FontWeight.w500,
                                                                            ),
                                                                          )
                                                                        ],
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                CircleAvatar(
                                                                  radius: 20,
                                                                  backgroundColor: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.4),
                                                                  backgroundImage:
                                                                      NetworkImage(
                                                                    data1[index1]
                                                                        .dataTanggal![
                                                                            index2]
                                                                        .avatarGuru!,
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ))
                                                  ],
                                                ),
                                              ).toList(),
                                            ),
                                          ],
                                        ),
                                      ).toList(),
                                    );
                                  },
                                );
                              } else {
                                return Center(
                                  child: Text(
                                    'Jadwal Belum Tersedia',
                                    style: GoogleFonts.quicksand(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                );
                              }
                            } else {
                              final data = controller.listJadwalDay
                                  .where((element) =>
                                      element.hari ==
                                      controller.selectedHari.value)
                                  .toList();
                              return ListView.builder(
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  final data1 = data[index].jadwal!;
                                  return Column(
                                      children: List.generate(
                                    data1.length,
                                    (index1) => Row(
                                      children: [
                                        SizedBox(
                                          height: 3 == 2
                                              ? SizeConfig.screenHeight! / 5.20
                                              : SizeConfig.screenHeight! / 6,
                                          width: 20,
                                          child: TimelineTile(
                                            alignment: TimelineAlign.manual,
                                            lineXY: 0,
                                            isFirst: true,
                                            indicatorStyle: IndicatorStyle(
                                                indicatorXY: 0,
                                                width: 15,
                                                indicator: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                        width: 5,
                                                        color: index1.isEven
                                                            ? AppColors
                                                                .appGreenlight
                                                            : const Color(
                                                                0xff3879FE)),
                                                  ),
                                                )),
                                            afterLineStyle: LineStyle(
                                              thickness: 2,
                                              color: index1.isEven
                                                  ? AppColors.appGreenlight
                                                  : const Color(0xff3879FE),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                            child: Row(
                                          children: [
                                            Column(
                                              children: [
                                                Text(
                                                  data1[index1].jam!.mulai!,
                                                  style: GoogleFonts.quicksand(
                                                    fontSize: 10.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black
                                                        .withOpacity(0.7),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 90,
                                                ),
                                                Text(
                                                  data1[index1].jam!.selesai!,
                                                  style: GoogleFonts.quicksand(
                                                    fontSize: 10.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black
                                                        .withOpacity(0.7),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Expanded(
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(15),
                                                margin: const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  color: index1.isEven
                                                      ? AppColors.appGreenlight
                                                          .withOpacity(0.1)
                                                      : const Color(0xff3879FE)
                                                          .withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                width: double.infinity,
                                                height: 100,
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Column(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Expanded(
                                                                    child: Text(
                                                                      data1[index1]
                                                                          .namaGuru!,
                                                                      maxLines:
                                                                          1,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: GoogleFonts
                                                                          .quicksand(
                                                                        fontSize:
                                                                            10.sp,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Expanded(
                                                                    child: Text(
                                                                      data1[index1]
                                                                          .mapel!,
                                                                      maxLines:
                                                                          2,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: GoogleFonts
                                                                          .quicksand(
                                                                        fontSize:
                                                                            10.sp,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                "${data1[index1].jam!.mulai!} - ${data1[index1].jam!.selesai!}",
                                                                style: GoogleFonts
                                                                    .quicksand(
                                                                  fontSize:
                                                                      10.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    CircleAvatar(
                                                        radius: 20,
                                                        backgroundColor: Colors
                                                            .grey
                                                            .withOpacity(0.4),
                                                        backgroundImage:
                                                            NetworkImage(data1[
                                                                    index1]
                                                                .avatarGuru!))
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ))
                                      ],
                                    ),
                                  ));
                                },
                              );
                            }
                          } else {
                            return Center(
                              child: SizedBox(
                                height: 100.h,
                                width: 100.w,
                                child: Lottie.asset(
                                  "assets/lotties/loading.json",
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
