import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../../config/app_colors.dart';
import '../../../../data/models/riport_keaktifan_kbm_model.dart';

class KeaktifanKbm extends StatelessWidget {
  const KeaktifanKbm({
    Key? key,
    this.data,
  }) : super(key: key);

  final List<DataRiport>? data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: data!.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(
              bottom: 10.h,
            ),
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.r),
            ),
            child: Row(
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.w),
                  width: 100.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.r),
                    gradient: index.isEven
                        ? const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xffFCC800),
                              Color(0xffFFDB4E),
                              Color(0xffFFDF64),
                            ],
                            stops: [0.0, 0.78, 1.0],
                          )
                        : const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xff6C99F6),
                              Color(0xff81AAFF),
                              Color(0xff9BBCFF),
                            ],
                            stops: [0.0, 0.78, 1.0],
                          ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              data![index].mapel!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.quicksand(
                                fontWeight: FontWeight.bold,
                                fontSize: 10.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            data![index].jmlPertemuan.toString(),
                            style: GoogleFonts.quicksand(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.sp,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 3.w,
                          ),
                          Text(
                            "Pertemuan",
                            style: GoogleFonts.quicksand(
                              fontWeight: FontWeight.w500,
                              fontSize: 10.sp,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      LinearPercentIndicator(
                        barRadius: const Radius.circular(10),
                        lineHeight: 6.0,
                        animation: true,
                        percent: data![index].jmlPertemuan!.toDouble() != 0
                            ? data![index].jmlHadir!.toDouble() /
                                data![index].jmlPertemuan!.toDouble()
                            : 0.0,
                        progressColor: AppColors.appGreenlight,
                        backgroundColor:
                            AppColors.appGreenlight.withOpacity(0.2),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      LinearPercentIndicator(
                        barRadius: Radius.circular(10.r),
                        lineHeight: 6.0,
                        animation: true,
                        percent: data![index].jmlPertemuan!.toDouble() != 0
                            ? data![index].jmlTidakHadir!.toDouble() /
                                data![index].jmlPertemuan!.toDouble()
                            : 0.0,
                        progressColor: const Color(0xffEF5354),
                        backgroundColor:
                            const Color(0xffEF5354).withOpacity(0.2),
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
                                "${data![index].jmlHadir!} Hari",
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
                                "${data![index].jmlTidakHadir!} Hari",
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
                ),
                CircularPercentIndicator(
                  radius: 25.0.r,
                  animation: true,
                  lineWidth: 5.0,
                  percent: data![index].persentaseKehadiran!.toDouble() / 100,
                  center: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${data![index].persentaseKehadiran} %",
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
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
