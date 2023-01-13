import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_image.dart';
import '../../../data/models/kbm_virtual_model.dart';
import '../../../data/models/materi/mapel_model.dart';
import '../../../data/models/status/status_model.dart';
import '../../../data/models/tugas/get_tugas_model.dart';
import '../../../routes/app_pages.dart';
import '../../detail_materi/views/detail_materi_view.dart';
import '../../list_materi/views/list_materi_view.dart';
import '../controllers/home_controller.dart';
import '../widget/home/bar_menu_widget.dart';
import '../widget/home/grid_materi_widget.dart';
import '../widget/home/status_items_widget.dart';
import '../widget/home/top_widget.dart';
import '../widget/home/tugas_menu_widget.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
      body: ShowCaseWidget(
        onComplete: (index, key) {
          if (index == 2) {
            controller.skipsCase1();
          }
          if (index == 2) {
            SystemChrome.setSystemUIOverlayStyle(
              SystemUiOverlayStyle.light.copyWith(
                statusBarIconBrightness: Brightness.dark,
                statusBarColor: Colors.white,
              ),
            );
          }
        },
        blurValue: 1,
        builder: Builder(builder: (context) {
          controller.myContext = context;
          return SmartRefresher(
            controller: controller.toRefersController,
            onRefresh: () => controller.toRefres(),
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  bottom: const PreferredSize(
                    preferredSize: Size.fromHeight(20.0),
                    child: SizedBox(),
                  ),
                  pinned: true,
                  expandedHeight: 292.h,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(25.r),
                    ),
                  ),
                  backgroundColor: AppColors.appGreenlight,
                  flexibleSpace: LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      controller.top.value = constraints.biggest.height;
                      return FlexibleSpaceBar(
                        centerTitle: true,
                        title: AnimatedOpacity(
                          opacity: controller.top <= 130 ? 1.0 : 0,
                          duration: const Duration(milliseconds: 200),
                          child: InkWell(
                            onTap: () {
                              Get.toNamed(Routes.STATUS);
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 15.w, right: 15.w),
                              width: double.infinity.w,
                              height: 40.h,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Image.asset(
                                      AppImage.iconsSend,
                                      width: 20.w,
                                      height: 20.h,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: Text(
                                      "Apa yang anda pikirkan?",
                                      style: GoogleFonts.quicksand(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[400],
                                          fontSize: 12.sp),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        background: Stack(
                          children: [
                            Container(
                              color: AppColors.appBgroudColors,
                              height: 350.h,
                            ),
                            TopHomeWidget(
                              controller: controller,
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SliverToBoxAdapter(
                  child: Obx(
                    () => controller.isLoading.isFalse
                        ? Column(
                            children: [
                              SizedBox(
                                height: 10.h,
                              ),
                              BarMenuWidget(controller: controller),
                              SizedBox(
                                height: 15.h,
                              ),
                              FutureBuilder<List<DataMapel>?>(
                                  future: controller.initMapel,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 15.w),
                                        width: double.infinity.w,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Materi By Pelajaran",
                                                        style: GoogleFonts
                                                            .quicksand(
                                                          color: const Color(
                                                              0xff155A5F),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14.sp,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Materi pembelajaran buat kamu belajar",
                                                        style: GoogleFonts
                                                            .quicksand(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 10.sp,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Showcase(
                                              key: controller.five,
                                              title: 'Semua Materi',
                                              description:
                                                  'Klik disini untuk melihat mata pelajaran yang kamu suka',
                                              titleTextStyle:
                                                  GoogleFonts.quicksand(
                                                      fontWeight:
                                                          FontWeight.bold),
                                              descTextStyle:
                                                  GoogleFonts.quicksand(
                                                fontSize: 12.sp,
                                              ),
                                              child: InkWell(
                                                onTap: () {
                                                  showModalBottomSheet(
                                                    isScrollControlled: true,
                                                    context: context,
                                                    shape: const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.vertical(
                                                                top: Radius
                                                                    .circular(
                                                                        10))),
                                                    builder: (context) =>
                                                        DraggableScrollableSheet(
                                                      initialChildSize: 0.4,
                                                      maxChildSize: 0.8,
                                                      minChildSize: 0.32,
                                                      expand: false,
                                                      builder: (context,
                                                              scrollController) =>
                                                          SingleChildScrollView(
                                                        controller:
                                                            scrollController,
                                                        child: PopUpAllMateri(
                                                          controller:
                                                              controller,
                                                          scrollController:
                                                              scrollController,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  height: 25.h,
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: Center(
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          "Lihat Semua ",
                                                          style: GoogleFonts
                                                              .quicksand(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: AppColors
                                                                .appGreenlight,
                                                            fontSize: 10.sp,
                                                          ),
                                                        ),
                                                        Image.asset(
                                                          AppImage.lihatSemua,
                                                          color: AppColors
                                                              .appGreenlight,
                                                          height: 6.h,
                                                          width: 6.w,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    }
                                    return const SizedBox();
                                  }),
                              SizedBox(
                                height: 10.h,
                              ),
                              GridMateriWidget(controller: controller),
                              FutureBuilder<List<DataKbm>?>(
                                  future: controller.initKbmVirtual,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Column(
                                        children: [
                                          SizedBox(
                                            height: 15.h,
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 15.w),
                                            width: double.infinity.w,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "KBM & Kelas Online",
                                                            style: GoogleFonts
                                                                .quicksand(
                                                              color: const Color(
                                                                  0xff155A5F),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 14.sp,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "Pelajari lebih awal materi / ikuti kelas online",
                                                            style: GoogleFonts
                                                                .quicksand(
                                                              color:
                                                                  Colors.grey,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 10.sp,
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
                                        ],
                                      );
                                    }
                                    return const SizedBox();
                                  }),
                              SizedBox(
                                height: 10.h,
                              ),
                              FutureBuilder<List<DataKbm>?>(
                                  future: controller.initKbmVirtual,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return KbmVirtualWidget(
                                        data: snapshot.data!,
                                        controller: controller,
                                      );
                                    }
                                    return const SizedBox();
                                  }),
                              FutureBuilder<List<Tugas>?>(
                                  future: controller.initTugas,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Column(
                                        children: [
                                          SizedBox(
                                            height: 15.h,
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 15.w),
                                            width: double.infinity.w,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "Tugas Aktif",
                                                            style: GoogleFonts
                                                                .quicksand(
                                                              color: const Color(
                                                                  0xff155A5F),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 14.sp,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "List tugas dan PR yang belum kamu kerjakan",
                                                            style: GoogleFonts
                                                                .quicksand(
                                                              color:
                                                                  Colors.grey,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 10.sp,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Showcase(
                                                  key: controller.six,
                                                  title: 'Semua Tugas',
                                                  description:
                                                      'Klik disini untuk memtatau tugas kamu',
                                                  titleTextStyle:
                                                      GoogleFonts.quicksand(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                  descTextStyle:
                                                      GoogleFonts.quicksand(
                                                    fontSize: 12.sp,
                                                  ),
                                                  child: InkWell(
                                                    onTap: () => Get.toNamed(
                                                        Routes.TUGAS),
                                                    child: Container(
                                                      height: 25.h,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      child: Center(
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              "Lihat Semua ",
                                                              style: GoogleFonts
                                                                  .quicksand(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: AppColors
                                                                    .appGreenlight,
                                                                fontSize: 10.sp,
                                                              ),
                                                            ),
                                                            Image.asset(
                                                              AppImage
                                                                  .lihatSemua,
                                                              color: AppColors
                                                                  .appGreenlight,
                                                              height: 6.h,
                                                              width: 6.w,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                    return const SizedBox();
                                  }),
                              SizedBox(
                                height: 10.h,
                              ),
                              TugasWidget(
                                controller: controller,
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              FutureBuilder<List<DataStatus>?>(
                                  future: controller.initStatus!,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 15.w),
                                        width: double.infinity.w,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Status Terbaru",
                                                        style: GoogleFonts
                                                            .quicksand(
                                                          color: const Color(
                                                              0xff155A5F),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14.sp,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Mini sosial media buat kamu ngobrol",
                                                        style: GoogleFonts
                                                            .quicksand(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 10.sp,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () =>
                                                  Get.toNamed(Routes.STATUS),
                                              child: Container(
                                                height: 25.h,
                                                padding:
                                                    const EdgeInsets.all(5),
                                                child: Center(
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "Lihat Semua ",
                                                        style: GoogleFonts
                                                            .quicksand(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: AppColors
                                                              .appGreenlight,
                                                          fontSize: 10.sp,
                                                        ),
                                                      ),
                                                      Image.asset(
                                                        AppImage.lihatSemua,
                                                        color: AppColors
                                                            .appGreenlight,
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
                                    return const SizedBox();
                                  }),
                              SizedBox(
                                height: 10.h,
                              ),
                              StatusWidget(
                                controller: controller,
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                            ],
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
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}

class KbmVirtualWidget extends StatelessWidget {
  const KbmVirtualWidget({
    Key? key,
    required this.data,
    required this.controller,
  }) : super(key: key);
  final List<DataKbm> data;
  final HomeController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 15.w,
      ),
      color: AppColors.appBgroudColors,
      height: 170.h,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(10))),
                builder: (context) => Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 10.h,
                  ),
                  height: 400.h,
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "MATERI KBM & KELAS ONLINE",
                                    style: GoogleFonts.quicksand(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.sp),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Materi pembalajaran yang akan diajarkan oleh guru kamu",
                                          style: GoogleFonts.quicksand(
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: ClipOval(
                                child: Container(
                                  height: 20.h,
                                  width: 20.w,
                                  color: Colors.red.withOpacity(0.3),
                                  child: const Icon(
                                    Icons.close,
                                    size: 15,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
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
                            Lottie.asset(
                              "assets/lotties/CJpaAM82Yv.json",
                              height: 40,
                              width: 40,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Pelajari lebih awal materi yang akan diajarkan dikelasmu (Luring), atau ikuti kelas Virtual yang dibuat gurumu (Daring). Kamu dapat meresume ulang kapan saja!",
                                      style: GoogleFonts.quicksand(
                                        color: AppColors.appGreenlight,
                                        fontWeight: FontWeight.bold,
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
                        height: 10.h,
                      ),
                      if (data[index].daftarMateri!.isNotEmpty)
                        Expanded(
                            child: SingleChildScrollView(
                          child: Column(
                            children: List.generate(
                                data[index].daftarMateri!.length, (i) {
                              final listDaftarMateri =
                                  data[index].daftarMateri![i];
                              return Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 10.h),
                                margin: EdgeInsets.only(bottom: 10.h),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                height: 70.h,
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 50.h,
                                      width: 50.w,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            data[index].photo!,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            listDaftarMateri.judul!,
                                            style: GoogleFonts.quicksand(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 10.sp,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            listDaftarMateri.mapel!,
                                            style: GoogleFonts.quicksand(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10.sp,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Material(
                                          color: AppColors.appGreenlight,
                                          borderRadius:
                                              BorderRadius.circular(5.r),
                                          child: InkWell(
                                            onTap: () {
                                              Get.back();
                                              Get.to(DetailMateriView(
                                                id: listDaftarMateri.id,
                                                idMapel: "",
                                                judul: listDaftarMateri.judul,
                                                icons: "",
                                                kelas: controller.kelas.value,
                                                topik: "KBM & Kelas Online",
                                                namaGuru: data[index].namaGuru,
                                                namaMapel:
                                                    data[index].namaPelajaran,
                                              ));
                                            },
                                            borderRadius:
                                                BorderRadius.circular(5.r),
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20.w),
                                              height: 30.h,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5.r),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Pelajari Sekarang",
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
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ),
                        )),
                      if (data[index].daftarMateri!.isEmpty)
                        Expanded(
                          child: SizedBox(
                            height: 400.h,
                            width: MediaQuery.of(context).size.width,
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
                                    "Tidak ada materi pembelajaran",
                                    style: GoogleFonts.quicksand(
                                      fontSize: 10.sp,
                                      color: AppColors.appGreenDrak,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                                onPressed: data[index].statusLive != "true"
                                    ? null
                                    : () => controller
                                        .launchURL(data[index].urlKbmLive!),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.appGreenlight,
                                ),
                                child: Center(
                                  child: Text(
                                    "Ikuti Kelas",
                                    style: GoogleFonts.quicksand(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.sp,
                                        color: Colors.white),
                                  ),
                                )),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.only(right: 10.w),
              width: 270.w,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 80.h,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(data[index].background!)),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.r),
                                topRight: Radius.circular(10.r))),
                      ),
                      Container(
                        height: 80.h,
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.2),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.r),
                                topRight: Radius.circular(10.r))),
                      ),
                      if (data[index].statusLive == "true")
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: 5.w,
                                vertical: 5.h,
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 5.h),
                              height: 20.h,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.r)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Lottie.asset("assets/lotties/inplay.json"),
                                  Text(
                                    "Live",
                                    style: GoogleFonts.quicksand(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10.sp,
                                        color: Colors.red),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      if (data[index].statusLive == "none")
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: 5.w,
                                vertical: 5.h,
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 5.h),
                              height: 20.h,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.r)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Lottie.asset(
                                    "assets/lotties/0UW5gtJ71x.json",
                                  ),
                                  Text(
                                    "Belum Dimulai",
                                    style: GoogleFonts.quicksand(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10.sp,
                                        color: Colors.red),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      if (data[index].statusLive == "False")
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: 5.w,
                                vertical: 5.h,
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 5.h),
                              height: 20.h,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.r)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "Telah Berakhir",
                                    style: GoogleFonts.quicksand(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10.sp,
                                        color: Colors.red),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 10.h, left: 10.w, right: 10.w),
                          child: Text(
                            data[index].judul!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.quicksand(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                              bottom: 5.h, left: 10.w, right: 10.w),
                          child: Text(
                            data[index].namaGuru!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.quicksand(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 10.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.w, right: 10.w),
                    child: Text(
                      "${DateFormat("EEEE, d MMMM yyyy", "id_ID").format(data[index].tanggalKbm!)} ",
                      style: GoogleFonts.quicksand(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 10.sp,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.w, right: 10.w),
                    child: Text(
                      "${data[index].jamMulai} - ${data[index].jamSelesai}",
                      style: GoogleFonts.quicksand(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 10.sp,
                      ),
                    ),
                  ),
                  if (data[index].statusLive == "none")
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 10.h,
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.w, vertical: 3.h),
                          decoration: BoxDecoration(
                              color: AppColors.appGreenlight.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(10.r)),
                          child: Text(
                            "Akan Datang",
                            style: GoogleFonts.quicksand(
                              color: AppColors.appGreenlight,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  if (data[index].statusLive == "true")
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 10.h,
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.w, vertical: 3.h),
                          decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(10.r)),
                          child: Text(
                            "Sedang Berlangsung",
                            style: GoogleFonts.quicksand(
                              color: Colors.red,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  if (data[index].statusLive == "False")
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 10.h,
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.w, vertical: 3.h),
                          decoration: BoxDecoration(
                              color: AppColors.appGreenlight.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(10.r)),
                          child: Text(
                            "Sudah Berakhir",
                            style: GoogleFonts.quicksand(
                              color: AppColors.appGreenlight,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class PopUpAllMateri extends StatelessWidget {
  const PopUpAllMateri({
    Key? key,
    required this.controller,
    required this.scrollController,
  }) : super(key: key);

  final HomeController controller;
  final ScrollController scrollController;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Semua Pelajaran",
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
                  backgroundColor: const Color(0xffF97276).withOpacity(0.6),
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
        SizedBox(
          height: 20.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: FutureBuilder<List<DataMapel>?>(
            future: controller.initMapelPopUp,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    final data = snapshot.data![index];
                    return GestureDetector(
                      onTap: () {
                        Get.back();
                        Get.to(ListMateriView(
                          mapel: data.nama,
                          icons: data.img,
                          id: data.id,
                          kelas: controller.kelas.value,
                        ));
                      },
                      child: SizedBox(
                        height: 70.h,
                        width: 70.w,
                        child: Column(
                          children: [
                            Image.network(
                              data.img!,
                              height: 60.h,
                              width: 60.w,
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    data.nama!,
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.quicksand(
                                        color: Colors.black, fontSize: 12.sp),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
              return Column(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Center(
                    child: SizedBox(
                      height: 20.h,
                      width: 20.w,
                      child: const CircularProgressIndicator(
                        color: Colors.amber,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
