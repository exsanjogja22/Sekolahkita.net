import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:showcaseview/showcaseview.dart';
import '../../../../routes/app_pages.dart';
import '../../controllers/home_controller.dart';

class BarMenuWidget extends StatelessWidget {
  const BarMenuWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.w),
      width: double.infinity.w,
      child: Showcase(
        key: controller.four,
        title: 'Menu',
        description: 'Ini adalah adalah menu pilihan kamu',
        titleTextStyle: GoogleFonts.quicksand(fontWeight: FontWeight.bold),
        descTextStyle: GoogleFonts.quicksand(
          fontSize: 12.sp,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            controller.menu.length,
            (index) => InkWell(
              borderRadius: BorderRadius.circular(15.r),
              onTap: () {
                switch (index) {
                  case 0:
                    Get.toNamed(Routes.JADWAL);
                    break;
                  case 1:
                    Get.toNamed(Routes.BERITA);
                    break;
                  case 2:
                    Get.toNamed(Routes.E_KONSELING);
                    break;
                  case 3:
                    Get.toNamed(Routes.STATISTIK);
                    break;
                }
              },
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.w,
                      vertical: 5.h,
                    ),
                    width: 55.w,
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 4,
                          offset: Offset(0, 4),
                          color: Colors.grey,
                        )
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Image.asset(
                      controller.menu[index]["image"],
                      width: 45.w,
                    ),
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Text(
                    controller.menu[index]["title"],
                    style: GoogleFonts.quicksand(
                      color: Colors.black,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
