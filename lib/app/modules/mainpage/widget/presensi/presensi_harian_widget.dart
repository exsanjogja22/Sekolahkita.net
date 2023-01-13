import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../mainpage/controllers/post_presensi_controller.dart';
import '../../../../data/models/presensi/config_siswa_model.dart';
import '../../../../data/models/presensi/presensi_harian_model.dart';
import '../../../../routes/app_pages.dart';
import '../../../mainpage/controllers/presensi_controller.dart';
import '../../../../config/app_sisze.dart';
import '../../../../config/app_colors.dart';

class PresensiHarianWidget extends StatelessWidget {
  const PresensiHarianWidget(this.controller, {Key? key}) : super(key: key);
  final PresensiController controller;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GetBuilder<PresensiController>(
      id: 1,
      builder: (_) {
        return SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                padding: EdgeInsets.only(
                  top: 10.h,
                  left: 10.w,
                  right: 10.w,
                  bottom: 10.h,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Presensi Harian",
                          style: GoogleFonts.quicksand(
                            color: AppColors.appGreenDrak,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    const PresensiButton(),
                    SizedBox(
                      height: 10.h,
                    ),
                    FutureBuilder<DataConfig?>(
                      future: controller.stateGetAturanPresensi,
                      builder: (context, snapshot) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Aturan jam masuk",
                                  style: GoogleFonts.quicksand(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10.sp,
                                  ),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text(
                                  "${snapshot.data?.jamDatangAwal ?? "00:00:00"} WIB s.d. ${snapshot.data?.jamDatangAkhir ?? "00:00:00"} WIB",
                                  style: GoogleFonts.quicksand(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 8.sp,
                                  ),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "Aturan jam pulang",
                                  style: GoogleFonts.quicksand(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10.sp,
                                  ),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Text(
                                  "${snapshot.data?.jamPulangAwal ?? "00:00:00"} WIB s.d. ${snapshot.data?.jamPulangAkhir ?? "00:00:00"} WIB",
                                  style: GoogleFonts.quicksand(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 8.sp,
                                  ),
                                )
                              ],
                            )
                          ],
                        );
                      },
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 10.h,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xff0AB19A),
                          width: 1.w,
                        ),
                        color: AppColors.appGreenlight.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.alarm_sharp,
                            size: 25.w,
                            color: AppColors.appGreenlight,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Jangan terlambat!",
                                  style: GoogleFonts.quicksand(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Perhatikan aturan waktu presensi ya!",
                                  style: GoogleFonts.quicksand(
                                    fontSize: 10.sp,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Row(
                      children: [
                        Text(
                          "Riwayat Presensi",
                          style: GoogleFonts.quicksand(
                            color: AppColors.appGreenDrak,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    FutureBuilder<DataPresensi?>(
                      future: controller.stateGetPresensiHarian,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final data = snapshot.data!;
                          return Row(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 10.w),
                                    height: 80.h,
                                    width: 145.w,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffAEC1FA),
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Datang: ",
                                              style: GoogleFonts.quicksand(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              data.statusDatang!,
                                              style: GoogleFonts.quicksand(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Pulang: ",
                                              style: GoogleFonts.quicksand(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              data.statusPulang!,
                                              style: GoogleFonts.quicksand(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    child: Container(
                                      height: 20.h,
                                      width: 70.w,
                                      decoration: const BoxDecoration(
                                        color: Color(0xffF97276),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Status",
                                          style: GoogleFonts.quicksand(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Expanded(
                                child: Stack(
                                  children: [
                                    Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10.w,
                                          vertical: 15.w,
                                        ),
                                        height: 80.h,
                                        decoration: BoxDecoration(
                                          color: AppColors.appGreenlight
                                              .withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Row(
                                              children: [
                                                CircleAvatar(
                                                  radius: 3.w,
                                                  backgroundColor:
                                                      AppColors.appGreenlight,
                                                ),
                                                SizedBox(
                                                  width: 4.w,
                                                ),
                                                Text(
                                                  "Waktu datang : ${data.waktuDatang!} WIB",
                                                  style: GoogleFonts.quicksand(
                                                    fontSize: 10.sp,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Row(
                                              children: [
                                                CircleAvatar(
                                                  radius: 3.w,
                                                  backgroundColor:
                                                      AppColors.appGreenlight,
                                                ),
                                                SizedBox(
                                                  width: 5.w,
                                                ),
                                                Text(
                                                  "Waktu pulang : ${data.waktuPulang} WIB",
                                                  style: GoogleFonts.quicksand(
                                                    fontSize: 10.sp,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        )),
                                    Positioned(
                                      child: Container(
                                        height: 20.h,
                                        width: 120.w,
                                        decoration: const BoxDecoration(
                                          color: Color(0xffF97276),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Catatan Waktu",
                                            style: GoogleFonts.quicksand(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          );
                        }
                        return Row(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.w, vertical: 10.w),
                                  height: 80.h,
                                  width: 145.w,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffAEC1FA),
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Datang: ",
                                            style: GoogleFonts.quicksand(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            "-",
                                            style: GoogleFonts.quicksand(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Pulang: ",
                                            style: GoogleFonts.quicksand(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            "-",
                                            style: GoogleFonts.quicksand(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  child: Container(
                                    height: 20.h,
                                    width: 70.w,
                                    decoration: const BoxDecoration(
                                      color: Color(0xffF97276),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Status",
                                        style: GoogleFonts.quicksand(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Expanded(
                              child: Stack(
                                children: [
                                  Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10.w,
                                        vertical: 15.w,
                                      ),
                                      height: 80.h,
                                      decoration: BoxDecoration(
                                        color: AppColors.appGreenlight
                                            .withOpacity(0.2),
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Row(
                                            children: [
                                              const CircleAvatar(
                                                radius: 3,
                                                backgroundColor:
                                                    AppColors.appGreenlight,
                                              ),
                                              SizedBox(
                                                width: 4.w,
                                              ),
                                              Text(
                                                "Waktu datang : 00:00:00 WIB",
                                                style: GoogleFonts.quicksand(
                                                  fontSize: 10.sp,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 3.w,
                                                backgroundColor:
                                                    AppColors.appGreenlight,
                                              ),
                                              SizedBox(
                                                width: 5.w,
                                              ),
                                              Text(
                                                "Waktu pulang :00:00:00 WIB",
                                                style: GoogleFonts.quicksand(
                                                  fontSize: 10.sp,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      )),
                                  Positioned(
                                    child: Container(
                                      height: 20.h,
                                      width: 120.w,
                                      decoration: BoxDecoration(
                                        color: const Color(0xffF97276),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10.r),
                                          bottomRight: Radius.circular(10.r),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Catatan Waktu",
                                          style: GoogleFonts.quicksand(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        );
                      },
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Showcase(
                key: controller.four,
                title: 'Menu zurat izin',
                titleTextStyle:
                    GoogleFonts.quicksand(fontWeight: FontWeight.bold),
                description: 'Ajukan Surat Izin, jika berhalangan hadir',
                descTextStyle: GoogleFonts.quicksand(
                  fontSize: 12.sp,
                ),
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 15.w,
                  ),
                  width: double.infinity,
                  height: 180,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/images/16446468992.png",
                        height: 130.h,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Hari ini\nberhalangan hadir?",
                                style: GoogleFonts.quicksand(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.appGreenlight,
                                ),
                              ),
                            ],
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff6C99F6),
                                shape: const StadiumBorder()),
                            onPressed: () {
                              showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (context) {
                                  return PopUpSuratIzin(
                                    controller: controller,
                                  );
                                },
                              );
                            },
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/icons/ic_upload_izin.png",
                                  height: 16.h,
                                  width: 16.w,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Text(
                                  "Upload Surat Izin",
                                  style: GoogleFonts.quicksand(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10.sp,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class PopUpSuratIzin extends StatelessWidget {
  const PopUpSuratIzin({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final PresensiController controller;
  @override
  Widget build(BuildContext context) {
    final presensiC = Get.put(PostPresensiController());
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.r),
          topRight: Radius.circular(10.r),
        ),
      ),
      width: MediaQuery.of(context).size.width,
      child: Obx(
        () => Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () => Get.back(),
                        child: CircleAvatar(
                          radius: 10.w,
                          backgroundColor:
                              const Color(0xffF97276).withOpacity(0.6),
                          child: Icon(
                            Icons.close,
                            color: Colors.red,
                            size: 15.w,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Image.asset(
                            "assets/images/16446468992.png",
                            height: 180.h,
                            width: 180.w,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            children: [
                              Text(
                                "Upload surat izinmu disini",
                                style: GoogleFonts.quicksand(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xff5E5E5E),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Material(
                            color: const Color(0xff50C474),
                            borderRadius: BorderRadius.circular(5.r),
                            child: InkWell(
                              onTap: () {
                                presensiC.selectFile();
                              },
                              borderRadius: BorderRadius.circular(5.r),
                              child: Container(
                                height: 30.h,
                                width: 140.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.r),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      "Pilih File",
                                      style: GoogleFonts.quicksand(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10.sp,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Icon(
                                      Icons.folder,
                                      size: 20.w,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            children: [
                              Text(
                                "Keterangan surat izin :",
                                style: GoogleFonts.quicksand(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xff5E5E5E),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          GetBuilder<PresensiController>(
                            builder: (_) {
                              return Container(
                                height: 30.h,
                                width: 140.w,
                                decoration: BoxDecoration(
                                  color: const Color(0xffFCC800),
                                  borderRadius: BorderRadius.circular(5.h),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10.w),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      hint: Text(
                                        'Keterangan',
                                        style: GoogleFonts.quicksand(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10.sp,
                                        ),
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                      dropdownColor: const Color(0xffFCC800),
                                      value: presensiC.selectedIzin,
                                      items: controller.izin.map(
                                        (value) {
                                          return DropdownMenuItem<String>(
                                            value: value["id"].toString(),
                                            child: Text(
                                              value["title"],
                                              style: GoogleFonts.quicksand(
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          );
                                        },
                                      ).toList(),
                                      icon: Icon(
                                        Icons.arrow_drop_down_outlined,
                                        size: 20.w,
                                        color: Colors.white,
                                      ),
                                      onChanged: (value) {
                                        presensiC.selectedIzin = value!;
                                        presensiC.update();
                                      },
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Hari ini\nberhalangan\nhadir?',
                                    style: GoogleFonts.quicksand(
                                      fontSize: 20.sp,
                                      color: const Color(0xff6C99F6),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 60.h,
                            ),
                            Row(
                              children: [
                                Material(
                                  color: const Color(0xff6C99F6),
                                  borderRadius: BorderRadius.circular(5.r),
                                  child: InkWell(
                                    onTap: () {
                                      presensiC.postSuratIzinPresensi(context);
                                    },
                                    borderRadius: BorderRadius.circular(5.r),
                                    child: Container(
                                      height: 50.h,
                                      width: 120.w,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Kirim",
                                          style: GoogleFonts.quicksand(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.sp,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              children: [
                                Text(
                                  "File Terupload :",
                                  style: GoogleFonts.quicksand(
                                    fontSize: 10.sp,
                                    color: const Color(0xff5E5E5E),
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Obx(() => Text(
                                        presensiC.basename.value,
                                        maxLines: 3,
                                        style: GoogleFonts.quicksand(
                                          fontSize: 10.sp,
                                          color: const Color(0xff6C99F6),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Tipe file yang diizinkan :",
                            style: GoogleFonts.quicksand(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            " jpg, jpeg, png",
                            style: GoogleFonts.quicksand(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Ukuran maksimal file",
                            style: GoogleFonts.quicksand(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "3 MB",
                            style: GoogleFonts.quicksand(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
            if (presensiC.isLoadingUpload.isTrue)
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
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
                          color: Colors.white),
                    )
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}

class PresensiButton extends StatelessWidget {
  const PresensiButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PresensiController>();
    return SizedBox(
      height: 50.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 2,
            child: Showcase(
              key: controller.two,
              title: 'Presensi datang',
              titleTextStyle:
                  GoogleFonts.quicksand(fontWeight: FontWeight.bold),
              description: 'Klik disini untuk melakukan presensi datang',
              descTextStyle: GoogleFonts.quicksand(
                fontSize: 12.sp,
              ),
              child: Showcase(
                key: controller.five,
                title: 'Presensi datang',
                titleTextStyle:
                    GoogleFonts.quicksand(fontWeight: FontWeight.bold),
                description: 'Klik disini untuk melakukan presensi Sekarang',
                descTextStyle: GoogleFonts.quicksand(
                  fontSize: 12.sp,
                ),
                child: Material(
                  color: AppColors.appGreenlight,
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(Routes.MAP_HELPER, arguments: ["masuk"]);
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: 50.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          10.r,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Image.asset(
                                  "assets/icons/presensi_icons/login.png",
                                  width: 20.w,
                                  height: 20.h,
                                  color: AppColors.appColorWhite,
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Masuk",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.quicksand(
                                    color: AppColors.appColorWhite,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10.h,
          ),
          Flexible(
            flex: 2,
            child: Showcase(
              key: controller.three,
              title: 'Presensi Pulang',
              titleTextStyle:
                  GoogleFonts.quicksand(fontWeight: FontWeight.bold),
              description: 'Klik disini untuk melakukan presensi pulang',
              descTextStyle: GoogleFonts.quicksand(
                fontSize: 12.sp,
              ),
              child: Material(
                color: const Color(0xff6C99F6),
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  onTap: () {
                    Get.toNamed(Routes.MAP_HELPER, arguments: ["pulang"]);
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: 50.h,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Image.asset(
                                "assets/icons/presensi_icons/logout.png",
                                width: 20.w,
                                height: 20.h,
                                color: AppColors.appColorWhite,
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Pulang",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.quicksand(
                                  color: AppColors.appColorWhite,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
