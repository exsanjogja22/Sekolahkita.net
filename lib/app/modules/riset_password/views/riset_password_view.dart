import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/app_colors.dart';
import '../controllers/riset_password_controller.dart';

class RisetPasswordView extends GetView<RisetPasswordController> {
  const RisetPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appGreenlight,
        title: Text(
          "Ubah Password",
          style: GoogleFonts.quicksand(
            fontSize: 16.sp,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              controller.postNewPassword(context);
            },
            child: Text(
              "Ubah",
              style:
                  GoogleFonts.quicksand(color: Colors.white, fontSize: 14.sp),
            ),
          )
        ],
      ),
      body: Obx(
        () => Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              alignment: Alignment.centerLeft,
              decoration: const BoxDecoration(color: Colors.white),
              child: TextField(
                controller: controller.newPassword,
                autofocus: true,
                keyboardType: TextInputType.visiblePassword,
                style: GoogleFonts.quicksand(
                    color: Colors.black87, fontSize: 14.sp),
                obscureText: controller.isObscure.value,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: controller.isObscure.value
                        ? const Icon(Icons.visibility_off,
                            size: 20, color: Colors.grey)
                        : const Icon(
                            Icons.visibility,
                            size: 20,
                            color: Color(0xff08B197),
                          ),
                    onPressed: () {
                      controller.isObscure.value = !controller.isObscure.value;
                    },
                  ),
                  hintText: "New Password",
                  border: InputBorder.none,
                  helperStyle: GoogleFonts.quicksand(
                    color: Colors.black38,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              alignment: Alignment.centerLeft,
              decoration: const BoxDecoration(color: Colors.white),
              child: TextField(
                onEditingComplete: () {
                  controller.postNewPassword(context);
                },
                controller: controller.retypePassword,
                autofocus: true,
                keyboardType: TextInputType.visiblePassword,
                style: GoogleFonts.quicksand(
                    color: Colors.black87, fontSize: 14.sp),
                obscureText: controller.isObscure.value,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: controller.isObscure.value
                        ? const Icon(Icons.visibility_off,
                            size: 20, color: Colors.grey)
                        : const Icon(
                            Icons.visibility,
                            size: 20,
                            color: Color(0xff08B197),
                          ),
                    onPressed: () {
                      controller.isObscure.value = !controller.isObscure.value;
                    },
                  ),
                  hintText: "Konfirmasi Password",
                  border: InputBorder.none,
                  helperStyle: GoogleFonts.quicksand(
                    color: Colors.black38,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
