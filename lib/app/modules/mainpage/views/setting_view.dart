import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_image.dart';
import '../../../config/app_sisze.dart';
import '../../../data/providers/network/repository/auth_repositori.dart';
import '../../../routes/app_pages.dart';
import '../controllers/setting_controller.dart';

class SettingView extends GetView<SettingController> {
  const SettingView({Key? key}) : super(key: key);
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
      body: SizedBox(
        width: SizeConfig.screenWidth,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: 125.h,
                    width: double.infinity.w,
                  ),
                  Container(
                    padding:
                        EdgeInsets.only(left: 15.w, right: 15.w, bottom: 15.h),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: AppColors.gradientColors),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25.r),
                        bottomRight: Radius.circular(25.r),
                      ),
                    ),
                    height: 100.h,
                    width: SizeConfig.screenWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Pengaturan",
                          style: GoogleFonts.quicksand(
                              color: AppColors.appColorWhite,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    margin: EdgeInsets.only(
                      left: 15.w,
                      right: 15.w,
                      top: 70.h,
                    ),
                    height: 100.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.7),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        )
                      ],
                    ),
                    child: Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            child: controller.photo.value != ""
                                ? controller.photo.value != "null"
                                    ? CircleAvatar(
                                        radius: 30.r,
                                        backgroundColor: Colors.white,
                                        backgroundImage: NetworkImage(
                                            controller.photo.value),
                                      )
                                    : CircleAvatar(
                                        radius: 30.r,
                                        backgroundColor: Colors.white,
                                        backgroundImage:
                                            const AssetImage(AppImage.profile),
                                      )
                                : CircleAvatar(
                                    radius: 30.r,
                                    backgroundColor: Colors.white,
                                    backgroundImage:
                                        const AssetImage(AppImage.profile),
                                  ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      controller.namaSiswa.value.toTitleCase(),
                                      style: GoogleFonts.quicksand(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.appColorBlack),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '${controller.kelas.value} ${controller.nis}',
                                      style: GoogleFonts.quicksand(
                                        fontSize: 15.sp,
                                        color: AppColors.appColorBlack,
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
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                width: double.infinity,
                child: Column(
                  children: [
                    SizedBox(
                      height: 15.h,
                    ),
                    Row(
                      children: [
                        Text(
                          "Pengaturan Akun",
                          style: GoogleFonts.quicksand(
                            fontSize: 14.sp,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    ListTile(
                      minLeadingWidth: 0,
                      onTap: () {
                        Get.toNamed(Routes.AKUN_SAYA, arguments: [
                          controller.kelas.value.replaceAll("/", "")
                        ]);
                      },
                      title: Text(
                        "Akun Saya",
                        style: GoogleFonts.quicksand(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      leading: Image.asset(
                        "assets/icons/setings/ic_akun_saya.png",
                        width: 20.w,
                        height: 20.h,
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 15.w,
                        color: AppColors.appColorBlack,
                      ),
                    ),
                    ListTile(
                      minLeadingWidth: 0,
                      onTap: () {
                        Get.toNamed(Routes.RISET_PASSWORD);
                      },
                      title: Text(
                        "Ubah Password",
                        style: GoogleFonts.quicksand(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      leading: Image.asset(
                        "assets/icons/setings/ic_ub_password.png",
                        width: 20.w,
                        height: 20.h,
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                        color: AppColors.appColorBlack,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        Text(
                          "Kontak Bantuan",
                          style: GoogleFonts.quicksand(
                              fontSize: 14.sp,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    ListTile(
                      minLeadingWidth: 0,
                      onTap: () {
                        controller.launchURL("mailto:sekolahkitanet@gmail.com");
                      },
                      title: Text(
                        "Email Support",
                        style: GoogleFonts.quicksand(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      leading: Image.asset(
                        "assets/icons/setings/ic_email.png",
                        width: 20.w,
                        height: 20.h,
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 15.w,
                        color: AppColors.appColorBlack,
                      ),
                    ),
                    ListTile(
                      minLeadingWidth: 0,
                      onTap: () {
                        controller.launchURL(
                            "https://api.whatsapp.com/send/?phone=6281321214107&text&type=phone_number&app_absent=0");
                      },
                      title: Text(
                        "Whatsapp Support",
                        style: GoogleFonts.quicksand(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      leading: Image.asset(
                        "assets/icons/setings/ic_wa.png",
                        width: 20.w,
                        height: 20.h,
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 15.w,
                        color: AppColors.appColorBlack,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        Text(
                          "Aplikasi",
                          style: GoogleFonts.quicksand(
                              fontSize: 14.sp,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    ListTile(
                      minLeadingWidth: 0,
                      onTap: () {
                        controller.launchURL("https://sekolahkita.net/");
                      },
                      title: Text(
                        "About Me",
                        style: GoogleFonts.quicksand(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      leading: Image.asset(
                        "assets/icons/setings/ic_aboutme.png",
                        width: 20.w,
                        height: 20.h,
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 15.w,
                        color: AppColors.appColorBlack,
                      ),
                    ),
                    ListTile(
                      minLeadingWidth: 0,
                      onTap: () {
                        Get.toNamed(Routes.KEBIJAKAN_PRIVASI);
                      },
                      title: Text(
                        "Kebijakan Privasi",
                        style: GoogleFonts.quicksand(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      leading: Image.asset(
                        "assets/icons/setings/ic_protect.png",
                        width: 20.w,
                        height: 20.h,
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 15.w,
                        color: AppColors.appColorBlack,
                      ),
                    ),
                    ListTile(
                      minLeadingWidth: 0,
                      onTap: () {
                        Get.toNamed(Routes.KEBIJAKAN_PRIVASI);
                      },
                      title: Text(
                        "Syarat & Ketentuan",
                        style: GoogleFonts.quicksand(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      leading: Image.asset(
                        "assets/icons/setings/ic_syarat.png",
                        width: 20.w,
                        height: 20.h,
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 15.w,
                        color: AppColors.appColorBlack,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    ListTile(
                      minLeadingWidth: 0,
                      onTap: () => ApiAuth().deleteToken(),
                      title: Text(
                        "Log Out",
                        style: GoogleFonts.quicksand(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      leading: Image.asset(
                        "assets/icons/setings/ic_logout.png",
                        width: 20.w,
                        height: 20.h,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
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
