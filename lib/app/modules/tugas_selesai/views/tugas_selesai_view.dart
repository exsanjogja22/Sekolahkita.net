import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_image.dart';
import '../../../config/app_sisze.dart';
import '../../../data/models/tugas/get_tugas_model.dart';
import '../../detail_tugas/views/detail_tugas_view.dart';
import '../controllers/tugas_selesai_controller.dart';

class TugasSelesaiView extends GetView<TugasSelesaiController> {
  const TugasSelesaiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: AppColors.appBgroudColors,
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0.0),
        child: AppBar(
          backgroundColor: AppColors.appGreenlight,
          elevation: 0,
        ),
      ),
      body: SizedBox(
        width: SizeConfig.screenWidth,
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 130.h,
                ),
                Container(
                  width: double.infinity,
                  height: 100.h,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: AppColors.gradientColors),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                          right: 0,
                          child: Image.asset(
                            "assets/images/5145491.png",
                            width: MediaQuery.of(context).size.width,
                            height: 130.h,
                          )),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Colors.white,
                                  child: InkWell(
                                    onTap: () {
                                      Get.back();
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Tugas Selesai",
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
                                  child: const Icon(
                                    Icons.help,
                                    color: AppColors.appColorWhite,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: 85.h,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 15.w),
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          height: 40.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 4,
                                  color: Colors.black.withOpacity(0.2),
                                  offset: const Offset(0, 2))
                            ],
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.search,
                                color: Color(0xff5E5E5E),
                                size: 20,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Expanded(
                                child: Text(
                                  "Cari judul tugas ",
                                  style: GoogleFonts.quicksand(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12.sp,
                                    color: const Color(0xff5E5E5E),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 15.w),
                        width: 123.w,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xffFCC800),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Center(
                          child:
                              GetBuilder<TugasSelesaiController>(builder: (_) {
                            return DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                hint: Text(
                                  'Bulan',
                                  style: GoogleFonts.quicksand(
                                    color: AppColors.appColorWhite,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.sp,
                                  ),
                                ),
                                borderRadius: BorderRadius.circular(10),
                                underline: Container(),
                                dropdownColor:
                                    const Color(0xffFCC800).withOpacity(0.8),
                                value: controller.selectedBulan,
                                items: controller.bulan.map(
                                  (value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: GoogleFonts.quicksand(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    );
                                  },
                                ).toList(),
                                icon: const Icon(
                                  Icons.arrow_drop_down_outlined,
                                  size: 20,
                                  color: AppColors.appColorWhite,
                                ),
                                onChanged: (value) {
                                  controller.selectedBulan = value!;
                                  controller.update();
                                },
                              ),
                            );
                          }),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 15.h,
            ),
            Expanded(
              child: Obx(
                () => Container(
                  margin: EdgeInsets.symmetric(horizontal: 15.w),
                  child: SmartRefresher(
                    controller: controller.refreshController,
                    onRefresh: controller.onRefresh,
                    onLoading: controller.onLoading,
                    enablePullDown: true,
                    enablePullUp: true,
                    child: controller.listTugasSelesai.isNotEmpty
                        ? ListView.builder(
                            itemCount: controller.listTugasSelesai.length,
                            itemBuilder: (context, index) {
                              final data = controller.listTugasSelesai[index];
                              return ItemsWidget(
                                controller: controller,
                                data: data,
                              );
                            },
                          )
                        : Center(
                            child: SizedBox(
                              height: 100.h,
                              width: 100.w,
                              child: Lottie.asset(
                                "assets/lotties/loading.json",
                              ),
                            ),
                          ),
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

class TabWidget extends StatelessWidget {
  const TabWidget(
      {super.key,
      required this.mapel,
      required this.controller,
      required this.index});
  final String mapel;
  final TugasSelesaiController controller;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InkWell(
        onTap: () {
          controller.selected.value = index;
        },
        child: Card(
          color: controller.selected.value == index
              ? AppColors.appGreenlight
              : Colors.white,
          elevation: 6,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            child: Text(
              mapel,
              style: GoogleFonts.quicksand(
                fontWeight: FontWeight.bold,
                fontSize: 10.sp,
                color: controller.selected.value == index
                    ? AppColors.appColorWhite
                    : const Color(0xff747474),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ItemsWidget extends StatelessWidget {
  const ItemsWidget({super.key, required this.controller, required this.data});
  final TugasSelesaiController controller;
  final Tugas data;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      margin: EdgeInsets.only(
        bottom: 10.h,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 10.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          Column(
            children: [
              Container(
                height: 50.h,
                width: 50.w,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage(AppImage.profile),
                  ),
                  borderRadius: BorderRadius.circular(5.r),
                ),
              ),
            ],
          ),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        data.namaPelajaran!,
                        style: GoogleFonts.quicksand(
                          color: AppColors.appColorBlack.withOpacity(0.7),
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        data.judul!.toTitleCase(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.quicksand(
                          color: AppColors.appColorBlack,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    if (data.hasilPengerjaan!.statusRemidi == "1")
                      Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 3.h),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "Remidi",
                            style: GoogleFonts.quicksand(
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                              fontSize: 8.sp,
                            ),
                          )),
                    SizedBox(
                      width: 5.w,
                    ),
                    if (data.hasilPengerjaan!.statusResume == "1")
                      Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 3.h),
                          decoration: BoxDecoration(
                            color:
                                AppColors.appColorGreenSoft2.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "Resume",
                            style: GoogleFonts.quicksand(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                              fontSize: 8.sp,
                            ),
                          )),
                    if (data.hasilPengerjaan!.statusResume != "1")
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 3.h),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Belum di resume",
                          style: GoogleFonts.quicksand(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: 8.sp,
                          ),
                        ),
                      ),
                  ],
                ),
                if (data.waktu!.tipe == "waktu_jadwal")
                  Row(
                    children: [
                      Text(
                        DateFormat("d MMMM yyyy", "id_ID").format(
                            DateTime.parse(
                                data.waktu!.dataWaktu!.tanggal.toString())),
                        style: GoogleFonts.quicksand(
                          fontSize: 10.sp,
                          color: AppColors.appColorBlack,
                        ),
                      )
                    ],
                  ),
                if (data.waktu!.tipe == "waktu_range")
                  Row(
                    children: [
                      Text(
                        "${DateFormat("d MMMM yyyy", "id_ID").format(DateTime.parse(RangeTanggal.fromJson(data.waktu!.dataWaktu!.tanggal).mulai!))} s.d. ${DateFormat("d MMMM yyyy", "id_ID").format(DateTime.parse(RangeTanggal.fromJson(data.waktu!.dataWaktu!.tanggal).selesai!))}",
                        style: GoogleFonts.quicksand(
                          fontSize: 10.sp,
                          color: AppColors.appColorBlack,
                        ),
                      )
                    ],
                  ),
                if (data.waktu!.tipe == "waktu_bebas")
                  Row(
                    children: [
                      Text(
                        "Tidak ada batasan waktu",
                        style: GoogleFonts.quicksand(
                          fontSize: 10.sp,
                          color: AppColors.appColorBlack,
                        ),
                      )
                    ],
                  ),
                if (data.waktu!.tipe != "waktu_bebas")
                  Row(
                    children: [
                      Text(
                        "${data.waktu!.dataWaktu!.jam!.mulai} WIB s.d. ${data.waktu!.dataWaktu!.jam!.mulai} WIB",
                        style: GoogleFonts.quicksand(
                          fontSize: 10.sp,
                          color: AppColors.appColorBlack,
                        ),
                      )
                    ],
                  )
              ],
            ),
          ),
          Material(
            color: AppColors.appGreenlight.withOpacity(0.6),
            borderRadius: BorderRadius.circular(10.r),
            child: InkWell(
              onTap: () => Get.to(
                DetailTugasView(
                    data.idTugas,
                    data.namaPelajaran,
                    data.judul!.toTitleCase(),
                    data.soal!.jenisSoal,
                    data.soal!.totalSoal,
                    data.statusTugas,
                    true),
              ),
              borderRadius: BorderRadius.circular(10.r),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  children: [
                    Text(
                      "Detail ",
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 10.sp,
                      ),
                    ),
                    Image.asset(
                      AppImage.lihatSemua,
                      color: Colors.white,
                      height: 6.h,
                      width: 6.w,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
