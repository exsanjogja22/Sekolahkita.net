import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:showcaseview/showcaseview.dart';
import '/app/config/app_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/app/routes/app_pages.dart';
import '../../../../config/app_colors.dart';
import '../../../../config/app_sisze.dart';
import '../../controllers/home_controller.dart';

class TopHomeWidget extends StatelessWidget {
  const TopHomeWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Obx(
      () => Stack(
        children: [
          SizedBox(
            height: 300.h,
          ),
          Container(
            padding: EdgeInsets.only(
                left: 15.w, right: 15.w, top: 15.h, bottom: 15.h),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: AppColors.gradientColors),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25.r),
                bottomRight: Radius.circular(25.r),
              ),
            ),
            height: 200.h,
            width: SizeConfig.screenWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Showcase(
                      key: controller.one,
                      title: 'Profil',
                      titleTextStyle:
                          GoogleFonts.quicksand(fontWeight: FontWeight.bold),
                      description: 'Klik disini untuk melihat profil',
                      descTextStyle: GoogleFonts.quicksand(
                        fontSize: 12.sp,
                      ),
                      child: InkWell(
                        onTap: () => Get.toNamed(Routes.AKUN_SAYA, arguments: [
                          controller.kelas.value.replaceAll("/", ""),
                        ]),
                        child: controller.photo.value != ""
                            ? controller.photo.value != "null"
                                ? CircleAvatar(
                                    radius: 28.r,
                                    backgroundColor: Colors.white,
                                    backgroundImage:
                                        NetworkImage(controller.photo.value),
                                  )
                                : CircleAvatar(
                                    radius: 28.r,
                                    backgroundColor: Colors.white,
                                    backgroundImage:
                                        const AssetImage(AppImage.profile),
                                  )
                            : CircleAvatar(
                                radius: 28.r,
                                backgroundColor: Colors.white,
                                backgroundImage:
                                    const AssetImage(AppImage.profile),
                              ),
                      ),
                    ),
                    Row(
                      children: [
                        Showcase(
                          key: controller.two,
                          title: 'Notifikasi',
                          titleTextStyle: GoogleFonts.quicksand(
                              fontWeight: FontWeight.bold),
                          description: 'Klik disini untuk melihat notifikasi',
                          descTextStyle: GoogleFonts.quicksand(
                            fontSize: 12.sp,
                          ),
                          child: Material(
                            borderRadius: BorderRadius.circular(10.r),
                            color: Colors.white.withOpacity(0.4),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(10.r),
                              onTap: () {
                                Get.toNamed(Routes.NOTIFIKASI);
                              },
                              child: Container(
                                height: 35.h,
                                width: 35.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Stack(
                                  children: [
                                    SizedBox(
                                      height: 35,
                                      width: 35,
                                      child: Icon(
                                        Icons.notifications_active,
                                        size: 20.h,
                                        color: Colors.white,
                                      ),
                                    ),
                                    if (controller.countNotif.value != 0)
                                      Positioned(
                                        right: 5,
                                        top: 5,
                                        child: ClipOval(
                                          child: Container(
                                            height: 15,
                                            width: 15,
                                            color: Colors.white,
                                            child: ClipOval(
                                              child: Container(
                                                height: 10,
                                                width: 10,
                                                color: Colors.red,
                                                child: Center(
                                                  child: Text(
                                                    controller.countNotif.value
                                                        .toString(),
                                                    style:
                                                        GoogleFonts.quicksand(
                                                            color: Colors.white,
                                                            fontSize: 10.sp),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                InkWell(
                  onTap: () => Get.toNamed(Routes.AKUN_SAYA, arguments: [
                    controller.kelas.value.replaceAll("/", ""),
                  ]),
                  child: RichText(
                    text: TextSpan(
                      text: "Hai, ",
                      style: GoogleFonts.quicksand(
                          color: Colors.grey[200], fontSize: 16.sp),
                      children: [
                        TextSpan(
                          text: controller.namaSiswa.value.toTitleCase(),
                          style: GoogleFonts.quicksand(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 16.sp,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => Get.toNamed(Routes.AKUN_SAYA, arguments: [
                    controller.kelas.value.replaceAll("/", ""),
                  ]),
                  child: Text(
                    '${controller.kelas.value} ${controller.nis}',
                    style: GoogleFonts.quicksand(
                        color: Colors.grey[200], fontSize: 12.sp),
                  ),
                ),
                SizedBox(
                  height: 14.h,
                ),
                Showcase(
                  key: controller.three,
                  title: 'Buat Postingan',
                  description: 'Klik disini untuk update status',
                  titleTextStyle:
                      GoogleFonts.quicksand(fontWeight: FontWeight.bold),
                  descTextStyle: GoogleFonts.quicksand(
                    fontSize: 12.sp,
                  ),
                  child: InkWell(
                    onTap: () => Get.toNamed(Routes.STATUS),
                    child: Container(
                      height: 40.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Image.asset(
                              AppImage.iconsSend,
                              width: 20.w,
                              height: 20.h,
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Text(
                              "Apa yang anda pikirkan?",
                              style: GoogleFonts.quicksand(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[400],
                                  fontSize: 12.sp),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 15.w, right: 15.w, top: 190.h),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            height: 100.h,
            width: double.infinity.w,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 38.r,
                        backgroundColor: AppColors.appColorGreenSoft2,
                        child: CircleAvatar(
                          radius: 35.r,
                          backgroundColor: Colors.white,
                          child: Obx(
                            () => Stack(
                              children: [
                                CircularPercentIndicator(
                                  radius: 32.0.r,
                                  lineWidth: 8.0.h,
                                  animation: true,
                                  percent: controller.alfaIC.value,
                                  progressColor: const Color(0xffEF5354),
                                  backgroundColor: Colors.transparent,
                                ),
                                CircularPercentIndicator(
                                  radius: 32.0.r,
                                  lineWidth: 8.0.h,
                                  animation: true,
                                  percent: controller.sakitIC.value,
                                  progressColor: const Color(0xffFCC800),
                                  backgroundColor: Colors.transparent,
                                ),
                                CircularPercentIndicator(
                                  radius: 32.0.r,
                                  lineWidth: 8.0.h,
                                  animation: true,
                                  percent: controller.izinIC.value,
                                  progressColor: const Color(0xffA0F3BA),
                                  backgroundColor: Colors.transparent,
                                ),
                                CircularPercentIndicator(
                                  radius: 32.0.r,
                                  lineWidth: 8.0.h,
                                  animation: true,
                                  percent: controller.masukIC.value,
                                  progressColor: const Color(0xff50C474),
                                  backgroundColor:
                                      const Color(0xff50C474).withOpacity(0.2),
                                  center: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 15.w,
                                          ),
                                          Text(
                                            "${controller.hari.toInt()}",
                                            style: GoogleFonts.quicksand(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.sp),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        'Hari Efektif',
                                        style: GoogleFonts.quicksand(
                                          color: Colors.black,
                                          fontSize: 6.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Keaktifan Presensi",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.quicksand(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 12.sp,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            DateFormat("MMMM yyyy", "id_ID")
                                .format(DateTime.now()),
                            style: GoogleFonts.quicksand(
                              color: Colors.black,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        AppImage.iconRiportPresensi0,
                                        height: 10.h,
                                        width: 10.w,
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Text(
                                        "${controller.masuk.toInt()} masuk",
                                        style: GoogleFonts.quicksand(
                                          fontSize: 10.sp,
                                          color: Colors.black54,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5.w,
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        AppImage.iconRiportPresensi1,
                                        height: 10.h,
                                        width: 10.w,
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Text(
                                        "${controller.izin.toInt()} Izin",
                                        style: GoogleFonts.quicksand(
                                          fontSize: 10.sp,
                                          color: Colors.black54,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        AppImage.iconRiportPresensi2,
                                        height: 10.h,
                                        width: 10.w,
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Text(
                                        "${controller.alfa.toInt()} Alfa",
                                        style: GoogleFonts.quicksand(
                                          fontSize: 10.sp,
                                          color: Colors.black54,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5.w,
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        AppImage.iconRiportPresensi3,
                                        height: 10.h,
                                        width: 10.w,
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Text(
                                        "${controller.alfa.toInt()} Sakit",
                                        style: GoogleFonts.quicksand(
                                          fontSize: 10.sp,
                                          color: Colors.black54,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
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
