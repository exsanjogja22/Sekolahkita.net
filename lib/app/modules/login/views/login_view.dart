import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_image.dart';
import '../../../config/app_name.dart';
import '../../../routes/app_pages.dart';
import '../../../config/app_sisze.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0.0),
        child: AppBar(
          backgroundColor: AppColors.appBarColors,
          elevation: 0,
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          final back = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              title: Text(
                'Keluar ?',
                style: GoogleFonts.quicksand(
                    color: Colors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold),
              ),
              content: Text(
                'Apakah anda yakin ingin keluar dari aplikasi Sekolahkita.net ? tekan batal untuk kembali ke halaman atau "Ok" untuk keluar',
                style: GoogleFonts.quicksand(
                    color: Colors.grey,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Get.back(),
                  child: Text(
                    'Kembali',
                    style: GoogleFonts.quicksand(),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.back(result: true);
                  },
                  child: Text(
                    'OK',
                    style: GoogleFonts.quicksand(),
                  ),
                ),
              ],
            ),
          );
          if (back == null) {
            return false;
          } else {
            return true;
          }
        },
        child: Stack(
          children: [
            Container(
              width: double.infinity.w,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: AppColors.gradientColors,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Lottie.asset(
                    "assets/lotties/coba.json",
                    height: 300.h,
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 18.h),
                        Text(
                          "Selamat Datang",
                          style: GoogleFonts.quicksand(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.sp,
                            color: AppColors.appColorWhite,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          AppName.namaSekolah,
                          style: GoogleFonts.quicksand(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                            color: AppColors.appColorWhite,
                          ),
                        ),
                        Text(
                          "Aplikasi Pembelajaran Sekolah",
                          style: GoogleFonts.quicksand(
                            color: AppColors.appColorGreeYelow,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 50.h,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.appColorWhite,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                            onPressed: () {
                              Get.toNamed(Routes.LOGINMAIN);
                            },
                            child: Stack(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      AppImage.iconButtonLogin,
                                      height: 20.h,
                                      width: 20.w,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Masuk Sebagai Siswa",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.quicksand(
                                        color: const Color(0xff15aeb4),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Belum punya akun ? ",
                              style: GoogleFonts.quicksand(
                                color: AppColors.appColorWhite,
                                fontSize: 12.sp,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                controller.launchURL(
                                    "https://api.whatsapp.com/send/?phone=6281321214107&text&type=phone_number&app_absent=0");
                              },
                              child: Text(
                                'help!',
                                style: GoogleFonts.quicksand(
                                  fontSize: 12.sp,
                                  color: AppColors.appColorWhite,
                                ),
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
            //sistem update app
            StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: controller.cekUpdateApp(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (snapshot.hasData) {
                    final data = snapshot.data!.data();
                    if (controller.version.value != data!["version"] &&
                        data["value"] == true) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 10.h),
                        margin: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 30.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Update Aplikasi ?",
                              style: GoogleFonts.quicksand(
                                fontSize: 25.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              data["mesage"],
                              style: GoogleFonts.quicksand(
                                fontSize: 14.sp,
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Text(
                              "Untuk membuka aplikasi 'Sekolahkita.net' Anda harus memperbarui aplikasi. Apakah Anda ingin mengupdate nya sekarang ?  ",
                              style: GoogleFonts.quicksand(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  controller.launchURLStore();
                                },
                                child: Text(
                                  "UPDATE",
                                  style: GoogleFonts.quicksand(fontSize: 14.sp),
                                ),
                              ),
                            ),
                            Center(
                              child: Image.asset(
                                "assets/images/update.jpeg",
                                height: 150.h,
                                width: 150.w,
                              ),
                            )
                          ],
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  } else {
                    return const SizedBox();
                  }
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
