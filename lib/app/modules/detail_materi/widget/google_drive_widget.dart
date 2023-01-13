import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/models/materi/materi_detail_model.dart';
import '../../../modules/detail_status/views/detail_status_view.dart';
import '../../../config/app_colors.dart';

import '../controllers/detail_materi_controller.dart';

class GoogleDriveWidget extends StatelessWidget {
  const GoogleDriveWidget({
    Key? key,
    required this.data2,
    required this.judul,
    required this.controller,
  }) : super(key: key);

  final List<FileMateri> data2;
  final String? judul;
  final DetailMateriController controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: EdgeInsets.symmetric(horizontal: 15.w),
        padding: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: Colors.white,
        ),
        child: Obx(
          () => Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Materi Link Google Drive",
                    style: GoogleFonts.quicksand(
                        color: AppColors.appGreenDrak,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: () {
                      controller.currIndexGoogleDrive.value =
                          controller.currIndexGoogleDrive.value == 0 ? 1 : 0;
                      controller.currGoogleDrive.value =
                          !controller.currGoogleDrive.value;
                    },
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, anim) => RotationTransition(
                        turns: child.key == const ValueKey('icon1')
                            ? Tween<double>(begin: 1, end: 1).animate(anim)
                            : Tween<double>(begin: 1, end: 1).animate(anim),
                        child: FadeTransition(opacity: anim, child: child),
                      ),
                      child: controller.currIndexGoogleDrive.value == 0
                          ? const Icon(Icons.keyboard_arrow_down_rounded,
                              key: ValueKey('icon1'))
                          : const Icon(
                              Icons.keyboard_arrow_up_rounded,
                              key: ValueKey('icon2'),
                            ),
                    ),
                  ),
                ],
              ),
              if (controller.currGoogleDrive.isTrue)
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: data2.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        top: 15.h,
                      ),
                      child: Material(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.r),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10.r),
                          onTap: () {
                            controller.launchURL(data2[index].dataUrl!);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 10.h),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(
                                    color: Colors.grey.withOpacity(0.5))),
                            height: 80.h,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 60,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(10),
                                      image: const DecorationImage(
                                          image: AssetImage(
                                              "assets/icons/ic_google_drive.png"))),
                                  child: Icon(
                                    Icons.fullscreen,
                                    size: 20.w,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data2[index].judul!.toTitleCase(),
                                        style: GoogleFonts.quicksand(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        judul!.toTitleCase(),
                                        style: GoogleFonts.quicksand(
                                            fontSize: 10,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )
            ],
          ),
        ));
  }
}
