import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:smkn1contoh/app/config/app_colors.dart';

import '../../../../data/models/materi/mapel_model.dart';

import '../../../list_materi/views/list_materi_view.dart';
import '../../controllers/home_controller.dart';

class GridMateriWidget extends StatelessWidget {
  const GridMateriWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DataMapel>?>(
      future: controller.initMapel,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 15.w),
            padding: EdgeInsets.symmetric(vertical: 10.h),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10.r)),
            child: Center(
              child: snapshot.data!.isNotEmpty
                  ? GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 1,
                      ),
                      itemBuilder: (context, index) {
                        final data = snapshot.data![index];
                        return GestureDetector(
                          onTap: () {
                            Get.to(ListMateriView(
                              mapel: data.nama,
                              icons: data.img,
                              id: data.id,
                              kelas: controller.kelas.value,
                            ));
                          },
                          child: SizedBox(
                            height: 60.h,
                            width: 60.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.network(
                                  data.img!,
                                  height: 55.h,
                                  width: 55.w,
                                ),
                                SizedBox(
                                  height: 4.h,
                                ),
                                Text(
                                  data.nama!,
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.quicksand(
                                      color: Colors.black, fontSize: 12.sp),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Row(
                        children: [
                          Lottie.asset("assets/lotties/7HyuWUXy9X.json",
                              width: 100),
                          Expanded(
                            child: Text(
                              "Jangan Lupa belajar ya, belum ada materi nih dari guru kamu nih ....!",
                              style: GoogleFonts.quicksand(
                                color: AppColors.appGreenDrak,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
