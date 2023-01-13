import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../../data/models/riport_kelas_online_model.dart';

class KelasOnine extends StatelessWidget {
  const KelasOnine({
    Key? key,
    this.data,
  }) : super(key: key);

  final DataKelasOnline? data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      height: 180.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            height: 146.h,
            width: 146.w,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    offset: const Offset(0, 4),
                    blurRadius: 4)
              ],
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Stack(
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  height: 50.h,
                  width: 50.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.r),
                      bottomRight: Radius.circular(15.r),
                    ),
                    gradient: const LinearGradient(
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
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              data!.totalKbm.toString(),
                              style: GoogleFonts.quicksand(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Kelas\nOnline",
                              style: GoogleFonts.quicksand(
                                  fontSize: 8.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: 31.h,
                  right: 10.w,
                  child: SizedBox(
                    height: 100.h,
                    width: 100.w,
                    child: CircularPercentIndicator(
                      radius: 45.0.r,
                      animation: true,
                      lineWidth: 20.0,
                      percent: data!.persentaseJoinKbm!.toDouble() / 100,
                      center: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${data!.persentaseJoinKbm} %",
                            style: GoogleFonts.quicksand(
                              color: const Color(0xff50C474),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      progressColor: const Color(0xff50C474),
                      backgroundColor: const Color(0xffEF5354),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Keaktifan siswa',
                      style: GoogleFonts.quicksand(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'mengikuti ',
                      style: GoogleFonts.quicksand(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      'kelas online',
                      style: GoogleFonts.quicksand(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
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
                      height: 40.h,
                      width: 40.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xff50C474),
                            Color(0xff70DF92),
                            Color(0xff89EBA7),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          stops: [0.0, 0.83, 1.0],
                        ),
                      ),
                      child: Center(
                        child: Text(
                          data!.totalJoinKbm.toString(),
                          style: GoogleFonts.quicksand(
                              fontSize: 20.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      'Mengikuti',
                      style: GoogleFonts.quicksand(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
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
                      height: 40.h,
                      width: 40.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.r),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xffEF5354),
                            Color(0xffF66E6F),
                            Color(0xffFF9091),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          stops: [0.0, 0.83, 1.0],
                        ),
                      ),
                      child: Center(
                        child: Text(
                          data!.totalNojoinKbm.toString(),
                          style: GoogleFonts.quicksand(
                              fontSize: 20.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      'Tidak\nMengikuti',
                      style: GoogleFonts.quicksand(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
