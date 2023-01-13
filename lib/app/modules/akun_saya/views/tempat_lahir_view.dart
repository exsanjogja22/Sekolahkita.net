import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/app_colors.dart';
import '../controllers/tempat_lahir_controller.dart';

class TempatLahirView extends GetView<TempatLahirController> {
  const TempatLahirView(this.tempatLahir, {Key? key}) : super(key: key);
  final String? tempatLahir;
  @override
  Widget build(BuildContext context) {
    controller.tempatLahir.text = tempatLahir!;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.appBarColors,
        title: Text(
          'Ubah Tempat Lahir',
          style: GoogleFonts.quicksand(
            fontSize: 18.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              controller.updateProfil(context);
            },
            child: Text(
              "Ubah",
              style:
                  GoogleFonts.quicksand(color: Colors.white, fontSize: 14.sp),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            decoration: const BoxDecoration(color: Colors.white),
            child: TextField(
              controller: controller.tempatLahir,
              autofocus: true,
              keyboardType: TextInputType.name,
              style:
                  GoogleFonts.quicksand(color: Colors.black87, fontSize: 14.sp),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 10.w),
                helperStyle: GoogleFonts.quicksand(
                  color: Colors.black38,
                  fontSize: 12.sp,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
            child: Row(
              children: [
                Text(
                  "max 100 Kata",
                  style: GoogleFonts.quicksand(
                    color: Colors.grey,
                    fontSize: 12.sp,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
