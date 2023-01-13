import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../modules/tugas_aktif/controllers/tugas_aktif_controller.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_image.dart';
import '../../../data/models/tugas/get_tugas_model.dart';
import '../../detail_tugas/views/detail_tugas_view.dart';

class DataSearchTugas extends SearchDelegate<String> {
  final TugasAktifController tugasAktifC = Get.put(TugasAktifController());

  @override
  String? get searchFieldLabel => "Cari judul tugas";

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: GoogleFonts.quicksand(fontSize: 14, color: Colors.white),
          counterStyle:
              GoogleFonts.quicksand(fontSize: 14, color: Colors.white),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
        appBarTheme:
            const AppBarTheme(backgroundColor: AppColors.appGreenlight));
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    // action for app bar
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: const Icon(
          Icons.clear,
          color: Colors.white,
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // leading icon on the left of the app bar
    return IconButton(
        onPressed: () {
          close(context, '');
        },
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          color: Colors.white,
          progress: transitionAnimation,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    final responseList = query.isEmpty
        ? tugasAktifC.listSearch
        : tugasAktifC.listTugas2
            .where((c) =>
                c.namaPelajaran!.toLowerCase().startsWith(query) ||
                c.judul!.toLowerCase().startsWith(query))
            .toList();
    return tugasAktifC.listTugas2
            .where((c) =>
                c.namaPelajaran!.toLowerCase().startsWith(query) ||
                c.judul!.toLowerCase().startsWith(query))
            .toList()
            .isNotEmpty
        ? Container(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              itemCount: responseList.length,
              itemBuilder: (context, index) {
                final data = responseList[index];
                return ItemsWidget(
                  controller: tugasAktifC,
                  data: data,
                );
              },
            ),
          )
        : SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.search),
                SizedBox(height: 10.h),
                Text(
                  'Tidak ada hasi yang di temukan.',
                  style: GoogleFonts.quicksand(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // show when someone searches for something
    final responseList = query.isEmpty
        ? tugasAktifC.listSearch
        : tugasAktifC.listTugas2
            .where((c) =>
                c.namaPelajaran!.toLowerCase().startsWith(query) ||
                c.judul!.toLowerCase().startsWith(query))
            .toList();
    return tugasAktifC.listTugas2
            .where((c) =>
                c.namaPelajaran!.toLowerCase().startsWith(query) ||
                c.judul!.toLowerCase().startsWith(query))
            .toList()
            .isNotEmpty
        ? Container(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              itemCount: responseList.length,
              itemBuilder: (context, index) {
                final data = responseList[index];
                return ItemsWidget(
                  controller: tugasAktifC,
                  data: data,
                );
              },
            ),
          )
        : SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.search),
                const SizedBox(height: 10),
                Text(
                  'Tidak ada hasi yang di temukan.',
                  style: GoogleFonts.quicksand(fontWeight: FontWeight.bold),
                ),
              ],
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                child: Material(
                  child: InkWell(
                    onTap: () {},
                    child: Image.asset(
                      'assets/icons/cloud-computing.png',
                      height: 20.h,
                      width: 20.w,
                    ),
                  ),
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
                decoration: BoxDecoration(
                    color: data.statusTugas != "aktif"
                        ? const Color(0xffEF5354).withOpacity(0.3)
                        : AppColors.appGreenlight.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(5.r)),
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
                            color: AppColors.appGreenlight, fontSize: 10.sp),
                      ),
                    if (data.statusTugas != "aktif")
                      Text(
                        "Tugas Kedaluwarsa",
                        style: GoogleFonts.quicksand(
                            color: const Color(0xffEF5354), fontSize: 10.sp),
                      ),
                  ],
                ),
              ),
              SizedBox(
                width: 10.h,
              ),
              Expanded(
                  child: Material(
                color: AppColors.appGreenlight.withOpacity(0.4),
                borderRadius: BorderRadius.circular(5.r),
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
                  borderRadius: BorderRadius.circular(5.r),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    child: Center(
                      child: Text(
                        "Pilih",
                        style: GoogleFonts.quicksand(
                            color: AppColors.appGreenDrak,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ))
            ],
          )
        ],
      ),
    );
  }
}
