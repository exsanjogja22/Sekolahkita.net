import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:smkn1contoh/app/config/app_colors.dart';

import '../../../config/app_sisze.dart';
import '../../../routes/app_pages.dart';
import '../controllers/presensi_controller.dart';
import '../widget/presensi/presensi_harian_widget.dart';
import '../widget/presensi/presensi_kegitan_widget.dart';
import '../widget/presensi/presensi_riport_widget.dart';

class PresensiView extends GetView<PresensiController> {
  const PresensiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: AppColors.appBgroudColors,
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0.0),
          child: AppBar(
            backgroundColor: AppColors.appGreenlight,
            elevation: 0,
          ),
        ),
        body: ShowCaseWidget(
          onComplete: (index, key) {
            if (index == 4) {
              controller.skipsCase1();
              Get.toNamed(Routes.MAP_HELPER, arguments: ["masuk"]);
            }
          },
          blurValue: 1,
          builder: Builder(builder: (context) {
            controller.myContext = context;
            return SizedBox(
              width: SizeConfig.screenWidth,
              child: Obx(
                () => Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: 150.h,
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: 15.w, right: 15.w, top: 15.h, bottom: 15.h),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                colors: AppColors.gradientColors),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10.r),
                              bottomRight: Radius.circular(10.r),
                            ),
                          ),
                          height: 120.h,
                          width: SizeConfig.screenWidth,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                "Dashboard E-Presensi",
                                style: GoogleFonts.quicksand(
                                  fontSize: 18.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: 15.w, right: 15.w, top: 80.h),
                          width: SizeConfig.screenWidth,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 4),
                              ),
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Showcase(
                            key: controller.one,
                            title: 'Menu Presensi',
                            titleTextStyle: GoogleFonts.quicksand(
                                fontWeight: FontWeight.bold),
                            description:
                                'Presensi harian, Presensi Kegiatan, Report Presensi',
                            descTextStyle: GoogleFonts.quicksand(
                              fontSize: 12.sp,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(
                                controller.menu.length,
                                (index) => Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      controller.ontapKonten(index);
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          height: 8.h,
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10.w),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.w, vertical: 10.h),
                                          width: 60.w,
                                          height: 60.h,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50.r),
                                            color:
                                                controller.selectMenu.value ==
                                                        index
                                                    ? AppColors.appGreenlight
                                                    : Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                  blurRadius: 4,
                                                  color: Colors.black
                                                      .withOpacity(0.1),
                                                  offset: const Offset(0, 2))
                                            ],
                                          ),
                                          child: Image.asset(
                                            controller.menu[index]["icon"],
                                            width: 40.w,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Text(
                                          controller.menu[index]["title"],
                                          style: GoogleFonts.quicksand(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w700,
                                              color:
                                                  controller.selectMenu.value ==
                                                          index
                                                      ? AppColors.appColorBlack
                                                      : Colors.grey),
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        if (controller.selectMenu.value ==
                                            index)
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 5.w),
                                                  height: 3,
                                                  color:
                                                      AppColors.appGreenlight,
                                                ),
                                              ),
                                            ],
                                          )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: SizedBox(
                        height: double.infinity,
                        width: double.infinity,
                        child: PageView(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: controller.pageControl,
                          children: [
                            PresensiHarianWidget(controller),
                            PresensiKegitanWidget(controller),
                            RiportPresensiWidget(
                              controller: controller,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ));
  }
}
