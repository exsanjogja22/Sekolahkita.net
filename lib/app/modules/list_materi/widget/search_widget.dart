import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../modules/detail_status/views/detail_status_view.dart';
import '../../../modules/list_materi/controllers/list_materi_controller.dart';
import '../../../config/app_colors.dart';
import '../../detail_materi/views/detail_materi_view.dart';

class DataSearchMateri extends SearchDelegate<String> {
  final ListMateriController materiC = Get.put(ListMateriController());
  final String? id;
  final String? icons;
  final String? kelas;

  DataSearchMateri(this.id, this.icons, this.kelas);
  @override
  String? get searchFieldLabel => "Cari judul materi";

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
        ? materiC.listSearchMateri
        : materiC.listMateri
            .where((c) => c.judul!.toLowerCase().startsWith(query))
            .toList();
    return materiC.listMateri
            .where((c) => c.judul!.toLowerCase().startsWith(query))
            .toList()
            .isNotEmpty
        ? Container(
            margin: EdgeInsets.symmetric(horizontal: 15.w),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              itemCount: responseList.length,
              itemBuilder: (context, index) {
                final data = responseList[index];
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 10.w),
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  width: MediaQuery.of(context).size.width,
                  height: 70.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 50.h,
                        width: 50.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          image: DecorationImage(
                            image: NetworkImage(
                              data.guru!.photo!,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.judul!.toTitleCase(),
                              style: GoogleFonts.quicksand(
                                fontWeight: FontWeight.w500,
                                fontSize: 10.sp,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              data.guru!.namaGuru!.toTitleCase(),
                              style: GoogleFonts.quicksand(
                                fontWeight: FontWeight.bold,
                                fontSize: 10.sp,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: 10.w,
                            ),
                            if (data.waktu!.created == data.waktu!.updated!)
                              Text(
                                "${DateFormat("d MMMM yyyy, hh:mm", "id_ID").format(data.waktu!.created!)} WIB",
                                style: GoogleFonts.quicksand(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 8.sp,
                                  color: Colors.black,
                                ),
                              ),
                            if (data.waktu!.created != data.waktu!.updated!)
                              Text(
                                "Update: ${DateFormat("d MMMM yyyy, hh:mm", "id_ID").format(data.waktu!.created!)} WIB",
                                style: GoogleFonts.quicksand(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 8.sp,
                                  color: Colors.black,
                                ),
                              )
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Material(
                            color: AppColors.appGreenlight,
                            borderRadius: BorderRadius.circular(5.r),
                            child: InkWell(
                              onTap: () {
                                Get.to(
                                  DetailMateriView(
                                    id: data.id,
                                    idMapel: id,
                                    judul: data.judul,
                                    icons: icons,
                                    kelas: kelas,
                                    topik: materiC.topikDetail.value,
                                    namaGuru: data.guru!.namaGuru,
                                    namaMapel: data.guru!.namaPelajaran,
                                  ),
                                  transition: Transition.rightToLeft,
                                  duration: const Duration(microseconds: 500),
                                );
                              },
                              borderRadius: BorderRadius.circular(5.r),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                height: 30.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.r),
                                ),
                                child: Center(
                                  child: Text(
                                    "Detail",
                                    style: GoogleFonts.quicksand(
                                      color: Colors.white,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
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

  @override
  Widget buildSuggestions(BuildContext context) {
    // show when someone searches for something
    final responseList = query.isEmpty
        ? materiC.listSearchMateri
        : materiC.listMateri
            .where((c) => c.judul!.toLowerCase().startsWith(query))
            .toList();
    return materiC.listMateri
            .where((c) => c.judul!.toLowerCase().startsWith(query))
            .toList()
            .isNotEmpty
        ? Container(
            margin: EdgeInsets.symmetric(horizontal: 15.w),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              itemCount: responseList.length,
              itemBuilder: (context, index) {
                final data = responseList[index];
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 10.w),
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  width: MediaQuery.of(context).size.width,
                  height: 70.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 50.h,
                        width: 50.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          image: DecorationImage(
                            image: NetworkImage(
                              data.guru!.photo!,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.judul!.toTitleCase(),
                              style: GoogleFonts.quicksand(
                                fontWeight: FontWeight.w500,
                                fontSize: 10.sp,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              data.guru!.namaGuru!.toTitleCase(),
                              style: GoogleFonts.quicksand(
                                fontWeight: FontWeight.bold,
                                fontSize: 10.sp,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: 10.w,
                            ),
                            if (data.waktu!.created == data.waktu!.updated!)
                              Text(
                                "${DateFormat("d MMMM yyyy, hh:mm", "id_ID").format(data.waktu!.created!)} WIB",
                                style: GoogleFonts.quicksand(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 8.sp,
                                  color: Colors.black,
                                ),
                              ),
                            if (data.waktu!.created != data.waktu!.updated!)
                              Text(
                                "Update: ${DateFormat("d MMMM yyyy, hh:mm", "id_ID").format(data.waktu!.created!)} WIB",
                                style: GoogleFonts.quicksand(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 8.sp,
                                  color: Colors.black,
                                ),
                              )
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Material(
                            color: AppColors.appGreenlight,
                            borderRadius: BorderRadius.circular(5.r),
                            child: InkWell(
                              onTap: () {
                                Get.to(
                                  DetailMateriView(
                                    id: data.id,
                                    idMapel: id,
                                    judul: data.judul,
                                    icons: icons,
                                    kelas: kelas,
                                    topik: materiC.topikDetail.value,
                                    namaGuru: data.guru!.namaGuru,
                                    namaMapel: data.guru!.namaPelajaran,
                                  ),
                                  transition: Transition.rightToLeft,
                                  duration: const Duration(microseconds: 500),
                                );
                              },
                              borderRadius: BorderRadius.circular(5.r),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                height: 30.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.r),
                                ),
                                child: Center(
                                  child: Text(
                                    "Detail",
                                    style: GoogleFonts.quicksand(
                                      color: Colors.white,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
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
