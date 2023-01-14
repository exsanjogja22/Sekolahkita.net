import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../akun_saya/views/akun_saya_view.dart';
import '../../../config/app_colors.dart';
import '../../../data/models/materi/materi_detail_model.dart';
import '../../list_materi/widget/search_widget.dart';
import '../controllers/detail_materi_controller.dart';
import '../data/models/post_kuisioner_model.dart';
import '../widget/document_widget.dart';
import '../widget/google_drive_widget.dart';
import '../widget/image_widget.dart';
import '../widget/lainya_widget.dart';
import '../widget/loading_dowload.dart';
import '../widget/video_widget.dart';

class DetailMateriView extends StatelessWidget {
  const DetailMateriView(
      {Key? key,
      this.id,
      this.judul,
      this.icons,
      this.kelas,
      this.topik,
      this.idMapel,
      this.namaGuru,
      this.namaMapel})
      : super(key: key);
  final String? id;
  final String? idMapel;
  final String? judul;
  final String? icons;
  final String? kelas;
  final String? topik;
  final String? namaGuru;
  final String? namaMapel;
  @override
  Widget build(BuildContext context) {
    final DetailMateriController controller = Get.put(DetailMateriController());
    return Scaffold(
      backgroundColor: AppColors.appBgroudColors,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0.0),
        child: AppBar(
          backgroundColor: AppColors.appGreenlight,
          elevation: 0,
        ),
      ),
      body: Obx(
        () => WillPopScope(
          onWillPop: () async {
            if (controller.isLauncePopUp.isTrue) {
              final back = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r)),
                  title: Text(
                    'Yuk isi Kuisioner Sebentar!',
                    style: GoogleFonts.quicksand(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  content: Text(
                    'Hai Siswa, Apakah kamu sudah mempelajari isi materi ini? Pada pelajaran ${namaMapel!} ini, ${namaGuru!} ingin mengetahui pemahamanmu. Tujuanya agar dikelasmu bisa dijelaskan lebih detail terkait bab materi apa yang kurang kamu pahami.',
                    style: GoogleFonts.quicksand(
                        color: Colors.grey,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500),
                  ),
                  actions: <Widget>[
                    if (controller.isKuisioner.isFalse)
                      TextButton(
                        onPressed: () {
                          controller.postDataDurasi(id!);
                          Get.back(result: true);
                        },
                        child: Text(
                          'Nanti',
                          style: GoogleFonts.quicksand(),
                        ),
                      ),
                    if (controller.isKuisioner.isFalse)
                      TextButton(
                        onPressed: () {
                          Get.back();
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(10))),
                            builder: (context) => SingleChildScrollView(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 10.h),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Yuk isi Kuisioner Sebentar!",
                                          style: GoogleFonts.quicksand(
                                            color: const Color(0xff155A5F),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.sp,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () => Get.back(),
                                          child: CircleAvatar(
                                            radius: 10,
                                            backgroundColor:
                                                const Color(0xffF97276)
                                                    .withOpacity(0.6),
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
                                  Column(
                                    children: [
                                      ListView(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        children: RxList.generate(
                                            controller.listKuisioner.length,
                                            (index) {
                                          final data =
                                              controller.listKuisioner[index];
                                          return KuisionerWidget(
                                            controller: controller,
                                            data: data,
                                            index: index,
                                          );
                                        }),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                              right: 10.w,
                                              bottom: 10.h,
                                            ),
                                            height: 40,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    AppColors.appGreenlight,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.r),
                                                ),
                                              ),
                                              onPressed: () {
                                                controller.postDataDurasi(id!);
                                                controller
                                                    .postDataKuisioner(context);
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Text(
                                                    "kirim",
                                                    style:
                                                        GoogleFonts.quicksand(
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10.w,
                                                  ),
                                                  const Icon(
                                                    Icons.send,
                                                    size: 15,
                                                    color: Colors.white,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        child: Text(
                          'Isi Sekarang',
                          style: GoogleFonts.quicksand(),
                        ),
                      ),
                    if (controller.isKuisioner.isTrue)
                      TextButton(
                        onPressed: () {
                          Get.back();
                          showModalBottomSheet(
                            context: context,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(10))),
                            builder: (context) => SingleChildScrollView(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 10.h),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Yuk isi Kuisioner Sebentar!",
                                          style: GoogleFonts.quicksand(
                                            color: const Color(0xff155A5F),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.sp,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () => Get.back(),
                                          child: CircleAvatar(
                                            radius: 10,
                                            backgroundColor:
                                                const Color(0xffF97276)
                                                    .withOpacity(0.6),
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
                                  Column(
                                    children: [
                                      ListView(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        children: RxList.generate(
                                            controller.listKuisioner.length,
                                            (index) {
                                          final data =
                                              controller.listKuisioner[index];
                                          return KuisionerWidget(
                                            controller: controller,
                                            data: data,
                                            index: index,
                                          );
                                        }),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                              right: 10.w,
                                              bottom: 10.h,
                                            ),
                                            height: 40,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    AppColors.appGreenlight,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.r),
                                                ),
                                              ),
                                              onPressed: () {
                                                controller.postDataDurasi(id!);
                                                controller
                                                    .postDataKuisioner(context);
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Text(
                                                    "kirim",
                                                    style:
                                                        GoogleFonts.quicksand(
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10.w,
                                                  ),
                                                  const Icon(
                                                    Icons.send,
                                                    size: 15,
                                                    color: Colors.white,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        child: Text(
                          'Isi Sekarang',
                          style: GoogleFonts.quicksand(),
                        ),
                      ),
                  ],
                ),
              );
              if (back == null) {
                return false;
              } else {
                return back;
              }
            } else {
              controller.postDataDurasi(id!);
              return true;
            }
          },
          child: Stack(
            children: [
              CustomScrollView(
                slivers: [
                  SliverAppBar(
                    leading: Padding(
                      padding: EdgeInsets.all(10.w),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: InkWell(
                          onTap: () {
                            if (controller.isLauncePopUp.isTrue) {
                              showDialog<bool>(
                                context: context,
                                builder: (context) => AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.r)),
                                  title: Text(
                                    'Yuk isi Kuisioner Sebentar!',
                                    style: GoogleFonts.quicksand(
                                        color: Colors.black,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  content: Text(
                                    'Hai Siswa, Apakah kamu sudah mempelajari isi materi ini? Pada pelajaran ${namaMapel!} ini, ${namaGuru!} ingin mengetahui pemahamanmu. Tujuanya agar dikelasmu bisa dijelaskan lebih detail terkait bab materi apa yang kurang kamu pahami.',
                                    style: GoogleFonts.quicksand(
                                        color: Colors.grey,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  actions: <Widget>[
                                    if (controller.isKuisioner.isFalse)
                                      TextButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: Text(
                                          'Nanti',
                                          style: GoogleFonts.quicksand(),
                                        ),
                                      ),
                                    if (controller.isKuisioner.isFalse)
                                      TextButton(
                                        onPressed: () {
                                          Get.back();
                                          showModalBottomSheet(
                                            isScrollControlled: true,
                                            context: context,
                                            shape: const RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                        top: Radius.circular(
                                                            10))),
                                            builder: (context) =>
                                                SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10.w,
                                                            vertical: 10.h),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Yuk isi Kuisioner Sebentar!",
                                                          style: GoogleFonts
                                                              .quicksand(
                                                            color: const Color(
                                                                0xff155A5F),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18.sp,
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: () =>
                                                              Get.back(),
                                                          child: CircleAvatar(
                                                            radius: 10,
                                                            backgroundColor:
                                                                const Color(
                                                                        0xffF97276)
                                                                    .withOpacity(
                                                                        0.6),
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
                                                  Column(
                                                    children: [
                                                      ListView(
                                                        physics:
                                                            const NeverScrollableScrollPhysics(),
                                                        shrinkWrap: true,
                                                        children: RxList.generate(
                                                            controller
                                                                .listKuisioner
                                                                .length,
                                                            (index) {
                                                          final data = controller
                                                                  .listKuisioner[
                                                              index];
                                                          return KuisionerWidget(
                                                            controller:
                                                                controller,
                                                            data: data,
                                                            index: index,
                                                          );
                                                        }),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                              right: 10.w,
                                                              bottom: 10.h,
                                                            ),
                                                            height: 40,
                                                            child:
                                                                ElevatedButton(
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                backgroundColor:
                                                                    AppColors
                                                                        .appGreenlight,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.r),
                                                                ),
                                                              ),
                                                              onPressed: () {
                                                                controller
                                                                    .postDataDurasi(
                                                                        id!);
                                                                controller
                                                                    .postDataKuisioner(
                                                                        context);
                                                              },
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceAround,
                                                                children: [
                                                                  Text(
                                                                    "kirim",
                                                                    style: GoogleFonts
                                                                        .quicksand(
                                                                      fontSize:
                                                                          12,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10.w,
                                                                  ),
                                                                  const Icon(
                                                                    Icons.send,
                                                                    size: 15,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          'Isi Sekarang',
                                          style: GoogleFonts.quicksand(),
                                        ),
                                      ),
                                    if (controller.isKuisioner.isTrue)
                                      TextButton(
                                        onPressed: () {
                                          Get.back();
                                          showModalBottomSheet(
                                            context: context,
                                            shape: const RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                        top: Radius.circular(
                                                            10))),
                                            builder: (context) =>
                                                SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10.w,
                                                            vertical: 10.h),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Yuk isi Kuisioner Sebentar!",
                                                          style: GoogleFonts
                                                              .quicksand(
                                                            color: const Color(
                                                                0xff155A5F),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18.sp,
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: () =>
                                                              Get.back(),
                                                          child: CircleAvatar(
                                                            radius: 10,
                                                            backgroundColor:
                                                                const Color(
                                                                        0xffF97276)
                                                                    .withOpacity(
                                                                        0.6),
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
                                                  Column(
                                                    children: [
                                                      ListView(
                                                        physics:
                                                            const NeverScrollableScrollPhysics(),
                                                        shrinkWrap: true,
                                                        children: RxList.generate(
                                                            controller
                                                                .listKuisioner
                                                                .length,
                                                            (index) {
                                                          final data = controller
                                                                  .listKuisioner[
                                                              index];
                                                          return KuisionerWidget(
                                                            controller:
                                                                controller,
                                                            data: data,
                                                            index: index,
                                                          );
                                                        }),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                              right: 10.w,
                                                              bottom: 10.h,
                                                            ),
                                                            height: 40,
                                                            child:
                                                                ElevatedButton(
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                backgroundColor:
                                                                    AppColors
                                                                        .appGreenlight,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.r),
                                                                ),
                                                              ),
                                                              onPressed: () {
                                                                controller
                                                                    .postDataDurasi(
                                                                        id!);

                                                                controller
                                                                    .postDataKuisioner(
                                                                        context);
                                                              },
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceAround,
                                                                children: [
                                                                  Text(
                                                                    "kirim",
                                                                    style: GoogleFonts
                                                                        .quicksand(
                                                                      fontSize:
                                                                          12,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10.w,
                                                                  ),
                                                                  const Icon(
                                                                    Icons.send,
                                                                    size: 15,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          'Isi Sekarang',
                                          style: GoogleFonts.quicksand(),
                                        ),
                                      ),
                                  ],
                                ),
                              );
                            } else {
                              controller.postDataDurasi(id!);
                              Get.back();
                            }
                          },
                          child: Icon(
                            Icons.arrow_back_rounded,
                            size: 15.w,
                            color: AppColors.appGreenlight,
                          ),
                        ),
                      ),
                    ),
                    centerTitle: true,
                    backgroundColor: AppColors.appGreenlight,
                    pinned: true,
                    expandedHeight: 175.0.h,
                    flexibleSpace: LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
                        controller.top.value = constraints.biggest.height;
                        return FlexibleSpaceBar(
                          background: Container(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                    colors: AppColors.gradientColors)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 40.w,
                                    ),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          showSearch(
                                              context: context,
                                              delegate: DataSearchMateri(
                                                  judul, id, kelas));
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.w),
                                          height: 35.h,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20.r)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.search,
                                                color: AppColors.appGreenlight,
                                                size: 20.w,
                                              ),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              Text(
                                                "Cari judul materi",
                                                style: GoogleFonts.quicksand(
                                                    color:
                                                        AppColors.appGreenlight,
                                                    fontSize: 12.sp,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Topik: ${topik!.toTitleCase()}",
                                              style: GoogleFonts.quicksand(
                                                fontSize: 12.sp,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    judul!.toTitleCase(),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style:
                                                        GoogleFonts.quicksand(
                                                      fontSize: 16.sp,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              kelas!.replaceAll("/", ""),
                                              style: GoogleFonts.quicksand(
                                                fontSize: 14.sp,
                                                color: Colors.white,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      if (icons != "")
                                        Image.network(
                                          icons!,
                                          width: 80.h,
                                          height: 80.w,
                                        ),
                                      if (icons == "")
                                        Image.asset(
                                          "assets/icons/grid_menu/39648.png",
                                          width: 80.h,
                                          height: 80.w,
                                        )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          centerTitle: true,
                          title: AnimatedOpacity(
                            opacity: controller.top <= 130 ? 1.0 : 0,
                            duration: const Duration(milliseconds: 200),
                            child: Padding(
                              padding: EdgeInsets.only(top: 17.h),
                              child: Text(
                                judul!.toTitleCase(),
                                style: GoogleFonts.quicksand(
                                  fontSize: 14.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: FutureBuilder<DataMateriDetail?>(
                      future: controller.getDataMateri(id!),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final data0 = snapshot.data!.file!
                              .where((element) =>
                                  element.fileExtension == "null" &&
                                  element.media == "youtube")
                              .toList();
                          final data1 = snapshot.data!.file!
                              .where(
                                  (element) => element.media == "file_dokumen")
                              .toList();
                          final data2 = snapshot.data!.file!
                              .where((element) =>
                                  element.fileExtension == "null" &&
                                  element.media == "google_drive")
                              .toList();
                          final data3 = snapshot.data!.file!
                              .where((element) => element.media == "file_image")
                              .toList();
                          final data4 = snapshot.data!.file!
                              .where((element) => element.media == "undefined")
                              .toList();
                          return Column(
                            children: [
                              SizedBox(
                                height: 15.h,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                margin: EdgeInsets.symmetric(
                                    horizontal: 15.w, vertical: 15.h),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      "Deskripsi",
                                      style: GoogleFonts.quicksand(
                                          color: AppColors.appGreenDrak,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    HtmlWidget(
                                      snapshot.data!.detail!,
                                      textStyle: GoogleFonts.quicksand(),
                                    ),
                                  ],
                                ),
                              ),
                              if (data0.isNotEmpty)
                                VideoWidget(
                                  controller: controller,
                                  data0: data0,
                                  judul: judul,
                                  id: id,
                                  detail: snapshot.data!.detail,
                                ),
                              if (data1.isNotEmpty)
                                SizedBox(
                                  height: 10.h,
                                ),
                              if (data1.isNotEmpty)
                                DocumentWidget(
                                    controller: controller,
                                    data1: data1,
                                    judul: judul,
                                    id: id),
                              if (data2.isNotEmpty)
                                SizedBox(
                                  height: 10.h,
                                ),
                              if (data2.isNotEmpty)
                                GoogleDriveWidget(
                                    controller: controller,
                                    data2: data2,
                                    judul: judul),
                              if (data3.isNotEmpty)
                                SizedBox(
                                  height: 10.h,
                                ),
                              if (data3.isNotEmpty)
                                ImageWidget(
                                    controller: controller,
                                    data3: data3,
                                    judul: judul),
                              if (data4.isNotEmpty)
                                SizedBox(
                                  height: 10.h,
                                ),
                              if (data4.isNotEmpty)
                                LainyaWidget(
                                    controller: controller,
                                    data4: data4,
                                    judul: judul),
                            ],
                          );
                        }
                        return Center(
                          child: SizedBox(
                            height: 100.h,
                            width: 100.w,
                            child: Lottie.asset(
                              "assets/lotties/loading.json",
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
              if (controller.isLoadingDownload.isTrue)
                LoadingDowload(controller: controller)
            ],
          ),
        ),
      ),
    );
  }
}

class KuisionerWidget extends StatelessWidget {
  const KuisionerWidget({
    Key? key,
    required this.data,
    required this.index,
    required this.controller,
  }) : super(key: key);

  final PostKuisioner data;
  final int index;
  final DetailMateriController controller;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailMateriController>(
      init: DetailMateriController(),
      initState: (_) {},
      builder: (_) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${index + 1}. ${data.judul} ",
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: RxList.generate(data.opsi!.length, (i) {
                  return InkWell(
                    onTap: () {
                      controller.listKuisioner[index].key = data.opsi![i];
                      _.update();
                    },
                    child: Container(
                      height: 70,
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                      decoration: BoxDecoration(
                          color: controller.listKuisioner[index].key ==
                                  controller.listKuisioner[index].opsi![i]
                              ? AppColors.appGreenlight.withOpacity(0.5)
                              : Colors.transparent,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10.r)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          if (data.opsi![i] == "belum_paham")
                            Image.asset(
                              "assets/icons/sad.png",
                              height: 20,
                            ),
                          if (data.opsi![i] == "kurang_paham")
                            Image.asset(
                              "assets/icons/confused.png",
                              height: 20,
                            ),
                          if (data.opsi![i] == "cukup_paham")
                            Image.asset(
                              "assets/icons/happyp.png",
                              height: 20,
                            ),
                          if (data.opsi![i] == "sangat_paham")
                            Image.asset(
                              "assets/icons/smiling.png",
                              height: 20,
                            ),
                          Text(
                            data.opsi![index]
                                .replaceAll("_", " ")
                                .toTitleCase(),
                            style: GoogleFonts.quicksand(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 10.sp,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        );
      },
    );
  }
}
