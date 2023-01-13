import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../../data/models/presensi/presensi_kegiatan_model.dart';
import '../../../../routes/app_pages.dart';
import '../../controllers/post_presensi_controller.dart';
import '../../../../modules/mainpage/controllers/presensi_controller.dart';
import '../../../../config/app_colors.dart';
import '../../../../config/app_image.dart';
import '../../../../config/app_sisze.dart';

class PresensiKegitanWidget extends StatelessWidget {
  const PresensiKegitanWidget(this.controller, {Key? key}) : super(key: key);
  final PresensiController controller;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final presensiC = Get.put(PostPresensiController());
    return GetBuilder<PresensiController>(
      id: 2,
      builder: (_) {
        return Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              width: SizeConfig.screenWidth,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Daftar Presensi Kegiatan",
                            style: GoogleFonts.quicksand(
                              fontWeight: FontWeight.bold,
                              color: AppColors.appGreenDrak,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    FutureBuilder<List<DataPresensiKegiatan>?>(
                      future: _.stateGetPresensiKegitan,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final filterData = snapshot.data!
                              .where((p0) =>
                                  p0.buttonStatus == true &&
                                  p0.sudahPresensi == false)
                              .toList();
                          if (filterData.isNotEmpty) {
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: filterData.length,
                              itemBuilder: (context, index) {
                                final data = filterData;
                                return GestureDetector(
                                  onTap: () {
                                    presensiC.pathCameraImage.value = "null";
                                    presensiC.postEvent(
                                        context,
                                        data[index].sudahPresensi!,
                                        data[index].buttonStatus!,
                                        data[index].usePhoto!,
                                        data[index].useGps!,
                                        data[index].mkKode!,
                                        controller);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(bottom: 10.h),
                                    height: 110.h,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                      image: AssetImage(
                                        "assets/images/39649.png",
                                      ),
                                      fit: BoxFit.fill,
                                    )),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Image.asset(
                                          "assets/icons/presensi_icons/ic_presensi_kegiatan.png",
                                          height: 70.h,
                                          width: 70.w,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                data[index].mkTitle!,
                                                style: GoogleFonts.quicksand(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  fontSize: 12.sp,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      data[index]
                                                          .mkDescription!,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style:
                                                          GoogleFonts.quicksand(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: const Color(
                                                            0xff5E5E5E),
                                                        fontSize: 10.sp,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              Row(
                                                children: data[index]
                                                    .labelHari!
                                                    .map(
                                                      (e) => Text(
                                                        "$e, ",
                                                        style: GoogleFonts
                                                            .quicksand(
                                                          fontSize: 10.sp,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: AppColors
                                                              .appColorBlack,
                                                        ),
                                                      ),
                                                    )
                                                    .toList(),
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .access_alarms_outlined,
                                                    color:
                                                        const Color(0xff6C99F6),
                                                    size: 15.w,
                                                  ),
                                                  SizedBox(
                                                    width: 3.w,
                                                  ),
                                                  Expanded(
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            "Waktu : ${data[index].waktuPresensi}",
                                                            style: GoogleFonts
                                                                .quicksand(
                                                              fontSize: 10.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  const Color(
                                                                0xff5E5E5E,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 40.w,
                                        )
                                      ],
                                    ),
                                  ),
                                );

                                // Column(
                                //   children: [
                                //     Container(
                                //       padding: EdgeInsets.symmetric(
                                //         horizontal: 10.w,
                                //         vertical: 10.h,
                                //       ),
                                //       height: 85.h,
                                //       width: double.infinity,
                                //       decoration: BoxDecoration(
                                //         color: Colors.white,
                                //         borderRadius: BorderRadius.only(
                                //           topLeft: Radius.circular(15.r),
                                //           topRight: Radius.circular(15.r),
                                //         ),
                                //       ),
                                //       child: Row(
                                //         children: [
                                //           Container(
                                //             height: 70.h,
                                //             width: 70.w,
                                //             decoration: BoxDecoration(
                                //                 color: const Color(0xff6C99F6),
                                //                 borderRadius:
                                //                     BorderRadius.circular(
                                //                         15.r)),
                                //             child: Image.asset(
                                //               "assets/icons/presensi_icons/ic_presensi_kegiatan.png",
                                //               width: 60.w,
                                //             ),
                                //           ),
                                //           SizedBox(
                                //             width: 10.w,
                                //           ),
                                //           Expanded(
                                //             child: Column(
                                //               children: [
                                //                 Row(
                                //                   children: [
                                //                     Text(
                                //                       data[index].mkTitle!,
                                //                       style:
                                //                           GoogleFonts.quicksand(
                                //                         fontWeight:
                                //                             FontWeight.bold,
                                //                         color: Colors.black,
                                //                         fontSize: 10.sp,
                                //                       ),
                                //                     )
                                //                   ],
                                //                 ),
                                //                 Row(
                                //                   children: [
                                //                     Expanded(
                                //                       child: Text(
                                //                         data[index]
                                //                             .mkDescription!,
                                //                         maxLines: 3,
                                //                         overflow: TextOverflow
                                //                             .ellipsis,
                                //                         style: GoogleFonts
                                //                             .quicksand(
                                //                           fontWeight:
                                //                               FontWeight.w500,
                                //                           color: const Color(
                                //                               0xff5E5E5E),
                                //                           fontSize: 10.sp,
                                //                         ),
                                //                       ),
                                //                     )
                                //                   ],
                                //                 )
                                //               ],
                                //             ),
                                //           )
                                //         ],
                                //       ),
                                //     ),
                                //     Container(
                                //       margin: EdgeInsets.only(bottom: 20.w),
                                //       padding: EdgeInsets.symmetric(
                                //           horizontal: 10.w, vertical: 10.h),
                                //       width: double.infinity,
                                //       decoration: BoxDecoration(
                                //         color: const Color(0xffC9DDFF),
                                //         borderRadius: BorderRadius.only(
                                //           bottomLeft: Radius.circular(15.r),
                                //           bottomRight: Radius.circular(15.r),
                                //         ),
                                //       ),
                                //       child: Row(
                                //         mainAxisAlignment:
                                //             MainAxisAlignment.spaceBetween,
                                //         children: [
                                //           Expanded(
                                //             child: Column(
                                //               children: [
                                //                 Row(
                                //                   children: data[index]
                                //                       .labelHari!
                                //                       .map(
                                //                         (e) => Text(
                                //                           "$e, ",
                                //                           style: GoogleFonts
                                //                               .quicksand(
                                //                             fontSize: 10.sp,
                                //                             fontWeight:
                                //                                 FontWeight.bold,
                                //                             color: AppColors
                                //                                 .appColorBlack,
                                //                           ),
                                //                         ),
                                //                       )
                                //                       .toList(),
                                //                 ),
                                //                 SizedBox(
                                //                   height: 3.h,
                                //                 ),
                                //                 Row(
                                //                   children: [
                                //                     Icon(
                                //                       Icons
                                //                           .access_alarms_outlined,
                                //                       color: const Color(
                                //                           0xff6C99F6),
                                //                       size: 20.w,
                                //                     ),
                                //                     SizedBox(
                                //                       width: 3.w,
                                //                     ),
                                //                     Text(
                                //                       "Waktu : ${data[index].waktuPresensi}",
                                //                       style:
                                //                           GoogleFonts.quicksand(
                                //                               fontSize: 10.sp,
                                //                               fontWeight:
                                //                                   FontWeight
                                //                                       .w500,
                                //                               color: const Color(
                                //                                   0xff5E5E5E)),
                                //                     )
                                //                   ],
                                //                 )
                                //               ],
                                //             ),
                                //           ),
                                //           Material(
                                //             borderRadius:
                                //                 BorderRadius.circular(10.r),
                                //             color: AppColors.appGreenlight,
                                //             child: InkWell(
                                //               onTap: () {
                                //                 presensiC.pathCameraImage
                                //                     .value = "null";
                                //                 presensiC.postEvent(
                                //                     context,
                                //                     data[index].sudahPresensi!,
                                //                     data[index].buttonStatus!,
                                //                     data[index].usePhoto!,
                                //                     data[index].useGps!,
                                //                     data[index].mkKode!,
                                //                     controller);
                                //               },
                                //               borderRadius:
                                //                   BorderRadius.circular(10.r),
                                //               child: Container(
                                //                 height: 30.h,
                                //                 width: 90.w,
                                //                 decoration: BoxDecoration(
                                //                   borderRadius:
                                //                       BorderRadius.circular(
                                //                           10.r),
                                //                 ),
                                //                 child: Center(
                                //                   child: Text(
                                //                     "Presensi",
                                //                     style:
                                //                         GoogleFonts.quicksand(
                                //                       fontSize: 10.sp,
                                //                       fontWeight:
                                //                           FontWeight.bold,
                                //                       color: Colors.white,
                                //                     ),
                                //                   ),
                                //                 ),
                                //               ),
                                //             ),
                                //           )
                                //         ],
                                //       ),
                                //     )
                                //   ],
                                // );
                              },
                            );
                          } else {
                            return SizedBox(
                              height: 400.h,
                              width: SizeConfig.screenWidth,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 150.h,
                                      width: 150.w,
                                      child: Lottie.asset(
                                        "assets/lotties/11646-no-activity-animation.json",
                                      ),
                                    ),
                                    Text(
                                      "Tidak ada aktifitas presensi",
                                      style: GoogleFonts.quicksand(
                                        fontSize: 10.sp,
                                        color: AppColors.appGreenDrak,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                        }
                        return Center(
                          child: ClipOval(
                            child: Container(
                              height: 40.h,
                              width: 40.w,
                              color: Colors.white,
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.h,
                                vertical: 10.h,
                              ),
                              child: const CircularProgressIndicator(
                                color: AppColors.appGreenlight,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class PopUpCamera extends StatelessWidget {
  const PopUpCamera({
    Key? key,
    required this.useGps,
    required this.mkKode,
    required this.controller,
  }) : super(key: key);

  final bool useGps;
  final String mkKode;
  final PresensiController controller;
  @override
  Widget build(BuildContext context) {
    final presensiC = Get.put(PostPresensiController());
    return Container(
      height: MediaQuery.of(context).size.height / 1.10.h,
      width: SizeConfig.screenWidth,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Obx(
        () => Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 20.h,
                    left: 20.w,
                    right: 20.w,
                    bottom: 0.h,
                  ),
                  child: Text(
                    "Presensi harus disertai foto ya !",
                    style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.bold,
                        color: AppColors.appColorBlack,
                        fontSize: 14.sp),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: InkWell(
                    onTap: () async {
                      var result = await Get.toNamed(Routes.KAMERA_HELPER,
                          arguments: [1]);
                      presensiC.pathCameraImage.value = result.toString();
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        top: 10.h,
                        left: 20.w,
                        right: 20.w,
                        bottom: 20.h,
                      ),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                      ),
                      child: DottedBorder(
                        color: Colors.grey,
                        dashPattern: const [8, 4],
                        strokeWidth: 2,
                        borderType: BorderType.RRect,
                        child: Stack(
                          children: [
                            if (presensiC.pathCameraImage.value != "null")
                              Center(
                                child: Image.file(
                                  File(presensiC.pathCameraImage.value),
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            if (presensiC.pathCameraImage.value == "null")
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 20.h),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        AppImage.iconCameraPresensi,
                                        height: 50.h,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        "Ambil Foto",
                                        style: GoogleFonts.quicksand(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    margin: EdgeInsets.only(
                        top: 0.h, left: 20.w, right: 20.w, bottom: 20.h),
                    padding: const EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: Colors.grey[400]),
                    child: TextField(
                      controller: presensiC.mkNote,
                      decoration: InputDecoration(
                        disabledBorder: InputBorder.none,
                        border: InputBorder.none,
                        hintText: "Keterangan",
                        hintStyle: GoogleFonts.quicksand(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.only(
                        top: 0.h, left: 20.w, right: 20.w, bottom: 20.h),
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.appGreenlight,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                      ),
                      onPressed: () {
                        presensiC.postEvenUseFile(context, mkKode, controller);
                      },
                      child: Text(
                        'Kirim',
                        style: GoogleFonts.quicksand(
                            fontSize: 14.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (presensiC.isLoadingEvent.isTrue)
              Center(
                child: Container(
                  height: 200.h,
                  width: 200.w,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10.r)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 50.h,
                        width: 50.w,
                        child: const CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        "Mengirim ....",
                        style: GoogleFonts.quicksand(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
