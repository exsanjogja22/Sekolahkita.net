import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smkn1contoh/app/modules/mainpage/views/forum_view.dart';
import '../../../config/app_colors.dart';
import '../../../modules/mainpage/views/presensi_view.dart';
import '../../../modules/mainpage/views/setting_view.dart';
import '../../../config/app_image.dart';
import '../controllers/mainpage_controller.dart';
import 'home_view.dart';

class MainpageView extends GetView<MainpageController> {
  const MainpageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainpageController>(
      builder: (_) {
        return Scaffold(
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(14.r),
                topLeft: Radius.circular(14.r),
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black38,
                  spreadRadius: 0,
                  blurRadius: 10,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(14.0.r),
                topRight: Radius.circular(14.0.r),
              ),
              child: buildBottomNavigation(),
            ),
          ),
          body: Stack(
            children: [
              WillPopScope(
                onWillPop: () async {
                  final back = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r)),
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
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: controller.pageControl,
                  children: const [
                    HomeView(),
                    PresensiView(),
                    ForumView(),
                    SettingView(),
                  ],
                ),
              ),
              StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: controller.cekUpdateApp(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox();
                  } else {
                    if (snapshot.hasData) {
                      final data = snapshot.data!.data();
                      if (controller.version.value != data!["version"] &&
                          data["value"] == true) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 10.h),
                          margin: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 40.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Update Aplikasi ?",
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
                                      data["mesage"],
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
                                      "Untuk membuka aplikasi 'Sekolahkita.net' Anda harus memperbarui aplikasi. Apakah Anda ingin mengupdate nya sekarang ?  ",
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
                              SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        controller.launchURL();
                                      },
                                      child: Text(
                                        "UPDATE",
                                        style: GoogleFonts.quicksand(
                                            fontSize: 14.sp),
                                      ))),
                              Image.asset(
                                "assets/images/update.jpeg",
                                height: 120.h,
                                width: 120.w,
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
        );
      },
    );
  }

  buildBottomNavigation() {
    return BottomNavigationBar(
      elevation: 0,
      currentIndex: controller.selectIndex.value,
      onTap: controller.ontapKonten,
      selectedItemColor: AppColors.appBarColors,
      selectedLabelStyle: GoogleFonts.quicksand(
        fontSize: 10.sp,
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelStyle: GoogleFonts.quicksand(
        fontSize: 10.sp,
        fontWeight: FontWeight.bold,
      ),
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: controller.selectIndex.value == 0
              ? Image.asset(
                  width: 25.w,
                  height: 25.h,
                  AppImage.navbar0,
                )
              : Image.asset(
                  width: 25.w,
                  height: 25.h,
                  AppImage.navbar0,
                  color: Colors.grey,
                ),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: controller.selectIndex.value == 1
              ? Image.asset(
                  width: 25.w,
                  height: 25.h,
                  AppImage.navbar1,
                )
              : Image.asset(
                  width: 25.w,
                  height: 25.h,
                  AppImage.navbar1,
                  color: Colors.grey,
                ),
          label: "Presensi",
        ),
        BottomNavigationBarItem(
          icon: controller.selectIndex.value == 2
              ? Image.asset(
                  width: 25.w,
                  height: 25.h,
                  AppImage.navbar2,
                )
              : Image.asset(
                  width: 25.w,
                  height: 25.h,
                  AppImage.navbar2,
                  color: Colors.grey,
                ),
          label: "Forum",
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.only(top: 12.h),
            child: Image.asset(
              width: 22.w,
              height: 22.h,
              AppImage.navbar3,
              color: controller.selectIndex.value == 3
                  ? AppColors.appBarColors
                  : Colors.grey,
            ),
          ),
          label: "More",
        ),
      ],
    );
  }
}
