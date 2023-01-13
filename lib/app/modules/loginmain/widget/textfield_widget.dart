import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/providers/network/api_endpoints.dart';
import '../../../routes/app_pages.dart';
import '../controllers/loginmain_controller.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final LoginmainController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Username",
            style: GoogleFonts.quicksand(
              fontWeight: FontWeight.bold,
              fontSize: 12.sp,
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          TextField(
            controller: controller.username,
            keyboardType: TextInputType.number,
            style: GoogleFonts.quicksand(color: Colors.black87),
            decoration: InputDecoration(
              hintText: "Masukan Username",
              hintStyle:
                  GoogleFonts.quicksand(color: Colors.grey, fontSize: 12.sp),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 2,
                      color: controller.username.text.isNotEmpty
                          ? const Color(0xff08B197)
                          : Colors.red)),
              border: const OutlineInputBorder(),
              contentPadding: EdgeInsets.only(left: 10.h),
              helperStyle: GoogleFonts.quicksand(
                color: Colors.black38,
                fontSize: 12.sp,
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            "Password",
            style: GoogleFonts.quicksand(
              fontWeight: FontWeight.bold,
              fontSize: 12.sp,
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          TextField(
            onTap: () {
              controller.isChecked.value = true;
            },
            obscureText: controller.isObscure.value,
            controller: controller.password,
            keyboardType: TextInputType.visiblePassword,
            style: GoogleFonts.quicksand(color: Colors.black87),
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
              hintText: "Masukan Password",
              hintStyle:
                  GoogleFonts.quicksand(color: Colors.grey, fontSize: 12.sp),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 2,
                      color: controller.password.text.isNotEmpty
                          ? const Color(0xff08B197)
                          : Colors.red)),
              border: const OutlineInputBorder(),
              contentPadding: EdgeInsets.only(left: 10.w),
              helperStyle: GoogleFonts.quicksand(
                color: Colors.black38,
                fontSize: 12.sp,
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 30,
                    width: 30,
                    child: Checkbox(
                      checkColor: Colors.white,
                      value: controller.isChecked.value,
                      onChanged: (bool? value) {
                        controller.isChecked.value = value!;
                      },
                    ),
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: "Dengan ini menyetujui ",
                        style: GoogleFonts.quicksand(
                            color: Colors.black, fontSize: 10.sp),
                        children: [
                          TextSpan(
                            text: "Kebijakan Privasi ",
                            style: GoogleFonts.quicksand(
                              color: Colors.blue,
                              fontSize: 10.sp,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.toNamed(Routes.KEBIJAKAN_PRIVASI);
                              },
                          ),
                          TextSpan(
                            text: "dan ",
                            style: GoogleFonts.quicksand(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 10.sp,
                            ),
                          ),
                          TextSpan(
                            text: "Ketentuan Layanan ",
                            style: GoogleFonts.quicksand(
                              color: Colors.blue,
                              fontSize: 10.sp,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.toNamed(Routes.KEBIJAKAN_PRIVASI);
                              },
                          ),
                          TextSpan(
                            text:
                                "penguna aplikasi, sebelum menyetujui tinjau terlebih dahulu !",
                            style: GoogleFonts.quicksand(
                              color: Colors.black,
                              fontSize: 10.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  controller
                      .launchURL("${APIEndpoint.api}/login/password_reset");
                },
                child: Text(
                  'Lupa Password ?',
                  style: GoogleFonts.quicksand(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
