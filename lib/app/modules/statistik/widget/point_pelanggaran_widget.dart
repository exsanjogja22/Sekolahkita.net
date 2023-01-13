import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../config/app_colors.dart';
import '../../../data/models/riport_point_pelangaran_model.dart';
import '../controllers/statistik_controller.dart';

class PointPelangaran extends StatelessWidget {
  const PointPelangaran({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final StatistikController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.w),
      child: SingleChildScrollView(
        child: GetBuilder<StatistikController>(
            id: 3,
            builder: (_) {
              return FutureBuilder<DataPelangaran?>(
                  future: controller.getDataRiportPel(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          SizedBox(
                            height: 35.h,
                            width: double.infinity.w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Text(
                                        "Point Pelangaran Tahun ${controller.tahunAjar.value}",
                                        style: GoogleFonts.quicksand(
                                          color: const Color(0xff155A5F),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 30.h,
                                  decoration: BoxDecoration(
                                    color: const Color(0xff6C99F6),
                                    borderRadius: BorderRadius.circular(5.h),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 10.w),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        hint: Row(
                                          children: [
                                            Text(
                                              'Bulan',
                                              style: GoogleFonts.quicksand(
                                                color: AppColors.appColorWhite,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                        dropdownColor: const Color(0xff6C99F6),
                                        value: controller.selectedBulan3,
                                        items: controller.bulan.map(
                                          (value) {
                                            return DropdownMenuItem<String>(
                                              value: value["code"],
                                              child: Text(
                                                value['month'],
                                                style: GoogleFonts.quicksand(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      AppColors.appColorWhite,
                                                ),
                                              ),
                                            );
                                          },
                                        ).toList(),
                                        icon: Icon(
                                          Icons.arrow_drop_down_outlined,
                                          size: 20.w,
                                          color: AppColors.appColorWhite,
                                        ),
                                        onChanged: (value) {
                                          controller.selectedBulan3 = value!;
                                          controller.getDataRiportPel();
                                          controller.update([3]);
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 10.h),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      Text(
                                        "Jumlah Pelanggaran",
                                        style: GoogleFonts.quicksand(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.sp,
                                          color: const Color(0xff578EFE),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w, vertical: 10.h),
                                        decoration: BoxDecoration(
                                          color: const Color(0xff578EFE),
                                          borderRadius:
                                              BorderRadius.circular(15.r),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  snapshot.data!.jmlPelanggaran
                                                      .toString(),
                                                  style: GoogleFonts.quicksand(
                                                      fontSize: 40.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'Pelanggaran',
                                                  style: GoogleFonts.quicksand(
                                                      fontSize: 10.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10.w,
                                      vertical: 10.h,
                                    ),
                                    height: 107.h,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffF97276),
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(15.r),
                                        bottomRight: Radius.circular(15.r),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "Total Skor",
                                                    style:
                                                        GoogleFonts.quicksand(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12.sp,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    snapshot.data!.totalSkor
                                                        .toString(),
                                                    style:
                                                        GoogleFonts.quicksand(
                                                            fontSize: 40.sp,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.white),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    'Point',
                                                    style:
                                                        GoogleFonts.quicksand(
                                                            fontSize: 10.sp,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.white),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        Image.asset(
                                          "assets/icons/ic_pelangaran.png",
                                          height: 50,
                                          width: 50,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data!.listPelanggaran!.length,
                              itemBuilder: (context, index) {
                                final data =
                                    snapshot.data!.listPelanggaran![index];
                                return Container(
                                  margin: EdgeInsets.only(bottom: 10.h),
                                  decoration: BoxDecoration(
                                    color: index.isEven
                                        ? Colors.white
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
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
                                              color:
                                                  Colors.grey.withOpacity(0.8),
                                              blurRadius: 4,
                                              offset: const Offset(0, 1),
                                            )
                                          ],
                                          color: AppColors.appColorWhite,
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                        ),
                                        child: Image.asset(
                                          "assets/icons/presensi_icons/ic_tidak_hadir.png",
                                          height: 20.h,
                                          width: 20.w,
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            // Row(
                                            //   children: [
                                            //     Text(
                                            //       data.tipePelanggaran!,
                                            //       style: GoogleFonts.quicksand(
                                            //         fontSize: 12.sp,
                                            //         fontWeight: FontWeight.w500,
                                            //         color: Colors.black87,
                                            //       ),
                                            //     )
                                            //   ],
                                            // ),
                                            // SizedBox(
                                            //   height: 5.h,
                                            // ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    data.namaPelanggaran!,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style:
                                                        GoogleFonts.quicksand(
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black87,
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
                                                Text(
                                                  '${data.tanggalPelanggaran}',
                                                  style: GoogleFonts.quicksand(
                                                    fontSize: 8.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.grey,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Stack(
                                        children: [
                                          SizedBox(
                                            width: 85.w,
                                            height: 40.h,
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                height: 40.h,
                                                width: 8.w,
                                              ),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 10.w,
                                                  vertical: 10.h,
                                                ),
                                                width: 75.w,
                                                height: 40.h,
                                                decoration: BoxDecoration(
                                                  color:
                                                      AppColors.appGreenlight,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.r),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      data.jmlSkor.toString(),
                                                      style:
                                                          GoogleFonts.quicksand(
                                                        fontSize: 18.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Positioned(
                                            top: 12.h,
                                            left: 0.w,
                                            child: Container(
                                              width: 40.w,
                                              height: 15.h,
                                              decoration: BoxDecoration(
                                                color: const Color(0xffF97276),
                                                borderRadius:
                                                    BorderRadius.circular(3.r),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Poin",
                                                  style: GoogleFonts.quicksand(
                                                    color: Colors.white,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
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
                    return Center(
                      child: SizedBox(
                        height: 100.h,
                        width: 100.w,
                        child: Lottie.asset(
                          "assets/lotties/loading.json",
                        ),
                      ),
                    );
                  });
            }),
      ),
    );
  }
}
