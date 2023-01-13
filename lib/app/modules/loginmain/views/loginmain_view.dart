import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../config/app_sisze.dart';
import '../controllers/loginmain_controller.dart';
import '../widget/button_widget.dart';
import '../widget/text_welcome_widget.dart';
import '../widget/textfield_widget.dart';

class LoginmainView extends GetView<LoginmainController> {
  const LoginmainView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Login Siswa',
          style: GoogleFonts.quicksand(
            fontWeight: FontWeight.bold,
            fontSize: 14.sp,
            color: Colors.black,
          ),
        ),
        leading: Container(
          padding: const EdgeInsets.all(10),
          child: CircleAvatar(
            backgroundColor: Colors.black,
            child: CircleAvatar(
              radius: 30.r,
              backgroundColor: Colors.white,
              child: Platform.isAndroid
                  ? Center(
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          size: 18,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    )
                  : IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        size: 18,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Get.back();
                      },
                    ),
            ),
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        width: double.infinity,
        color: Colors.white,
        child: Column(
          children: [
            const Expanded(
              flex: 1,
              child: TextWelcomeWidget(),
            ),
            //text Login widget
            Expanded(
              flex: 3,
              child: TextFieldWidget(
                controller: controller,
              ),
            ),
            //Button Login widget
            Expanded(
              flex: 1,
              child: ButtonWidget(controller: controller),
            )
          ],
        ),
      ),
    );
  }
}
