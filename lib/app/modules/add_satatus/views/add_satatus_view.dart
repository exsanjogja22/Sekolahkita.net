import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_image.dart';
import '../../../config/app_sisze.dart';
import '../controllers/add_satatus_controller.dart';

class AddSatatusView extends GetView<AddSatatusController> {
  const AddSatatusView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: AppColors.appBgroudColors,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0.h),
        child: AppBar(
          backgroundColor: AppColors.appGreenlight,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(25),
            ),
          ),
          title: Text(
            'Buat Postingan',
            style: GoogleFonts.quicksand(
              color: AppColors.appColorWhite,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        width: SizeConfig.screenWidth,
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 28.r,
                      backgroundColor: Colors.white,
                      backgroundImage: const AssetImage(AppImage.profile),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Ade Sandi Ahmad",
                                style: GoogleFonts.quicksand(
                                  fontSize: 12.sp,
                                  color: AppColors.appColorBlack,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Row(
                            children: [
                              Image.asset(
                                "assets/icons/ic_internet.png",
                                height: 10.h,
                                width: 10.w,
                              ),
                              SizedBox(
                                width: 5.h,
                              ),
                              Text(
                                "Bagikan dengan : ",
                                style: GoogleFonts.quicksand(
                                  fontSize: 10.sp,
                                  color: Colors.grey,
                                ),
                              ),
                              GetBuilder<AddSatatusController>(
                                builder: (_) {
                                  return SizedBox(
                                    height: 10,
                                    child: DropdownButton<String>(
                                      underline: Container(),
                                      borderRadius: BorderRadius.circular(10),
                                      dropdownColor: AppColors.appColorWhite,
                                      value: controller.selectedTo,
                                      items: controller.posTo.map(
                                        (value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                              style: GoogleFonts.quicksand(
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          );
                                        },
                                      ).toList(),
                                      icon: const Icon(
                                        Icons.arrow_drop_down_outlined,
                                        size: 15,
                                        color: Colors.black,
                                      ),
                                      onChanged: (value) {
                                        controller.selectedTo = value!;
                                        controller.update();
                                      },
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                SizedBox(
                  width: double.infinity,
                  child: CupertinoTextField(
                    controller: controller.text,
                    autofocus: true,
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                    placeholder: 'Apa yang Anda pikirkan sekarang? ',
                    maxLines: 15,
                    placeholderStyle:
                        GoogleFonts.quicksand(color: Colors.grey, fontSize: 12),
                    style: GoogleFonts.quicksand(
                        color: Colors.black, fontSize: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.withOpacity(0.7)),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
              ],
            ),
            Positioned(
              bottom: MediaQuery.of(context).padding.bottom + 20.w,
              left: 0,
              right: 0,
              child: SizedBox(
                width: double.infinity,
                height: 40.h,
                child: ElevatedButton(
                  onPressed: () {
                    controller.postDataStatus();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.appGreenlight,
                  ),
                  child: Text(
                    "Posting",
                    style: GoogleFonts.quicksand(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.appColorWhite),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
