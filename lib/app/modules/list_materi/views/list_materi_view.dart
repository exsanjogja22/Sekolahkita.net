import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../config/app_colors.dart';
import '../../../data/models/materi/materi_model.dart';
import '../../detail_materi/views/detail_materi_view.dart';
import '../controllers/list_materi_controller.dart';
import '../widget/search_widget.dart';

class ListMateriView extends StatelessWidget {
  const ListMateriView({Key? key, this.mapel, this.icons, this.id, this.kelas})
      : super(key: key);
  final String? id;
  final String? mapel;
  final String? icons;
  final String? kelas;
  @override
  Widget build(BuildContext context) {
    final ListMateriController controller = Get.put(ListMateriController());
    controller.getDataMateriSearch(id!);
    return Scaffold(
      backgroundColor: AppColors.appBgroudColors,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0.0),
        child: AppBar(
          backgroundColor: AppColors.appGreenlight,
          elevation: 0,
        ),
      ),
      body: SmartRefresher(
        controller: controller.refreshController,
        onRefresh: controller.onRefresh,
        onLoading: controller.onLoading,
        enablePullDown: true,
        enablePullUp: true,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              leading: Padding(
                padding: EdgeInsets.all(10.w),
                child: CircleAvatar(
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
              ),
              centerTitle: true,
              backgroundColor: AppColors.appGreenlight,
              pinned: true,
              expandedHeight: 175.0.h,
              flexibleSpace: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  controller.top.value = constraints.biggest.height;
                  return FlexibleSpaceBar(
                    background: Container(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: AppColors.gradientColors,
                        ),
                      ),
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
                                        delegate:
                                            DataSearchMateri(id, icons, kelas));
                                  },
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.w),
                                    height: 35.h,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20.r),
                                    ),
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
                                            color: AppColors.appGreenlight,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      mapel!,
                                      style: GoogleFonts.quicksand(
                                        fontSize: 16.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
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
                                Image.network(
                                  icons!,
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
                          mapel!,
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
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                height: 40.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Semua Topik ",
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                        color: AppColors.appGreenDrak,
                      ),
                    ),
                    Container(
                      height: 25.h,
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color(0xff6C99F6),
                      ),
                      child: Center(
                        child: GetBuilder<ListMateriController>(
                          id: 1,
                          builder: (_) {
                            return DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                hint: Text(
                                  'Pilih Topik',
                                  style: GoogleFonts.quicksand(
                                    color: AppColors.appColorWhite,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.sp,
                                  ),
                                ),
                                borderRadius: BorderRadius.circular(10),
                                underline: Container(),
                                dropdownColor: const Color(0xff6C99F6),
                                value: controller.selected,
                                items: controller.topik.map(
                                  (value) {
                                    return DropdownMenuItem<String>(
                                      value: value.id,
                                      child: Text(
                                        value.nama!.toTitleCase(),
                                        style: GoogleFonts.quicksand(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    );
                                  },
                                ).toList(),
                                icon: Icon(
                                  Icons.arrow_drop_down_outlined,
                                  size: 20.w,
                                  color: AppColors.appColorWhite,
                                ),
                                onChanged: (value) {
                                  controller.selected = value!;
                                  controller.listMateri.clear();
                                  controller.update([2]);
                                  controller.update([1]);
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: GetBuilder<ListMateriController>(
                id: 2,
                builder: (_) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 15.w),
                    width: MediaQuery.of(context).size.width,
                    child: FutureBuilder<List<ListMateri>?>(
                      future: controller.getDataMateri(id!),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data!.isNotEmpty) {
                            return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.symmetric(vertical: 10.w),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.w, vertical: 10.h),
                                  width: MediaQuery.of(context).size.width,
                                  height: 70.h,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 50.h,
                                        width: 50.w,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              snapshot
                                                  .data![index].guru!.photo!,
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
                                              snapshot.data![index].judul!
                                                  .toTitleCase(),
                                              style: GoogleFonts.quicksand(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 10.sp,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              snapshot
                                                  .data![index].guru!.namaGuru!
                                                  .toTitleCase(),
                                              style: GoogleFonts.quicksand(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10.sp,
                                                color: Colors.black,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10.w,
                                            ),
                                            if (snapshot.data![index].waktu!
                                                    .created ==
                                                snapshot.data![index].waktu!
                                                    .updated!)
                                              Text(
                                                "${DateFormat("d MMMM yyyy, hh:mm", "id_ID").format(snapshot.data![index].waktu!.created!)} WIB",
                                                style: GoogleFonts.quicksand(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 8.sp,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            if (snapshot.data![index].waktu!
                                                    .created !=
                                                snapshot.data![index].waktu!
                                                    .updated!)
                                              Text(
                                                "Update: ${DateFormat("d MMMM yyyy, hh:mm", "id_ID").format(snapshot.data![index].waktu!.created!)} WIB",
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Material(
                                            color: AppColors.appGreenlight,
                                            borderRadius:
                                                BorderRadius.circular(5.r),
                                            child: InkWell(
                                              onTap: () {
                                                Get.to(
                                                  DetailMateriView(
                                                    id: snapshot
                                                        .data![index].id,
                                                    idMapel: id,
                                                    judul: snapshot
                                                        .data![index].judul,
                                                    icons: icons,
                                                    kelas: kelas,
                                                    topik: controller
                                                        .topikDetail.value,
                                                    namaGuru: snapshot
                                                        .data![index]
                                                        .guru!
                                                        .namaGuru,
                                                    namaMapel: snapshot
                                                        .data![index]
                                                        .guru!
                                                        .namaPelajaran,
                                                  ),
                                                  transition:
                                                      Transition.rightToLeft,
                                                  duration: const Duration(
                                                      microseconds: 500),
                                                );
                                              },
                                              borderRadius:
                                                  BorderRadius.circular(5.r),
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20.w),
                                                height: 30.h,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.r),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "Detail",
                                                    style:
                                                        GoogleFonts.quicksand(
                                                      color: Colors.white,
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w700,
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
                            );
                          }
                          return SizedBox(
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
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}
