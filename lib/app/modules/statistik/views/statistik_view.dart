import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_sisze.dart';
import '../../../data/models/profil_model.dart';
import '../controllers/statistik_controller.dart';
import '../widget/aktifitas_belajar_widget.dart';
import '../widget/point_pelanggaran_widget.dart';

class StatistikView extends GetView<StatistikController> {
  const StatistikView({Key? key}) : super(key: key);
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
      body: FutureBuilder<String?>(
          future: controller.initGetKelasAktif,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SizedBox(
                width: SizeConfig.screenWidth,
                child: Obx(
                  () => Column(
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            height: 160.h,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            width: double.infinity,
                            height: 120.h,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  colors: AppColors.gradientColors),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Get.back();
                                      },
                                      child: Icon(
                                        Icons.arrow_back,
                                        color: AppColors.appColorWhite,
                                        size: 20.w,
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Statistik Kamu",
                                            style: GoogleFonts.quicksand(
                                                color: AppColors.appColorWhite,
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {},
                                      child: Icon(
                                        Icons.help,
                                        color: AppColors.appColorWhite,
                                        size: 20.w,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            top: 80.h,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: List.generate(
                                  controller.menu.length,
                                  (index) => InkWell(
                                    onTap: () {
                                      controller.selectedMenu.value = index;
                                    },
                                    child: Container(
                                      height: 80.h,
                                      width: 140.w,
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              blurRadius: 4,
                                              offset: const Offset(2, 2),
                                              color:
                                                  Colors.black.withOpacity(0.2))
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(15.r),
                                        color: controller.selectedMenu.value ==
                                                index
                                            ? index == 0
                                                ? const Color(0xff6C99F6)
                                                : const Color(0xffFFD83E)
                                            : Colors.white,
                                      ),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            top: 15.h,
                                            left: 10.w,
                                            child: Container(
                                              height: 50.h,
                                              width: 50.w,
                                              decoration: BoxDecoration(
                                                color: controller.selectedMenu
                                                            .value ==
                                                        index
                                                    ? Colors.white
                                                    : index == 0
                                                        ? const Color(
                                                            0xff6C99F6)
                                                        : const Color(
                                                            0xffFFD83E),
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 47.w,
                                            top: 16.h,
                                            child: Container(
                                              height: 15.h,
                                              width: 55.w,
                                              decoration: BoxDecoration(
                                                color: const Color(0xffF97276),
                                                borderRadius:
                                                    BorderRadius.circular(3.r),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Statistik",
                                                  style: GoogleFonts.quicksand(
                                                    fontSize: 10.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 9,
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  controller.menu[index]
                                                      ["image"]!,
                                                  height: 66.h,
                                                  width: 66.w,
                                                ),
                                                Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    Text(
                                                      controller.menu[index]
                                                          ["title"]!,
                                                      style:
                                                          GoogleFonts.quicksand(
                                                        fontSize: 10.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: controller
                                                                    .selectedMenu
                                                                    .value ==
                                                                index
                                                            ? Colors.white
                                                            : index == 0
                                                                ? const Color(
                                                                    0xff6C99F6)
                                                                : const Color(
                                                                    0xffFCC800),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ).toList(),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      FutureBuilder<Biodata?>(
                          future: controller.initGetProfil,
                          builder: (context, snapshot1) {
                            if (snapshot1.hasData) {
                              return Container(
                                margin: EdgeInsets.symmetric(horizontal: 15.w),
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                height: 60.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 40.h,
                                      width: 40.w,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              snapshot1.data!.photo!),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  snapshot1.data!.namaSiswa!
                                                      .toTitleCase(),
                                                  style: GoogleFonts.quicksand(
                                                    fontSize: 10.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black
                                                        .withOpacity(0.7),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 3.h,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  snapshot1.data!.nis!,
                                                  style: GoogleFonts.quicksand(
                                                    fontSize: 10.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black
                                                        .withOpacity(0.7),
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.w, vertical: 4.h),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Colors.grey.withOpacity(0.2),
                                        ),
                                      ),
                                      child: Text(
                                        snapshot.data!,
                                        style: GoogleFonts.quicksand(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 10,
                                          color: const Color(0xffF97276),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }
                            return const SizedBox();
                          }),
                      SizedBox(
                        height: 15.h,
                      ),
                      Expanded(
                        child: GetBuilder<StatistikController>(
                          builder: (_) {
                            if (controller.selectedMenu.value == 0) {
                              return AktifitasBelajar(
                                kelas: snapshot.data,
                              );
                            } else {
                              return PointPelangaran(
                                controller: controller,
                              );
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
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
          }),
    );
  }
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}
