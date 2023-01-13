import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../modules/detail_materi/widget/video_widget.dart';
import '../../../config/app_colors.dart';
import '../controllers/detail_materi_controller.dart';
import 'document_widget.dart';
import 'google_drive_widget.dart';
import 'image_widget.dart';
import 'lainya_widget.dart';

class DataSearchMateri extends SearchDelegate<String> {
  final DetailMateriController detailMateriC =
      Get.put(DetailMateriController());
  final String? judul;
  final String? id;

  DataSearchMateri(this.judul, this.id);

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
        ? detailMateriC.listSearchMateri
        : detailMateriC.listMateri
            .where((c) => c.judul!.toLowerCase().startsWith(query))
            .toList();
    return detailMateriC.listMateri
            .where((c) => c.judul!.toLowerCase().startsWith(query))
            .toList()
            .isNotEmpty
        ? SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Builder(
                builder: (_) {
                  final data0 = responseList
                      .where((element) =>
                          element.fileExtension == "null" &&
                          element.media == "youtube")
                      .toList();
                  final data1 = responseList
                      .where((element) => element.media == "file_dokumen")
                      .toList();
                  final data2 = responseList
                      .where((element) =>
                          element.fileExtension == "null" &&
                          element.media == "google_drive")
                      .toList();
                  final data3 = responseList
                      .where((element) => element.media == "file_image")
                      .toList();
                  final data4 = responseList
                      .where((element) => element.media == "undefined")
                      .toList();
                  return Column(
                    children: [
                      SizedBox(
                        height: 15.h,
                      ),
                      if (data0.isNotEmpty)
                        VideoWidget(
                            controller: detailMateriC,
                            data0: data0,
                            judul: judul,
                            id: id),
                      if (data1.isNotEmpty)
                        SizedBox(
                          height: 10.h,
                        ),
                      if (data1.isNotEmpty)
                        DocumentWidget(
                            controller: detailMateriC,
                            data1: data1,
                            judul: judul,
                            id: id),
                      if (data2.isNotEmpty)
                        SizedBox(
                          height: 10.h,
                        ),
                      if (data2.isNotEmpty)
                        GoogleDriveWidget(
                            controller: detailMateriC,
                            data2: data2,
                            judul: judul),
                      if (data3.isNotEmpty)
                        SizedBox(
                          height: 10.h,
                        ),
                      if (data3.isNotEmpty)
                        ImageWidget(
                            controller: detailMateriC,
                            data3: data3,
                            judul: judul),
                      if (data4.isNotEmpty)
                        SizedBox(
                          height: 10.h,
                        ),
                      if (data4.isNotEmpty)
                        LainyaWidget(
                            controller: detailMateriC,
                            data4: data4,
                            judul: judul),
                    ],
                  );
                },
              ),
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
        ? detailMateriC.listSearchMateri
        : detailMateriC.listMateri
            .where((c) => c.judul!.toLowerCase().startsWith(query))
            .toList();
    return detailMateriC.listMateri
            .where((c) => c.judul!.toLowerCase().startsWith(query))
            .toList()
            .isNotEmpty
        ? SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Builder(
                builder: (_) {
                  final data0 = responseList
                      .where((element) =>
                          element.fileExtension == "null" &&
                          element.media == "youtube")
                      .toList();
                  final data1 = responseList
                      .where((element) => element.media == "file_dokumen")
                      .toList();
                  final data2 = responseList
                      .where((element) =>
                          element.fileExtension == "null" &&
                          element.media == "google_drive")
                      .toList();
                  final data3 = responseList
                      .where((element) => element.media == "file_image")
                      .toList();
                  final data4 = responseList
                      .where((element) => element.media == "undefined")
                      .toList();
                  return Column(
                    children: [
                      SizedBox(
                        height: 15.h,
                      ),
                      if (data0.isNotEmpty)
                        VideoWidget(
                            controller: detailMateriC,
                            data0: data0,
                            judul: judul,
                            id: id),
                      if (data1.isNotEmpty)
                        SizedBox(
                          height: 10.h,
                        ),
                      if (data1.isNotEmpty)
                        DocumentWidget(
                            controller: detailMateriC,
                            data1: data1,
                            judul: judul,
                            id: id),
                      if (data2.isNotEmpty)
                        SizedBox(
                          height: 10.h,
                        ),
                      if (data2.isNotEmpty)
                        GoogleDriveWidget(
                            controller: detailMateriC,
                            data2: data2,
                            judul: judul),
                      if (data3.isNotEmpty)
                        SizedBox(
                          height: 10.h,
                        ),
                      if (data3.isNotEmpty)
                        ImageWidget(
                            controller: detailMateriC,
                            data3: data3,
                            judul: judul),
                      if (data4.isNotEmpty)
                        SizedBox(
                          height: 10.h,
                        ),
                      if (data4.isNotEmpty)
                        LainyaWidget(
                            controller: detailMateriC,
                            data4: data4,
                            judul: judul),
                    ],
                  );
                },
              ),
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
