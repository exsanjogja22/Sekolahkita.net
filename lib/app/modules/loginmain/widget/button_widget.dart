import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/app_colors.dart';
import '../controllers/loginmain_controller.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final LoginmainController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20.h,
        ),
        SizedBox(
            width: double.infinity,
            height: 50.h,
            child: Obx(
              () => ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff08B197),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r)
                  )
                ),
                onPressed: () {
                  if (controller.isChecked.isTrue) {
                    if (controller.isLoading.isFalse) {
                      controller.postData();
                    }
                  } else {
                    CoolAlert.show(
                      context: context,
                      type: CoolAlertType.error,
                      title: "Peringatan",
                      text:
                          "Anda belum menyetujui Kebijakan Privasi dan Ketentuan Layanan",
                      confirmBtnTextStyle: GoogleFonts.quicksand(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      onConfirmBtnTap: () async {
                        Get.back();
                      },
                    );
                  }
                },
                child: controller.isLoading.isFalse
                    ? Text(
                        'Sign in',
                        style: GoogleFonts.quicksand(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.appColorWhite,
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Loading.... ",
                            style: GoogleFonts.quicksand(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.appColorWhite,
                            ),
                          ),
                          SizedBox(
                            width: 5.h,
                          ),
                          SizedBox(
                            height: 8.h,
                            width: 8.w,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2.0,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
              ),
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Belum punya akun ? ",
              style: GoogleFonts.quicksand(
                color: Colors.black,
                fontSize: 12.sp,
              ),
            ),
            TextButton(
              onPressed: () {
                controller.launchURL(
                    "https://api.whatsapp.com/send/?phone=6281321214107&text&type=phone_number&app_absent=0");
              },
              child: Text(
                'help!',
                style: GoogleFonts.quicksand(
                  fontSize: 12.sp,
                  color: Colors.blue,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
