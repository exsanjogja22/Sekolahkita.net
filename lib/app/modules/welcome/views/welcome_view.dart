import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_image.dart';
import '../../../config/app_name.dart';
import '../../../routes/app_pages.dart';
import '../controllers/welcome_controller.dart';

class WelcomeView extends GetView<WelcomeController> {
  const WelcomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: AppColors.gradientColors,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).padding.top + 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      controller.skipsCase1();
                      Get.offAllNamed(Routes.MAINPAGE);
                    },
                    child: Text(
                      'Skip',
                      style: GoogleFonts.quicksand(
                        color: Colors.white,
                        fontSize: 16.0.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.height - 220,
                    child: PageView(
                        physics: const ClampingScrollPhysics(),
                        controller: GetPlatform.isAndroid
                            ? controller.pageControllerAndroid
                            : controller.pageControllerIos,
                        onPageChanged: (int page) {
                          controller.currentPage.value = page;
                        },
                        children: const <Widget>[
                          KontenWidget(),
                          KontenWidget1(),
                          KontenWidget2(),
                        ])),
                Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: buildPageIndicator(),
                    )),
                controller.currentPage.value != controller.numPages.value - 1
                    ? Expanded(
                        child: Align(
                          alignment: FractionalOffset.bottomRight,
                          child: TextButton(
                            onPressed: () {
                              if (GetPlatform.isAndroid) {
                                controller.pageControllerAndroid!.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.ease,
                                );
                              } else {
                                controller.pageControllerIos!.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.ease,
                                );
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'Next',
                                  style: GoogleFonts.quicksand(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 16.0.sp,
                                  ),
                                ),
                                SizedBox(width: 5.0.h),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                  size: 16.0.w,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : const Text(''),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Obx(
        () => controller.currentPage.value == controller.numPages.value - 1
            ? Container(
                height: 120.0.h,
                width: double.infinity,
                color: Colors.white,
                child: GestureDetector(
                  // ignore: avoid_print
                  onTap: () {
                    controller.skipsCase1();
                    Get.offAllNamed(Routes.MAINPAGE);
                  },
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 30.0.h),
                      child: Text(
                        'Mulai Sekarang',
                        style: GoogleFonts.quicksand(
                          color: AppColors.appGreenlight,
                          fontSize: 20.0.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : const Text(''),
      ),
    );
  }

  List<Widget> buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < controller.numPages.value; i++) {
      list.add(i == controller.currentPage.value
          ? _indicator(true)
          : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0.w),
      height: 8.0.h,
      width: isActive ? 24.0.w : 16.0.w,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : AppColors.appGreenDrak,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}

class KontenWidget2 extends StatelessWidget {
  const KontenWidget2({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(child: Image.asset(AppImage.bgIntro2)),
          SizedBox(height: 20.0.h),
          Text(
            'Intraksi Guru Dan siswa\nTanya Guru Kapan saja !',
            style: GoogleFonts.quicksand(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 22.sp,
            ),
          ),
          SizedBox(height: 15.0.h),
          Text(
            'Belajar Jadi lebih Interaktif ! Pertanyaanmu dapat di jawab langsung oleh guru Mata pelajaran Kamu',
            maxLines: 5,
            style: GoogleFonts.quicksand(
              color: Colors.white,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}

class KontenWidget1 extends StatelessWidget {
  const KontenWidget1({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Center(child: Image.asset(AppImage.bgIntro2)),
            ),
            SizedBox(height: 20.0.h),
            Text(
              'Belajar Bersama Guru Kelas kamu \nKapan saja Dimana Saja !',
              style: GoogleFonts.quicksand(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 22.sp,
              ),
            ),
            SizedBox(height: 15.0.h),
            Text(
              'Kerjakan tugas sekolah kapansaja dimana saja degan platforms Aplikasi Media Sosial Sekolah',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.quicksand(
                color: Colors.white,
                fontSize: 14.sp,
              ),
            ),
          ],
        ));
  }
}

class KontenWidget extends StatelessWidget {
  const KontenWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Center(child: Image.asset(AppImage.bgIntro1)),
          ),
          SizedBox(height: 20.0.h),
          Text(AppName.namaSekolah,
              style: GoogleFonts.quicksand(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 22.sp,
              )),
          SizedBox(height: 15.0.h),
          Text(
            "Login sistem smartschool dengan sistem terdigitalisasi. Sambut sistem terinteegrasi untuk mencapai sekolah yang terdigitalisasi",
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.quicksand(
              color: Colors.white,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}
