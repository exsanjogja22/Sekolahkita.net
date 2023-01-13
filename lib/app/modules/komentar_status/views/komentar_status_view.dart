import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_image.dart';
import '../../../data/models/status/status_model.dart';
import '../controllers/komentar_status_controller.dart';

class KomentarStatusView extends GetView<KomentarStatusController> {
  const KomentarStatusView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final data = Get.arguments[0] as DataStatus;
    return Scaffold(
      floatingActionButton: Container(
        margin: EdgeInsets.symmetric(horizontal: 15.w),
        width: double.infinity,
        height: 40.h,
        child: ElevatedButton(
          onPressed: () {
            controller.postDataKomentar(data.id!.toString(), data.tipe!);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.appGreenlight,
          ),
          child: Text(
            "Kirim",
            style: GoogleFonts.quicksand(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.appColorWhite),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: AppColors.appBgroudColors,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0.h),
        child: AppBar(
          backgroundColor: AppColors.appGreenlight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(25.r),
            ),
          ),
          title: Text(
            'Tambah Komentar',
            style: GoogleFonts.quicksand(
              color: AppColors.appColorWhite,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.all(13),
            child: CircleAvatar(
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
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20.r,
                          backgroundColor: AppColors.appColorWhite,
                          backgroundImage: NetworkImage(data.img!),
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
                                    child: Row(
                                      children: [
                                        Text(
                                          data.nama!,
                                          style: GoogleFonts.quicksand(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10.sp,
                                          ),
                                        ),
                                        if (data.tipe == "pengumuman")
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                        if (data.tipe == "pengumuman")
                                          Image.asset(
                                            "assets/icons/check.png",
                                            height: 15.h,
                                            width: 15.w,
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
                                      "${DateFormat("d MMMM yyyy, hh:mm Wib ", "id_ID").format(data.tanggal!)} ",
                                      style: GoogleFonts.quicksand(
                                          color: Colors.grey, fontSize: 10),
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
                  SizedBox(
                    height: 10.h,
                  ),
                  if (data.judul != "null")
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                            data.judul!,
                            style: GoogleFonts.quicksand(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.appColorBlack,
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
                    margin: EdgeInsets.symmetric(horizontal: 10.w),
                    child: HtmlWidget(
                      data.detail!.replaceAll("null", ""),
                      textStyle: GoogleFonts.quicksand(
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
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
                                  style: GoogleFonts.quicksand(
                                      fontSize: 10.sp, color: Colors.grey),
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
                                    AppImage.iconKomentar,
                                    height: 10.h,
                                    width: 10.w,
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                    data.komencount.toString(),
                                    style: GoogleFonts.quicksand(
                                        fontSize: 10.sp, color: Colors.grey),
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
            SizedBox(
              height: 10.h,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15.w),
              width: double.infinity,
              child: CupertinoTextField(
                controller: controller.text,
                autofocus: true,
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                placeholder: 'Tulis Komentar Anda ....',
                maxLines: 8,
                placeholderStyle:
                    GoogleFonts.quicksand(color: Colors.grey, fontSize: 12),
                style: GoogleFonts.quicksand(color: Colors.black, fontSize: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
