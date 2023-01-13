import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../../data/models/presensi/riport_presensi_model.dart';
import '../../../../config/app_colors.dart';
import '../../../../config/app_image.dart';
import '../../../../data/providers/network/repository/riport_presensi_repositori.dart';
import '../../../../modules/mainpage/controllers/presensi_controller.dart';
import '../../../../config/app_sisze.dart';

class RiportPresensiWidget extends StatelessWidget {
  const RiportPresensiWidget({super.key, required this.controller});
  final PresensiController controller;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      width: SizeConfig.screenWidth,
      child: SingleChildScrollView(
        child: GetBuilder<PresensiController>(
          id: 3,
          builder: (_) {
            return Column(
              children: [
                FutureBuilder<DataRiportPresensi?>(
                    future: controller.getDataReport(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: [
                            SizedBox(
                              height: 20.h,
                            ),
                            SizedBox(
                              height: 35.h,
                              width: double.infinity.w,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Presensi Tahun ${controller.tahunAjar} ",
                                          style: GoogleFonts.quicksand(
                                            color: const Color(0xff155A5F),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                        Text(
                                          "Presensi Harian ",
                                          style: GoogleFonts.quicksand(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  GetBuilder<PresensiController>(
                                    builder: (_) {
                                      return Container(
                                        height: 30.h,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5.h),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 10.w),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton<String>(
                                              hint: Row(
                                                children: [
                                                  Text(
                                                    'Bulan',
                                                    style:
                                                        GoogleFonts.quicksand(
                                                      color: AppColors
                                                          .appGreenlight,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12.sp,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5.w,
                                                  ),
                                                  Image.asset(
                                                    AppImage.iconTanggal,
                                                    width: 10.w,
                                                    height: 10.h,
                                                  ),
                                                ],
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              dropdownColor:
                                                  AppColors.appColorWhite,
                                              value: controller.selectedBulan,
                                              items: controller.bulan.map(
                                                (value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value["code"],
                                                    child: Text(
                                                      value['month'],
                                                      style:
                                                          GoogleFonts.quicksand(
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: AppColors
                                                            .appGreenlight,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ).toList(),
                                              icon: Icon(
                                                Icons.arrow_drop_down_outlined,
                                                size: 20.w,
                                                color: AppColors.appGreenlight,
                                              ),
                                              onChanged: (value) {
                                                controller.selectedBulan =
                                                    value!;
                                                controller.update();
                                                controller
                                                        .riportPresensiRepositori =
                                                    RiportPresensiRepositori()
                                                        .getRiport(value);
                                                controller.getDataReport();
                                                controller.update([3]);
                                              },
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            RiportHarianWidget(
                              data: snapshot.data!.presensiHarian!,
                            ),
                          ],
                        );
                      }
                      return const SizedBox();
                    }),
                FutureBuilder<DataRiportPresensi?>(
                  future: controller.getDataReport(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          SizedBox(
                            height: 15.h,
                          ),
                          GrafikPresensiHarian(
                            data: snapshot.data!.presensiHarian!,
                          ),
                        ],
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
                FutureBuilder<DataRiportPresensi?>(
                    future: controller.getDataReport(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: [
                            SizedBox(
                              height: 15.h,
                            ),
                            SizedBox(
                              height: 10.h,
                              width: double.infinity.w,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Text(
                                          "Presensi Kegiatan",
                                          style: GoogleFonts.quicksand(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            GrafikPresensiKegaitan(
                                data: snapshot.data!.presensiKegiatan!),
                          ],
                        );
                      }
                      return const SizedBox();
                    }),
                FutureBuilder<DataRiportPresensi?>(
                  future: controller.getDataReport(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          SizedBox(
                            height: 10.h,
                            width: double.infinity.w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Text(
                                        "Riwayat Presensi Kegiatan",
                                        style: GoogleFonts.quicksand(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data!.listKegiatan!.length,
                            itemBuilder: (context, index) {
                              final data = snapshot.data!.listKegiatan![index];
                              return Container(
                                margin: EdgeInsets.only(bottom: 5.h),
                                width: double.infinity,
                                height: 65.h,
                                decoration: BoxDecoration(
                                  color: index.isEven
                                      ? Colors.white54
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 8.w,
                                            vertical: 8.h,
                                          ),
                                          height: 45.h,
                                          width: 45.w,
                                          margin: EdgeInsets.symmetric(
                                            horizontal: 10.h,
                                            vertical: 10.h,
                                          ),
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.8),
                                                blurRadius: 4,
                                                offset: const Offset(0, 1),
                                              )
                                            ],
                                            color: AppColors.appColorWhite,
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                          ),
                                          child: Image.asset(
                                            "assets/icons/presensi_icons/happy.png",
                                            color: AppColors.appGreenlight
                                                .withOpacity(0.7),
                                          )),
                                    ),
                                    Expanded(
                                      flex: 5,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  data.namaKegiatan!
                                                      .toTitleCase(),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.quicksand(
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "${DateFormat("d MMMM yyyy, hh:mm", "id_ID").format(data.tanggalPresensi!)} WIB",
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.quicksand(
                                                    fontSize: 8.sp,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Material(
                                        color: AppColors.appGreenlight
                                            .withOpacity(0.7),
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                        child: InkWell(
                                          child: Container(
                                            height: 20.h,
                                            width: 50.w,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.r),
                                            ),
                                            child: Center(
                                                child: Text(
                                              "Hadir",
                                              style: GoogleFonts.quicksand(
                                                fontSize: 10.sp,
                                                color: Colors.white,
                                              ),
                                            )),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    }
                    return Column(
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        Center(
                          child: ClipOval(
                            child: Container(
                              height: 40,
                              width: 40,
                              color: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.h, vertical: 10.h),
                              child: const CircularProgressIndicator(
                                color: AppColors.appGreenlight,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

class GrafikPresensiKegaitan extends StatelessWidget {
  const GrafikPresensiKegaitan({
    Key? key,
    required this.data,
  }) : super(key: key);
  final RiportPresensiKegiatan data;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.25),
            blurRadius: 2,
            offset: const Offset(0, 2),
          )
        ],
        color: AppColors.appColorWhite,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  data.jmlKegiatan.toString(),
                  style: GoogleFonts.quicksand(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "Kegiatan",
                  style: GoogleFonts.quicksand(
                    fontSize: 10.sp,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            flex: 6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                LinearPercentIndicator(
                  barRadius: const Radius.circular(10),
                  lineHeight: 8.0,
                  animation: true,
                  percent: data.jmlKegiatan!.toDouble() != 0
                      ? data.jmlHadir!.toDouble() / data.jmlKegiatan!.toDouble()
                      : 0.0,
                  progressColor: AppColors.appGreenlight,
                  backgroundColor: AppColors.appGreenlight.withOpacity(0.2),
                ),
                LinearPercentIndicator(
                  barRadius: const Radius.circular(10),
                  lineHeight: 8.0,
                  animation: true,
                  percent: data.jmlKegiatan!.toDouble() != 0
                      ? data.jmlTidakHadir!.toDouble() /
                          data.jmlKegiatan!.toDouble()
                      : 0.0,
                  progressColor: const Color(0xffEF5354),
                  backgroundColor: const Color(0xffEF5354).withOpacity(0.2),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Container(
                          color: AppColors.appGreenlight,
                          height: 5.h,
                          width: 5.w,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          "Hadir: ",
                          style: GoogleFonts.quicksand(
                            color: Colors.grey,
                            fontSize: 10.sp,
                          ),
                        ),
                        Text(
                          data.jmlHadir.toString(),
                          style: GoogleFonts.quicksand(
                            color: Colors.black,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          color: const Color(0xffEF5354),
                          height: 5.h,
                          width: 5.w,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          "Tidak Hadir: ",
                          style: GoogleFonts.quicksand(
                            color: Colors.grey,
                            fontSize: 10.sp,
                          ),
                        ),
                        Text(
                          data.jmlTidakHadir.toString(),
                          style: GoogleFonts.quicksand(
                            color: AppColors.appColorBlack,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: CircularPercentIndicator(
              radius: 25.0.r,
              animation: true,
              lineWidth: 5.0,
              percent: data.persentaseHadir!.toDouble() / 100,
              center: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${data.persentaseHadir} %",
                    style: GoogleFonts.quicksand(
                      color: AppColors.appGreenlight,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Hadir',
                    style: GoogleFonts.quicksand(
                      color: AppColors.appGreenlight,
                      fontSize: 6.sp,
                    ),
                  )
                ],
              ),
              progressColor: AppColors.appGreenlight,
              circularStrokeCap: CircularStrokeCap.round,
              backgroundColor: const Color(0xffEF5354),
            ),
          )
        ],
      ),
    );
  }
}

class GrafikPresensiHarian extends StatelessWidget {
  const GrafikPresensiHarian({
    Key? key,
    required this.data,
  }) : super(key: key);
  final RiportPresensiHarian data;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.25),
            blurRadius: 2,
            offset: const Offset(0, 2),
          )
        ],
        color: AppColors.appColorWhite,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  data.jmlHariEfektif.toString(),
                  style: GoogleFonts.quicksand(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "Hari efektif",
                  style: GoogleFonts.quicksand(
                    fontSize: 10.sp,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            flex: 6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                LinearPercentIndicator(
                  barRadius: const Radius.circular(10),
                  lineHeight: 8.0,
                  animation: true,
                  percent: data.jmlHariEfektif!.toDouble() != 0
                      ? data.jmlHadir!.toDouble() /
                          data.jmlHariEfektif!.toDouble()
                      : 0.0,
                  progressColor: AppColors.appGreenlight,
                  backgroundColor: AppColors.appGreenlight.withOpacity(0.2),
                ),
                LinearPercentIndicator(
                  barRadius: const Radius.circular(10),
                  lineHeight: 8.0,
                  animation: true,
                  percent: data.jmlHariEfektif!.toDouble() != 0
                      ? data.jmlIzin!.toDouble() /
                          data.jmlHariEfektif!.toDouble()
                      : 0.0,
                  progressColor: const Color(0xff578EFE),
                  backgroundColor: const Color(0xff578EFE).withOpacity(0.2),
                ),
                LinearPercentIndicator(
                  barRadius: const Radius.circular(10),
                  lineHeight: 8.0,
                  animation: true,
                  percent: data.jmlHariEfektif!.toDouble() != 0
                      ? data.jmlSakit!.toDouble() /
                          data.jmlHariEfektif!.toDouble()
                      : 0.0,
                  progressColor: const Color(0xffFCC800),
                  backgroundColor: const Color(0xffFCC800).withOpacity(0.2),
                ),
                LinearPercentIndicator(
                  barRadius: const Radius.circular(10),
                  lineHeight: 8.0,
                  animation: true,
                  percent: data.jmlHariEfektif!.toDouble() != 0
                      ? data.jmlAlfa!.toDouble() /
                          data.jmlHariEfektif!.toDouble()
                      : 0.0,
                  progressColor: const Color(0xffEF5354),
                  backgroundColor: const Color(0xffEF5354).withOpacity(0.2),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: CircularPercentIndicator(
              radius: 25.0.r,
              animation: true,
              lineWidth: 5.0,
              percent: data.persentaseHadir!.toDouble() / 100,
              center: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${data.persentaseHadir} %",
                    style: GoogleFonts.quicksand(
                      color: AppColors.appGreenlight,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Hadir',
                    style: GoogleFonts.quicksand(
                      color: AppColors.appGreenlight,
                      fontSize: 6.sp,
                    ),
                  )
                ],
              ),
              progressColor: AppColors.appGreenlight,
              circularStrokeCap: CircularStrokeCap.round,
              backgroundColor: AppColors.appGreenlight.withOpacity(0.3),
            ),
          )
        ],
      ),
    );
  }
}

class RiportHarianWidget extends StatelessWidget {
  const RiportHarianWidget({
    Key? key,
    required this.data,
  }) : super(key: key);
  final RiportPresensiHarian data;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity.w,
      height: 90.h,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.25),
                          blurRadius: 2,
                          offset: const Offset(0, 2),
                        )
                      ],
                      color: AppColors.appColorWhite,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 40.h,
                          width: 50.w,
                          decoration: BoxDecoration(
                            color: AppColors.appBarColors,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.r),
                              bottomLeft: Radius.circular(10.r),
                            ),
                          ),
                          child: Center(
                            child: Image.asset(
                              AppImage.iconsMasuk,
                              height: 20.h,
                              width: 20.w,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Hadir",
                                style: GoogleFonts.quicksand(
                                  color: AppColors.appColorBlack,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10.sp,
                                ),
                              ),
                              Text(
                                data.jmlHadir.toString(),
                                style: GoogleFonts.quicksand(
                                  color: Colors.grey,
                                  fontSize: 10.sp,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.25),
                          blurRadius: 2,
                          offset: const Offset(0, 2),
                        )
                      ],
                      color: AppColors.appColorWhite,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 40.h,
                          width: 50.w,
                          decoration: BoxDecoration(
                            color: const Color(0xffFCC800),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.r),
                              bottomLeft: Radius.circular(10.r),
                            ),
                          ),
                          child: Center(
                            child: Image.asset(
                              AppImage.iconsSakit,
                              height: 20.h,
                              width: 20.w,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Sakit",
                                style: GoogleFonts.quicksand(
                                  color: AppColors.appColorBlack,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10.sp,
                                ),
                              ),
                              Text(
                                data.jmlSakit.toString(),
                                style: GoogleFonts.quicksand(
                                  color: Colors.grey,
                                  fontSize: 10.sp,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.25),
                          blurRadius: 2,
                          offset: const Offset(0, 2),
                        )
                      ],
                      color: AppColors.appColorWhite,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 40.h,
                          width: 50.w,
                          decoration: BoxDecoration(
                            color: const Color(0xff6C99F6),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.r),
                              bottomLeft: Radius.circular(10.r),
                            ),
                          ),
                          child: Center(
                            child: Image.asset(
                              AppImage.iconsIzin,
                              height: 20.h,
                              width: 20.w,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Izin",
                                style: GoogleFonts.quicksand(
                                  color: AppColors.appColorBlack,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10.sp,
                                ),
                              ),
                              Text(
                                data.jmlIzin.toString(),
                                style: GoogleFonts.quicksand(
                                  color: Colors.grey,
                                  fontSize: 10.sp,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.25),
                          blurRadius: 2,
                          offset: const Offset(0, 2),
                        )
                      ],
                      color: AppColors.appColorWhite,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 40.h,
                          width: 50.w,
                          decoration: BoxDecoration(
                            color: const Color(0xffF97276),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.r),
                              bottomLeft: Radius.circular(10.r),
                            ),
                          ),
                          child: Center(
                            child: Image.asset(
                              AppImage.iconsIzin,
                              height: 20.h,
                              width: 20.w,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Alfa",
                                style: GoogleFonts.quicksand(
                                  color: AppColors.appColorBlack,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10.sp,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    data.jmlAlfa.toString(),
                                    style: GoogleFonts.quicksand(
                                      color: Colors.grey,
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
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
