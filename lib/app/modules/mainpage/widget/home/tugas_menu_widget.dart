import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../data/models/tugas/get_tugas_model.dart';
import '../../../detail_tugas/views/detail_tugas_view.dart';
import '../../../mainpage/controllers/home_controller.dart';
import '../../../../config/app_colors.dart';

class TugasWidget extends StatelessWidget {
  const TugasWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Tugas>?>(
      future: controller.initTugas,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            padding: EdgeInsets.only(left: 15.w),
            width: double.infinity.w,
            height: 170.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Get.to(
                      DetailTugasView(
                          snapshot.data![index].idTugas,
                          snapshot.data![index].namaPelajaran,
                          snapshot.data![index].judul!.toTitleCase(),
                          snapshot.data![index].soal!.jenisSoal,
                          snapshot.data![index].soal!.totalSoal,
                          snapshot.data![index].statusTugas,
                          false),
                    );
                  },
                  child: Container(
                    margin:
                        EdgeInsets.only(right: 10.w, left: 2.w, bottom: 2.h),
                    padding: EdgeInsets.only(
                        top: 10.h, left: 10.w, right: 10.w, bottom: 10.h),
                    width: 270.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  snapshot.data![index].judul!.toTitleCase(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.quicksand(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.sp,
                                  ),
                                ),
                                Text(
                                  snapshot.data![index].namaGuru!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.quicksand(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                    fontSize: 10.sp,
                                  ),
                                ),
                              ],
                            )),
                            if (snapshot.data![index].statusTugas == "aktif")
                              Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5.w, vertical: 3.h),
                                  decoration: BoxDecoration(
                                      color: AppColors.appGreenlight
                                          .withOpacity(0.3),
                                      borderRadius:
                                          BorderRadius.circular(10.r)),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.notifications_none,
                                        size: 10.w,
                                        color: AppColors.appGreenlight,
                                      ),
                                      Text(
                                        "Tugas Aktif",
                                        style: GoogleFonts.quicksand(
                                            fontSize: 8.sp,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.appGreenlight),
                                      )
                                    ],
                                  )),
                            if (snapshot.data![index].statusTugas ==
                                "kadaluarsa")
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5.w, vertical: 3.h),
                                decoration: BoxDecoration(
                                    color: const Color(0xffF5E1E2),
                                    borderRadius: BorderRadius.circular(10.r)),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "assets/icons/presensi_icons/ic_tidak_hadir.png",
                                      height: 9.h,
                                      width: 9.w,
                                    ),
                                    Text(
                                      "Tugas Kedaluwarsa",
                                      style: GoogleFonts.quicksand(
                                          fontSize: 8.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red),
                                    )
                                  ],
                                ),
                              ),
                            if (snapshot.data![index].statusTugas ==
                                "belum_dibuka")
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5.w, vertical: 3.h),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.r)),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.notification_important_outlined,
                                      size: 10.w,
                                      color: Colors.amber,
                                    ),
                                    Text(
                                      "Tugas Belum dibuka",
                                      style: GoogleFonts.quicksand(
                                          fontSize: 8.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.amber),
                                    )
                                  ],
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.w, vertical: 3.h),
                              decoration: BoxDecoration(
                                color: AppColors.appGreenlight
                                    .withOpacity(0.3)
                                    .withOpacity(0.4),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                snapshot.data![index].namaPelajaran!,
                                style: GoogleFonts.quicksand(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.appGreenlight,
                                  fontSize: 10.sp,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10.h,
                            ),
                            if (snapshot.data![index].soal!.jenisSoal ==
                                "option")
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.w, vertical: 3.h),
                                decoration: BoxDecoration(
                                  color: AppColors.appGreenlight
                                      .withOpacity(0.3)
                                      .withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  "Pilihan Ganda",
                                  style: GoogleFonts.quicksand(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.appGreenlight,
                                    fontSize: 10.sp,
                                  ),
                                ),
                              ),
                            if (snapshot.data![index].soal!.jenisSoal ==
                                "essay")
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.w, vertical: 3.h),
                                decoration: BoxDecoration(
                                  color: AppColors.appGreenlight
                                      .withOpacity(0.3)
                                      .withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  "Essay",
                                  style: GoogleFonts.quicksand(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.appGreenlight,
                                    fontSize: 10.sp,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        if (snapshot.data![index].waktu!.tipe! == "waktu_range")
                          Row(
                            children: [
                              Text(
                                "${DateFormat("d MMMM yyyy", "id_ID").format(DateTime.parse(RangeTanggal.fromJson(snapshot.data![index].waktu!.dataWaktu!.tanggal).mulai!))} s.d. ${DateFormat("d MMMM yyyy", "id_ID").format(DateTime.parse(RangeTanggal.fromJson(snapshot.data![index].waktu!.dataWaktu!.tanggal).selesai!))}",
                                style: GoogleFonts.quicksand(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10.sp,
                                ),
                              ),
                            ],
                          ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.timer_outlined,
                                size: 10.w,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              if (snapshot.data![index].waktu!.tipe !=
                                  "waktu_bebas")
                                Text(
                                  "${snapshot.data![index].waktu!.dataWaktu!.jam!.mulai} WIB s.d. ${snapshot.data![index].waktu!.dataWaktu!.jam!.selesai} WIB",
                                  style: GoogleFonts.quicksand(
                                    color: Colors.black,
                                    fontSize: 10.sp,
                                  ),
                                ),
                              if (snapshot.data![index].waktu!.tipe ==
                                  "waktu_bebas")
                                Text(
                                  "Tidak ada batasan waktu",
                                  style: GoogleFonts.quicksand(
                                    color: Colors.black,
                                    fontSize: 10.sp,
                                  ),
                                ),
                              SizedBox(
                                height: 20.h,
                              ),
                            ]),
                        SizedBox(
                          height: 5.h,
                        ),
                        Row(
                          children: [
                            if (snapshot.data![index].hasilPengerjaan!
                                    .statusRemidi ==
                                "1")
                              Row(
                                children: [
                                  const Icon(
                                    Icons.flag_outlined,
                                    size: 10,
                                    color: Colors.black54,
                                  ),
                                  Text(
                                    "Remidi",
                                    style: GoogleFonts.quicksand(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10.sp,
                                        color: Colors.black54),
                                  )
                                ],
                              ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.meeting_room_outlined,
                                  size: 10,
                                  color: Colors.black54,
                                ),
                                Text(
                                  snapshot.data![index].idkelas!,
                                  style: GoogleFonts.quicksand(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10.sp,
                                      color: Colors.black54),
                                )
                              ],
                            ),
                            if (snapshot.data![index].hasilPengerjaan!
                                    .statusResume ==
                                "0")
                              Row(
                                children: [
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  const Icon(
                                    Icons.flag_outlined,
                                    size: 10,
                                    color: Colors.black54,
                                  ),
                                  Text(
                                    "Tidak Ada Resume",
                                    style: GoogleFonts.quicksand(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10.sp,
                                        color: Colors.black54),
                                  )
                                ],
                              ),
                            if (snapshot.data![index].hasilPengerjaan!
                                    .statusResume ==
                                "1")
                              Row(
                                children: [
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  const Icon(
                                    Icons.flag_outlined,
                                    size: 10,
                                    color: Colors.black54,
                                  ),
                                  Text(
                                    "Ada Resume",
                                    style: GoogleFonts.quicksand(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10.sp,
                                        color: Colors.black54),
                                  )
                                ],
                              ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        } else if (snapshot.hasError) {
          if (kDebugMode) {
            print(snapshot.error);
          }
        }
        return const SizedBox();
      },
    );
  }
}
