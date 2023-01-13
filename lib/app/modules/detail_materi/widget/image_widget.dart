import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/models/materi/materi_detail_model.dart';
import '../../../modules/detail_status/views/detail_status_view.dart';
import '../../../config/app_colors.dart';

import '../controllers/detail_materi_controller.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    Key? key,
    required this.data3,
    required this.judul,
    required this.controller,
  }) : super(key: key);

  final List<FileMateri> data3;
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
                    "Materi Image",
                    style: GoogleFonts.quicksand(
                        color: AppColors.appGreenDrak,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: () {
                      controller.currIndexImage.value =
                          controller.currIndexImage.value == 0 ? 1 : 0;
                      controller.currImage.value = !controller.currImage.value;
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
              if (controller.currImage.isTrue)
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: data3.length,
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
                            controller.downloadFile(
                                context,
                                data3[index].dataUrl!,
                                "${data3[index].fileExtension}");
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
                                if (data3[index].fileExtension == "png" ||
                                    data3[index].fileExtension == "jpg" ||
                                    data3[index].fileExtension == "jpeg")
                                  Container(
                                    height: 60,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image:
                                            NetworkImage(data3[index].dataUrl!),
                                      ),
                                    ),
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
                                        data3[index].judul!.toTitleCase(),
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
