import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '/app/config/app_image.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_sisze.dart';
import '../../../routes/app_pages.dart';
import '../controllers/status_controller.dart';

class StatusView extends GetView<StatusController> {
  const StatusView({Key? key}) : super(key: key);
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
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 150.h,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: AppColors.gradientColors),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                          right: 0,
                          child: Image.asset(
                            "assets/images/5145491_2.png",
                            height: 150.h,
                          )),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Colors.white,
                                  child: InkWell(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: Icon(
                                      Icons.arrow_back_rounded,
                                      size: 15.w,
                                      color: AppColors.appGreenlight,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Status Siswa",
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
                                  child: const Icon(
                                    Icons.help,
                                    color: AppColors.appColorWhite,
                                    size: 20,
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
                Positioned(
                  left: 0,
                  right: 0,
                  top: 75.h,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Row(
                      children: [
                        Obx(() => Stack(
                              children: [
                                SizedBox(
                                  height: 70.h,
                                ),
                                if (controller.photo.value == "")
                                  CircleAvatar(
                                    radius: 25.r,
                                    backgroundColor: AppColors.appColorWhite,
                                    backgroundImage:
                                        const AssetImage(AppImage.profile),
                                  ),
                                if (controller.photo.value != "")
                                  CircleAvatar(
                                    radius: 25.r,
                                    backgroundColor: AppColors.appColorWhite,
                                    backgroundImage:
                                        NetworkImage(controller.photo.value),
                                  ),
                                Positioned(
                                  top: 40.h,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 5.h),
                                    width: 60.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.r),
                                      color: const Color(0xffFCC800),
                                    ),
                                    child: Text(
                                      "Siswa",
                                      style: GoogleFonts.quicksand(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                        SizedBox(
                          width: 10.w,
                        ),
                        Expanded(
                            child: InkWell(
                          onTap: () => Get.toNamed(Routes.ADD_SATATUS),
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
                                      color: Colors.grey[400],
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15.h,
            ),
            Expanded(
              child: Obx(
                () {
                  return SmartRefresher(
                    controller: controller.refreshController,
                    onRefresh: controller.onRefresh,
                    onLoading: controller.onLoading,
                    enablePullDown: true,
                    enablePullUp: true,
                    child: controller.listStatus.isNotEmpty
                        ? ListView.builder(
                            itemCount: controller.listStatus.length,
                            itemBuilder: (context, index) {
                              final data = controller.listStatus[index];
                              return Padding(
                                padding: EdgeInsets.only(
                                    bottom: 10.h, left: 15.w, right: 15.w),
                                child: Material(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.r),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(10.r),
                                    onTap: () => Get.toNamed(
                                        Routes.DETAIL_STATUS,
                                        arguments: [data]),
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10.h),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.r)),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.w),
                                            child: Row(
                                              children: [
                                                CircleAvatar(
                                                  radius: 20.r,
                                                  backgroundColor:
                                                      AppColors.appColorWhite,
                                                  backgroundImage:
                                                      NetworkImage(data.img!),
                                                ),
                                                SizedBox(
                                                  width: 10.w,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                  data.nama!
                                                                      .toTitleCase(),
                                                                  style: GoogleFonts
                                                                      .quicksand(
                                                                    color: const Color(
                                                                        0xff505764),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        11.sp,
                                                                  ),
                                                                ),
                                                                if (data.tipe ==
                                                                    "pengumuman")
                                                                  SizedBox(
                                                                    width: 10.w,
                                                                  ),
                                                                if (data.tipe ==
                                                                    "pengumuman")
                                                                  Image.asset(
                                                                    "assets/icons/check.png",
                                                                    height: 15,
                                                                    width: 15,
                                                                  )
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              "${DateFormat("d MMMM yyyy, hh:mm", "id_ID").format(data.tanggal!)} ",
                                                              style: GoogleFonts.quicksand(
                                                                  color: const Color(
                                                                      0xffD2D3D9),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 10),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    showModalBottomSheet(
                                                      context: context,
                                                      shape: const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.vertical(
                                                                  top: Radius
                                                                      .circular(
                                                                          10))),
                                                      builder: (context) =>
                                                          const PopupPengaturan(),
                                                    );
                                                  },
                                                  child: const Icon(
                                                    Icons.more_vert,
                                                    color: Colors.grey,
                                                    size: 20,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          if (data.judul != "null")
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.w),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                      child: Text(
                                                    data.judul!,
                                                    style:
                                                        GoogleFonts.quicksand(
                                                      fontSize: 10.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: AppColors
                                                          .appColorBlack,
                                                    ),
                                                  )),
                                                ],
                                              ),
                                            ),
                                          if (data.judul != "null")
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                          Container(
                                            width: double.infinity,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 10.w),
                                            child: HtmlWidget(
                                              data.detail!
                                                  .replaceAll("null", ""),
                                              textStyle: GoogleFonts.quicksand(
                                                color: const Color(0xff676767),
                                                fontSize: 10.sp,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Container(
                                            height: 1.h,
                                            width: double.infinity,
                                            color: Colors.grey.withOpacity(0.4),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.w,
                                                vertical: 10.h),
                                            width: double.infinity,
                                            child: Row(
                                              children: [
                                                Row(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Image.asset(
                                                          AppImage.iconLike,
                                                          height: 10.h,
                                                          width: 10.w,
                                                        ),
                                                        SizedBox(
                                                          width: 5.w,
                                                        ),
                                                        Text(
                                                          "0 like",
                                                          style: GoogleFonts
                                                              .quicksand(
                                                                  fontSize:
                                                                      10.sp,
                                                                  color: Colors
                                                                      .grey),
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      width: 10.w,
                                                    ),
                                                    InkWell(
                                                      child: Row(
                                                        children: [
                                                          Image.asset(
                                                            AppImage
                                                                .iconKomentar,
                                                            height: 10.h,
                                                            width: 10.w,
                                                          ),
                                                          SizedBox(
                                                            width: 5.w,
                                                          ),
                                                          Text(
                                                            data.komencount
                                                                .toString(),
                                                            style: GoogleFonts
                                                                .quicksand(
                                                                    fontSize:
                                                                        10.sp,
                                                                    color: Colors
                                                                        .grey),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        : Center(
                            child: SizedBox(
                              height: 100.h,
                              width: 100.w,
                              child: Lottie.asset(
                                "assets/lotties/loading.json",
                              ),
                            ),
                          ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PopupPengaturan extends StatelessWidget {
  const PopupPengaturan({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180.h,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Pengaturan Post",
                  style: GoogleFonts.quicksand(
                    color: const Color(0xff155A5F),
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),
                ),
                InkWell(
                  onTap: () => Get.back(),
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: const Color(0xffF97276).withOpacity(0.6),
                    child: Icon(
                      Icons.close,
                      color: Colors.red,
                      size: 15.w,
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey)),
            child: ListTile(
              onTap: () {
                Get.back();
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(10.r))),
                  builder: (context) => DraggableScrollableSheet(
                    initialChildSize: 0.4,
                    maxChildSize: 0.8,
                    minChildSize: 0.32,
                    expand: false,
                    builder: (context, scrollController) =>
                        SingleChildScrollView(
                            controller: scrollController,
                            child: Column(children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 10.h),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Laporkan",
                                      style: GoogleFonts.quicksand(
                                        color: const Color(0xff155A5F),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () => Get.back(),
                                      child: CircleAvatar(
                                        radius: 10,
                                        backgroundColor: const Color(0xffF97276)
                                            .withOpacity(0.6),
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.red,
                                          size: 15.w,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 15.w, vertical: 5.h),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.grey)),
                                child: ListTile(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.r)),
                                        title: Text(
                                          'Info',
                                          style: GoogleFonts.quicksand(
                                              color: Colors.black,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        content: Text(
                                          'Anda yakin ingin mengajukan pelaporan ?',
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
                                              Get.back();
                                              Get.back();
                                              Get.snackbar("Berhasil",
                                                  "Laporan Anda akan direspon dalam 2x 24 jam",
                                                  snackPosition:
                                                      SnackPosition.BOTTOM,
                                                  colorText:
                                                      AppColors.appGreenlight,
                                                  backgroundColor: AppColors
                                                      .appGreenlight
                                                      .withOpacity(0.4));
                                            },
                                            child: Text(
                                              'OK',
                                              style: GoogleFonts.quicksand(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  title: Text(
                                    "Menganding unsur Suku, Agama, Ras, dan Antargolongan",
                                    style: GoogleFonts.quicksand(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 15.h, vertical: 5.w),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.grey)),
                                child: ListTile(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.r)),
                                        title: Text(
                                          'Info',
                                          style: GoogleFonts.quicksand(
                                              color: Colors.black,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        content: Text(
                                          'Anda yakin ingin mengajukan pelaporan ?',
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
                                              Get.back();
                                              Get.back();
                                              Get.snackbar("Berhasil",
                                                  "Laporan Anda akan direspon dalam 2x 24 jam",
                                                  snackPosition:
                                                      SnackPosition.BOTTOM,
                                                  colorText:
                                                      AppColors.appGreenlight,
                                                  backgroundColor: AppColors
                                                      .appGreenlight
                                                      .withOpacity(0.4));
                                            },
                                            child: Text(
                                              'OK',
                                              style: GoogleFonts.quicksand(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  title: Text(
                                    "Mengandiung unsur HOAX",
                                    style: GoogleFonts.quicksand(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 15.w, vertical: 5.h),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.grey)),
                                child: ListTile(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.r)),
                                        title: Text(
                                          'Info',
                                          style: GoogleFonts.quicksand(
                                              color: Colors.black,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        content: Text(
                                          'Anda yakin ingin mengajukan pelaporan ?',
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
                                              Get.back();
                                              Get.back();
                                              Get.snackbar("Berhasil",
                                                  "Laporan Anda akan direspon dalam 2x 24 jam",
                                                  snackPosition:
                                                      SnackPosition.BOTTOM,
                                                  colorText:
                                                      AppColors.appGreenlight,
                                                  backgroundColor: AppColors
                                                      .appGreenlight
                                                      .withOpacity(0.4));
                                            },
                                            child: Text(
                                              'OK',
                                              style: GoogleFonts.quicksand(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  title: Text(
                                    "Melanggar penulisan postingan karena melanggar aturan",
                                    style: GoogleFonts.quicksand(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 15.w, vertical: 5.h),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.grey)),
                                child: ListTile(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.r)),
                                        title: Text(
                                          'Info',
                                          style: GoogleFonts.quicksand(
                                              color: Colors.black,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        content: Text(
                                          'Anda yakin ingin mengajukan pelaporan ?',
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
                                              Get.back();
                                              Get.back();
                                              Get.snackbar("Berhasil",
                                                  "Laporan Anda akan direspon dalam 2x 24 jam",
                                                  snackPosition:
                                                      SnackPosition.BOTTOM,
                                                  colorText:
                                                      AppColors.appGreenlight,
                                                  backgroundColor: AppColors
                                                      .appGreenlight
                                                      .withOpacity(0.4));
                                            },
                                            child: Text(
                                              'OK',
                                              style: GoogleFonts.quicksand(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  title: Text(
                                    "Blokir user ini",
                                    style: GoogleFonts.quicksand(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )
                            ])),
                  ),
                );
              },
              leading: const Icon(
                Icons.flag_rounded,
                color: Colors.grey,
                size: 25,
              ),
              title: Text(
                "Laporkan",
                style: GoogleFonts.quicksand(
                    fontSize: 12.sp, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey)),
            child: ListTile(
              onTap: () {
                Get.back();
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(10.r))),
                  builder: (context) => DraggableScrollableSheet(
                    initialChildSize: 0.4,
                    maxChildSize: 0.8,
                    minChildSize: 0.32,
                    expand: false,
                    builder: (context, scrollController) =>
                        SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 10.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Laporkan ke sekolah",
                                  style: GoogleFonts.quicksand(
                                    color: const Color(0xff155A5F),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.sp,
                                  ),
                                ),
                                InkWell(
                                  onTap: () => Get.back(),
                                  child: CircleAvatar(
                                    radius: 10,
                                    backgroundColor: const Color(0xffF97276)
                                        .withOpacity(0.6),
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.red,
                                      size: 15.w,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 15.w, vertical: 5.h),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(color: Colors.grey)),
                            child: ListTile(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.r)),
                                    title: Text(
                                      'Info',
                                      style: GoogleFonts.quicksand(
                                          color: Colors.black,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    content: Text(
                                      'Anda yakin ingin mengajukan pelaporan ?',
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
                                          Get.back();
                                          Get.back();
                                          Get.snackbar("Berhasil",
                                              "Laporan Anda akan direspon dalam 2x 24 jam",
                                              snackPosition:
                                                  SnackPosition.BOTTOM,
                                              colorText:
                                                  AppColors.appGreenlight,
                                              backgroundColor: AppColors
                                                  .appGreenlight
                                                  .withOpacity(0.4));
                                        },
                                        child: Text(
                                          'OK',
                                          style: GoogleFonts.quicksand(),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              title: Text(
                                "Menganding unsur kekerasan, obat-obat terlarang dan sex bebas",
                                style: GoogleFonts.quicksand(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 15.w, vertical: 5.h),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(color: Colors.grey)),
                            child: ListTile(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.r)),
                                    title: Text(
                                      'Info',
                                      style: GoogleFonts.quicksand(
                                          color: Colors.black,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    content: Text(
                                      'Anda yakin ingin mengajukan pelaporan ?',
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
                                          Get.back();
                                          Get.back();
                                          Get.snackbar("Berhasil",
                                              "Laporan Anda akan direspon dalam 2x 24 jam",
                                              snackPosition:
                                                  SnackPosition.BOTTOM,
                                              colorText:
                                                  AppColors.appGreenlight,
                                              backgroundColor: AppColors
                                                  .appGreenlight
                                                  .withOpacity(0.4));
                                        },
                                        child: Text(
                                          'OK',
                                          style: GoogleFonts.quicksand(),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              title: Text(
                                "Mengandiung unsur kata tidak pantas",
                                style: GoogleFonts.quicksand(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 15.w, vertical: 5.h),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(color: Colors.grey)),
                            child: ListTile(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.r)),
                                    title: Text(
                                      'Info',
                                      style: GoogleFonts.quicksand(
                                          color: Colors.black,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    content: Text(
                                      'Anda yakin ingin mengajukan pelaporan ?',
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
                                          Get.back();
                                          Get.back();
                                          Get.snackbar("Berhasil",
                                              "Laporan Anda akan direspon dalam 2x 24 jam",
                                              snackPosition:
                                                  SnackPosition.BOTTOM,
                                              colorText:
                                                  AppColors.appGreenlight,
                                              backgroundColor: AppColors
                                                  .appGreenlight
                                                  .withOpacity(0.4));
                                        },
                                        child: Text(
                                          'OK',
                                          style: GoogleFonts.quicksand(),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              title: Text(
                                "Mengandung unsur bullying",
                                style: GoogleFonts.quicksand(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              leading: const Icon(
                Icons.flag_rounded,
                color: Colors.grey,
                size: 25,
              ),
              title: Text(
                "Laporkan ke sekolah",
                style: GoogleFonts.quicksand(
                    fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
          ),
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
