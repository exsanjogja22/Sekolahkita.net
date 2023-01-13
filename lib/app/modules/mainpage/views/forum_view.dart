import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../config/app_colors.dart';
import '../controllers/forum_controller.dart';

class ForumView extends GetView<ForumController> {
  const ForumView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.appGreenlight.withOpacity(0.4),
              AppColors.appBgroudColors
            ],
          ),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Note ?",
                    style: GoogleFonts.quicksand(
                      fontSize: 25.sp,
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
                  Expanded(
                    child: Text(
                      "Keterlibatan dan Kolaborasi para pihak sangat penting, kami hadir untuk memberikan kemudahan dan kenyamanan dalam melakukan aktifitas melalui digitalisasi sekolah. Berbagai macam Modul & Fitur yang di desain untuk realita kebutuhan di sekolah. Untuk mendukung siswa hingga pihak sekolah dalam proses belajar mengajar. Mulai dari fitur Tugas & Tes, Materi dan Belajar Mandiri, Kemajuan kelas, Presensi berbasis Geolocation & non Geo, Jurnal Mengajar Guru, Capaian siswa, Kartu Pelajar QR-Code, Nilai Kognitif dan Sikap, hingga Reporting ada disini. Masih banyak fitur menarik lainya dan terus dikembangkan. Maka dari itu untuk medukung pengembangan aplikasi kami selaku Pengembang memperbaiki kesalahan aplikasi dan penambahan fitur yang kami lakukan.",
                      style: GoogleFonts.quicksand(
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Fitur ini akan segera hadir ....",
                      style: GoogleFonts.quicksand(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              LottieBuilder.asset(
                "assets/lotties/78926-settings.json",
                height: 200,
                width: 200,
              )
            ],
          ),
        ),
      ),
    );
  }
}
