import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../../config/app_colors.dart';
import '../../../../data/models/presensi/riport_presensi_model.dart';

class PresensiHarian extends StatelessWidget {
  const PresensiHarian({
    Key? key,
    this.data,
  }) : super(key: key);

  final DataRiportPresensi? data;

  @override
  Widget build(BuildContext context) {
    // final controller = Get.find<StatistikController>();

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 15.w,
        vertical: 15.h,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Presensi harian",
                style: GoogleFonts.quicksand(
                  color: const Color(0xff155A5F),
                  fontWeight: FontWeight.bold,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                width: 80.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xff6C99F6),
                      Color(0xff81AAFF),
                      Color(0xff9BBCFF),
                    ],
                    stops: [0.0, 0.47, 0.98],
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          "assets/icons/Ic_tanggal.png",
                          color: Colors.white,
                          height: 15.h,
                          width: 15.w,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              data!.presensiHarian!.jmlHariEfektif.toString(),
                              style: GoogleFonts.quicksand(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Hari Efektif",
                              style: GoogleFonts.quicksand(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 15.w,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                width: 60.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xffFCC800),
                      Color(0xffFFD841),
                      Color(0xffFFEA96),
                    ],
                    stops: [0.0, 0.47, 0.98],
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          "assets/icons/ic_login.png",
                          color: Colors.white,
                          height: 15.h,
                          width: 15.w,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              data!.presensiHarian!.jmlHadir.toString(),
                              style: GoogleFonts.quicksand(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Hadir",
                              style: GoogleFonts.quicksand(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 15.w,
              ),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 10.h,
                          width: 10.h,
                          color: AppColors.appGreenlight,
                        ),
                        SizedBox(
                          width: 3.w,
                        ),
                        Text(
                          "Sakit :",
                          style: GoogleFonts.quicksand(
                            fontWeight: FontWeight.w400,
                            fontSize: 8.sp,
                          ),
                        ),
                        Text(
                          data!.presensiHarian!.jmlSakit.toString(),
                          style: GoogleFonts.quicksand(
                            fontWeight: FontWeight.bold,
                            fontSize: 8.sp,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 10.h,
                          width: 10.w,
                          color: const Color(0xff6C99F6),
                        ),
                        SizedBox(
                          width: 3.w,
                        ),
                        Text(
                          "Izin :",
                          style: GoogleFonts.quicksand(
                            fontWeight: FontWeight.w400,
                            fontSize: 8.sp,
                          ),
                        ),
                        Text(
                          data!.presensiHarian!.jmlIzin.toString(),
                          style: GoogleFonts.quicksand(
                            fontWeight: FontWeight.bold,
                            fontSize: 8.sp,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 10.h,
                          width: 10.w,
                          color: const Color(0xffEF5354),
                        ),
                        SizedBox(
                          width: 3.w,
                        ),
                        Text(
                          "Alfa :",
                          style: GoogleFonts.quicksand(
                            fontWeight: FontWeight.w400,
                            fontSize: 8.sp,
                          ),
                        ),
                        Text(
                          data!.presensiHarian!.jmlAlfa.toString(),
                          style: GoogleFonts.quicksand(
                            fontWeight: FontWeight.bold,
                            fontSize: 8.sp,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            children: [
              Text(
                "Presensi Kegiatan",
                style: GoogleFonts.quicksand(
                  color: const Color(0xff155A5F),
                  fontWeight: FontWeight.bold,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                width: 80.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xff6C99F6),
                      Color(0xff81AAFF),
                      Color(0xff9BBCFF),
                    ],
                    stops: [0.0, 0.47, 0.98],
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          "assets/icons/Ic_tanggal.png",
                          color: Colors.white,
                          height: 15.h,
                          width: 15.w,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              data!.presensiKegiatan!.jmlKegiatan.toString(),
                              style: GoogleFonts.quicksand(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Kegiatan",
                              style: GoogleFonts.quicksand(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 10.h,
                        ),
                        Container(
                          height: 20.h,
                          width: 20.w,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black.withOpacity(0.1)),
                              borderRadius: BorderRadius.circular(5.r)),
                          child: Center(
                            child: Text(
                              "${((data!.presensiKegiatan!.jmlHadir!.toDouble() / data!.presensiKegiatan!.jmlKegiatan!.toDouble()) * 100).toInt()}",
                              style: GoogleFonts.quicksand(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 8.sp,
                                  color: AppColors.appGreenlight),
                            ),
                          ),
                        ),
                        Expanded(
                          child: LinearPercentIndicator(
                              barRadius: const Radius.circular(10),
                              lineHeight: 6.0,
                              animation: true,
                              percent: data!.presensiKegiatan!.jmlKegiatan!
                                          .toDouble() !=
                                      0
                                  ? data!.presensiKegiatan!.jmlHadir!
                                          .toDouble() /
                                      data!.presensiKegiatan!.jmlKegiatan!
                                          .toDouble()
                                  : 0.0,
                              progressColor: AppColors.appGreenlight,
                              backgroundColor:
                                  AppColors.appGreenlight.withOpacity(0.2)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 10.h,
                        ),
                        Container(
                          height: 20.h,
                          width: 20.w,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black.withOpacity(0.1)),
                              borderRadius: BorderRadius.circular(5.r)),
                          child: Center(
                            child: Text(
                              "${((data!.presensiKegiatan!.jmlTidakHadir!.toDouble() / data!.presensiKegiatan!.jmlKegiatan!.toDouble()) * 100).toInt()}",
                              style: GoogleFonts.quicksand(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 8.sp,
                                  color: const Color(0xffEF5354)),
                            ),
                          ),
                        ),
                        Expanded(
                          child: LinearPercentIndicator(
                            barRadius: const Radius.circular(10),
                            lineHeight: 6.0,
                            animation: true,
                            percent: data!.presensiKegiatan!.jmlKegiatan!
                                        .toDouble() !=
                                    0
                                ? data!.presensiKegiatan!.jmlTidakHadir!
                                        .toDouble() /
                                    data!.presensiKegiatan!.jmlKegiatan!
                                        .toDouble()
                                : 0.0,
                            progressColor: const Color(0xffEF5354),
                            backgroundColor:
                                const Color(0xffEF5354).withOpacity(0.2),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 10.h,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 10.h,
                              width: 10.w,
                              color: AppColors.appGreenlight,
                            ),
                            SizedBox(
                              width: 3.w,
                            ),
                            Text(
                              "Hadir :",
                              style: GoogleFonts.quicksand(
                                fontWeight: FontWeight.w400,
                                fontSize: 8.sp,
                              ),
                            ),
                            Text(
                              "${data!.presensiKegiatan!.jmlHadir} Hari",
                              style: GoogleFonts.quicksand(
                                fontWeight: FontWeight.bold,
                                fontSize: 8.sp,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 10.h,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 10.h,
                              width: 10.w,
                              color: const Color(0xffEF5354),
                            ),
                            SizedBox(
                              width: 3.w,
                            ),
                            Text(
                              "Tidak hadir :",
                              style: GoogleFonts.quicksand(
                                fontWeight: FontWeight.w400,
                                fontSize: 8.sp,
                              ),
                            ),
                            Text(
                              "${data!.presensiKegiatan!.jmlTidakHadir} Hari",
                              style: GoogleFonts.quicksand(
                                fontWeight: FontWeight.bold,
                                fontSize: 8.sp,
                              ),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
