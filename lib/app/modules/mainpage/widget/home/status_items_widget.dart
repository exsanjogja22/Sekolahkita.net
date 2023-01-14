import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../config/app_colors.dart';
import '../../../mainpage/controllers/home_controller.dart';
import '../../../../config/app_image.dart';
import '../../../../data/models/status/status_model.dart';
import '../../../../routes/app_pages.dart';

class StatusWidget extends StatelessWidget {
  const StatusWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DataStatus>?>(
      future: controller.initStatus!,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data!;
          return Container(
            margin: EdgeInsets.only(left: 15.w),
            height: 170.h,
            width: double.infinity,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: data.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => Get.toNamed(Routes.DETAIL_STATUS,
                      arguments: [data[index]]),
                  child: Container(
                    margin: EdgeInsets.only(right: 10.w, left: 2, bottom: 2.h),
                    padding: EdgeInsets.only(top: 10.h),
                    width: 270.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 15.r,
                                backgroundColor: Colors.white,
                                backgroundImage: NetworkImage(
                                  data[index].img!,
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            data[index].nama!.toTitleCase(),
                                            style: GoogleFonts.quicksand(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 11.sp,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "${DateFormat("d MMMM yyyy, hh:mm", "id_ID").format(data[index].tanggal!)} ",
                                            style: GoogleFonts.quicksand(
                                                color: Colors.black54,
                                                fontWeight: FontWeight.bold,
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
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(10))),
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
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: SizedBox(
                              child: Text(
                                data[index].detail!,
                                style: GoogleFonts.quicksand(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(left: 15.w, top: 3.h, bottom: 5),
                          child: Row(
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    AppImage.iconLike,
                                    height: 10.h,
                                    width: 10.w,
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                    "0",
                                    style: GoogleFonts.quicksand(
                                        color: Colors.black, fontSize: 10.sp),
                                  )
                                ],
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    AppImage.iconKomentar,
                                    height: 10.h,
                                    width: 10.w,
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                    data[index].komencount!.toString(),
                                    style: GoogleFonts.quicksand(
                                      color: Colors.black,
                                      fontSize: 10.sp,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }
        return const SizedBox();
      },
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
