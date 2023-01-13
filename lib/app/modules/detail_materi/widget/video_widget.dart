import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../data/models/materi/materi_detail_model.dart';
import '../../../modules/detail_status/views/detail_status_view.dart';

import '../../../config/app_colors.dart';

import '../../youtube_helper/views/youtube_helper_view.dart';
import '../controllers/detail_materi_controller.dart';

class VideoWidget extends StatelessWidget {
  const VideoWidget({
    Key? key,
    required this.data0,
    required this.judul,
    required this.id,
    required this.controller,
    this.detail,
  }) : super(key: key);

  final List<FileMateri> data0;
  final String? judul;
  final String? id;
  final String? detail;
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
                  "Materi Video",
                  style: GoogleFonts.quicksand(
                      color: AppColors.appGreenDrak,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () {
                    controller.currIndexYoutube.value =
                        controller.currIndexYoutube.value == 0 ? 1 : 0;
                    controller.currYoutube.value =
                        !controller.currYoutube.value;
                  },
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, anim) => RotationTransition(
                      turns: child.key == const ValueKey('icon1')
                          ? Tween<double>(begin: 1, end: 1).animate(anim)
                          : Tween<double>(begin: 1, end: 1).animate(anim),
                      child: FadeTransition(opacity: anim, child: child),
                    ),
                    child: controller.currIndexYoutube.value == 0
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
            if (controller.currYoutube.isTrue)
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: data0.length,
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
                          Get.to(
                            YoutubeHelperView(
                              idYoutube: data0[index].dataUrl,
                              judul: judul,
                              keterangan: detail,
                              id: id,
                              title: data0[index].judul!,
                            ),
                            transition: Transition.rightToLeft,
                            duration: const Duration(microseconds: 500),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
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
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            "https://img.youtube.com/vi/${data0[index].dataUrl}/maxresdefault.jpg"))),
                                child: Icon(
                                  Icons.play_arrow,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data0[index].judul!.toTitleCase(),
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
      ),
    );
  }
}
