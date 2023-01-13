import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../data/models/tugas/get_tugas_model.dart';
import '../../detail_tugas/views/detail_tugas_view.dart';
import '../widget/search_widget.dart';
import '/app/config/app_image.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_sisze.dart';
import '../controllers/tugas_aktif_controller.dart';

class TugasAktifView extends GetView<TugasAktifController> {
  const TugasAktifView({Key? key}) : super(key: key);
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
                                        "Tugas Aktif",
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
                  child: GestureDetector(
                    onTap: () {
                      showSearch(context: context, delegate: DataSearchTugas());
                    },
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
                    child: controller.listTugas.isNotEmpty
                        ? ListView.builder(
                            itemCount: controller.listTugas.length,
                            itemBuilder: (context, index) {
                              final data = controller.listTugas[index];
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
  final TugasAktifController controller;
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
                      : const Color(0xff747474)),
            ),
          ),
        ),
      ),
    );
  }
}

class ItemsWidget extends StatelessWidget {
  const ItemsWidget({super.key, required this.controller, required this.data});
  final TugasAktifController controller;
  final Tugas data;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 10.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  Container(
                    height: 50.h,
                    width: 50.w,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                          image: AssetImage(AppImage.profile)),
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 10.h,
              ),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          data.namaPelajaran!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.quicksand(
                            color: AppColors.appColorBlack.withOpacity(0.7),
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.grey.withOpacity(0.2)),
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: Center(
                            child: data.soal!.jenisSoal == "option"
                                ? Text(
                                    "pilihan ganda",
                                    style: GoogleFonts.quicksand(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10.sp,
                                    ),
                                  )
                                : Text(
                                    "essay",
                                    style: GoogleFonts.quicksand(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10.sp,
                                    ),
                                  ),
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        if (data.soal!.jenisSoal == "option")
                          Text(
                            "${data.soal!.totalSoal} Soal",
                            style: GoogleFonts.quicksand(
                                fontSize: 10.sp,
                                color: AppColors.appColorBlack),
                          )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 50,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    data.judul!.toTitleCase(),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.quicksand(
                      color: AppColors.appColorBlack,
                      fontWeight: FontWeight.bold,
                      fontSize: 10.sp,
                    ),
                  ),
                )
              ],
            ),
          ),
          if (data.waktu!.tipe == "waktu_jadwal")
            Row(
              children: [
                Text(
                  DateFormat("d MMMM yyyy", "id_ID").format(DateTime.parse(
                      data.waktu!.dataWaktu!.tanggal.toString())),
                  style: GoogleFonts.quicksand(
                      color: AppColors.appColorBlack, fontSize: 10.sp),
                )
              ],
            ),
          if (data.waktu!.tipe == "waktu_range")
            Row(
              children: [
                Text(
                  "${DateFormat("d MMMM yyyy", "id_ID").format(DateTime.parse(RangeTanggal.fromJson(data.waktu!.dataWaktu!.tanggal).mulai!))} s.d. ${DateFormat("d MMMM yyyy", "id_ID").format(DateTime.parse(RangeTanggal.fromJson(data.waktu!.dataWaktu!.tanggal).selesai!))}",
                  style: GoogleFonts.quicksand(
                      color: AppColors.appColorBlack, fontSize: 10.sp),
                )
              ],
            ),
          if (data.waktu!.tipe == "waktu_bebas")
            Row(
              children: [
                Text(
                  "Tidak ada batasan waktu",
                  style: GoogleFonts.quicksand(
                      color: AppColors.appColorBlack, fontSize: 10.sp),
                )
              ],
            ),
          if (data.waktu!.tipe != "waktu_bebas")
            Row(
              children: [
                Text(
                  "${data.waktu!.dataWaktu!.jam!.mulai} WIB s.d. ${data.waktu!.dataWaktu!.jam!.mulai} WIB",
                  style: GoogleFonts.quicksand(
                      color: AppColors.appColorBlack, fontSize: 10.sp),
                )
              ],
            ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                // decoration: BoxDecoration(
                //     color: data.statusTugas != "aktif"
                //         ? const Color(0xffEF5354).withOpacity(0.3)
                //         : AppColors.appGreenlight.withOpacity(0.3),
                //     borderRadius: BorderRadius.circular(5.r)),
                child: Row(
                  children: [
                    if (data.statusTugas != "aktif")
                      Image.asset(
                        "assets/icons/presensi_icons/ic_tidak_hadir.png",
                        height: 12.h,
                        width: 12.w,
                      ),
                    if (data.statusTugas == "aktif")
                      const Icon(
                        Icons.notifications_active_outlined,
                        size: 15,
                        color: AppColors.appGreenlight,
                      ),
                    SizedBox(
                      width: 5.w,
                    ),
                    if (data.statusTugas == "aktif")
                      Text(
                        "Tugas Aktif",
                        style: GoogleFonts.quicksand(
                            color: AppColors.appGreenlight, fontSize: 10),
                      ),
                    if (data.statusTugas != "aktif")
                      Text(
                        "Tugas Kedaluwarsa",
                        style: GoogleFonts.quicksand(
                            color: const Color(0xffEF5354), fontSize: 10),
                      ),
                  ],
                ),
              ),
              SizedBox(
                width: 10.h,
              ),
              Expanded(
                child: Material(
                  color: AppColors.appGreenlight.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(20.r),
                  child: InkWell(
                    onTap: () => Get.to(
                      DetailTugasView(
                          data.idTugas,
                          data.namaPelajaran,
                          data.judul!.toTitleCase(),
                          data.soal!.jenisSoal,
                          data.soal!.totalSoal,
                          data.statusTugas,
                          false),
                    ),
                    borderRadius: BorderRadius.circular(20.r),
                    child: Container(
                      height: 30,
                      padding:
                          EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Center(
                        child: Text(
                          "Pilih",
                          style: GoogleFonts.quicksand(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
