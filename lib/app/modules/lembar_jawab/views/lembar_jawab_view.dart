import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_sisze.dart';
import '../controllers/lembar_jawab_controller.dart';

class LembarJawabView extends GetView<LembarJawabController> {
  const LembarJawabView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final id = Get.arguments[0];
    final pelajaran = Get.arguments[1];
    final judul = Get.arguments[2];
    final kelas = Get.arguments[3];
    final jumlahSoal = Get.arguments[4];
    return Scaffold(
      backgroundColor: AppColors.appBgroudColors,
      body: WillPopScope(
        onWillPop: () async {
          final back = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r)),
              title: Text(
                'Keluar ?',
                style: GoogleFonts.quicksand(
                    color: Colors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold),
              ),
              content: Text(
                'Apakah anda yakin ingin keluar dari halaman pengerjaan soal?, jawaban anda belum di simpan nih ! jawaban mu akan hilang jika kamu belum menekan tombol "Simpan Sementara" atau "Simpan & Akhiri" ! tekan batal untuk kembali ke halaman atau "Ok" untuk keluar',
                style: GoogleFonts.quicksand(
                    color: Colors.grey,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Get.back(),
                  child: Text(
                    'Kembali',
                    style: GoogleFonts.quicksand(),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.back(result: true);
                  },
                  child: Text(
                    'OK',
                    style: GoogleFonts.quicksand(),
                  ),
                ),
              ],
            ),
          );
          if (back == null) {
            return false;
          } else {
            return true;
          }
        },
        child: SafeArea(
          child: SizedBox(
            width: SizeConfig.screenWidth,
            child: FutureBuilder(
              future:
                  controller.getDataSoalPg(context, id, int.parse(jumlahSoal)),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: SizedBox(
                      height: 100.h,
                      width: 100.w,
                      child: Lottie.asset(
                        "assets/lotties/loading.json",
                      ),
                    ),
                  );
                }

                return Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: 150.h,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          width: double.infinity,
                          height: 150.h,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                colors: AppColors.gradientColors),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(25.r),
                              bottomRight: Radius.circular(25.r),
                            ),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CircleAvatar(
                                    radius: 15,
                                    backgroundColor: Colors.white,
                                    child: InkWell(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.r)),
                                            title: Text(
                                              'Keluar ?',
                                              style: GoogleFonts.quicksand(
                                                  color: Colors.black,
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            content: Text(
                                              'Apakah anda yakin ingin keluar dari halaman pengerjaan soal?, jawaban anda belum di simpan nih ! jawaban mu akan hilang jika kamu belum menekan tombol "Simpan Sementara" atau "Simpan & Akhiri" ! tekan batal untuk kembali ke halaman atau "Ok" untuk keluar',
                                              style: GoogleFonts.quicksand(
                                                  color: Colors.grey,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () => Get.back(),
                                                child: Text(
                                                  'Kembali',
                                                  style:
                                                      GoogleFonts.quicksand(),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Get.back();
                                                  Get.back();
                                                },
                                                child: Text(
                                                  'OK',
                                                  style:
                                                      GoogleFonts.quicksand(),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      child: Icon(
                                        Icons.arrow_back_rounded,
                                        size: 15.w,
                                        color: AppColors.appGreenlight,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Lembar Jawab",
                                          style: GoogleFonts.quicksand(
                                              color: AppColors.appColorWhite,
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: Icon(
                                      Icons.help,
                                      color: AppColors.appColorWhite,
                                      size: 20.w,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          top: 75.h,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      pelajaran,
                                      style: GoogleFonts.quicksand(
                                        color: AppColors.appColorWhite,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        judul,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.quicksand(
                                          color: AppColors.appColorWhite,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          const CircleAvatar(
                                            radius: 3,
                                            backgroundColor: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          Text(
                                            "Kelas : $kelas",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.quicksand(
                                              color: AppColors.appColorWhite,
                                              fontSize: 12.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          const CircleAvatar(
                                            radius: 3,
                                            backgroundColor: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          Text(
                                            "Jumlah : $jumlahSoal Soal",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.quicksand(
                                              color: AppColors.appColorWhite,
                                              fontSize: 12.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 15.w),
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
                            Icons.error,
                            size: 25.w,
                            color: AppColors.appGreenlight,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Pilih  jawaban  sesuai dengan keterangan pada soal ya !",
                                    style: GoogleFonts.quicksand(
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                        width: double.infinity,
                        height: 460.h,
                        child: OptionPage(controller: controller)),
                    Container(
                      margin: EdgeInsets.only(
                          left: 15.w, right: 15.w, bottom: 15.h),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 40.h,
                                  child: Obx(
                                    () => ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.r)),
                                        backgroundColor:
                                            const Color(0xffF97276),
                                      ),
                                      onPressed: controller.off.value != 0
                                          ? () => controller.scrollBack()
                                          : null,
                                      child: Text(
                                        "<< Sebelumya",
                                        style: GoogleFonts.quicksand(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
                              Expanded(
                                child: SizedBox(
                                  height: 40.h,
                                  child: Obx(
                                    () => ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.r)),
                                        backgroundColor:
                                            const Color(0xffEEBE02),
                                      ),
                                      onPressed: controller.off.value !=
                                              controller.optionSoal.length - 5
                                          ? controller.optionSoal.length >= 5
                                              ? () => controller.scrollTo()
                                              : null
                                          : null,
                                      child: Text(
                                        "Selanjutnya >> ",
                                        style: GoogleFonts.quicksand(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w700,
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
                          Obx(
                            () => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: 40.h,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.r)),
                                        backgroundColor:
                                            const Color(0xff578EFE),
                                      ),
                                      onPressed: () {
                                        controller.kirimOption(
                                            context, false, id);
                                      },
                                      child: Text(
                                        "Simpan Sementara",
                                        style: GoogleFonts.quicksand(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                if (controller.off.value >=
                                    controller.optionSoal.length - 5)
                                  SizedBox(
                                    width: 20.w,
                                  ),
                                if (controller.off.value >=
                                    controller.optionSoal.length - 5)
                                  Expanded(
                                    child: SizedBox(
                                      height: 40.h,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                          ),
                                          backgroundColor:
                                              AppColors.appGreenlight,
                                        ),
                                        onPressed: () {
                                          controller.kirimOption(
                                              context, true, id);
                                        },
                                        child: Text(
                                          "Simpan & Akhiri",
                                          style: GoogleFonts.quicksand(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class OptionPage extends StatelessWidget {
  const OptionPage({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final LembarJawabController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      padding: EdgeInsets.only(top: 10.h),
      color: Colors.white,
      child: ScrollablePositionedList.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemScrollController: controller.scrollcontroller,
        itemPositionsListener: controller.scrollListener,
        itemCount: controller.optionSoal.length,
        itemBuilder: (context, i) {
          return Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 10.w, right: 10.h, bottom: 10.h),
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                color: i.isEven
                    ? Colors.white
                    : AppColors.appGreenlight.withOpacity(0.1),
                height: 70.w,
                child: Row(
                  children: [
                    Text(
                      "${controller.optionSoal[i].nomor.toString()}.",
                      style: GoogleFonts.quicksand(
                          fontSize: 14.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          controller.optionSoal[i].option!.length,
                          (e) => GetBuilder<LembarJawabController>(
                            builder: (_) {
                              return Material(
                                borderRadius: BorderRadius.circular(10.r),
                                color: controller.optionSoal[i].key ==
                                        controller.optionSoal[i].option![e]
                                    ? AppColors.appGreenlight
                                    : Colors.white,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(10.r),
                                  onTap: () {
                                    controller.optionSoal[i].key =
                                        controller.optionSoal[i].option![e];
                                    _.update();
                                  },
                                  child: Container(
                                    height: 50.h,
                                    width: 50.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      border: Border.all(
                                        width: 1,
                                        color: const Color(0xffE9E9E9),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                          controller.optionSoal[i].option![e]),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
