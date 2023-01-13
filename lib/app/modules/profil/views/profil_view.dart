import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:smkn1contoh/app/config/app_image.dart';
import 'package:smkn1contoh/app/config/app_sisze.dart';
import '../../../config/app_colors.dart';
import '../../../routes/app_pages.dart';
import '../controllers/profil_controller.dart';

class ProfilView extends GetView<ProfilController> {
  const ProfilView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: AppColors.appBgroudColors,
      body: Obx(
        () => Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: AppColors.appGreenlight,
                  centerTitle: true,
                  pinned: true,
                  expandedHeight: 250.h,
                  leading: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                  flexibleSpace: LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      controller.top.value = constraints.biggest.height;
                      return FlexibleSpaceBar(
                          centerTitle: true,
                          title: AnimatedOpacity(
                            opacity: controller.top <= 130 ? 1.0 : 0,
                            duration: const Duration(milliseconds: 200),
                            child: Text(
                              "My Status",
                              style: GoogleFonts.quicksand(
                                color: AppColors.appColorWhite,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.sp,
                              ),
                            ),
                          ),
                          background: Obx(
                            () => Stack(
                              children: [
                                Container(
                                  height: 280.h,
                                  color: AppColors.appBgroudColors,
                                ),
                                Container(
                                  height: 280.h,
                                  decoration: const BoxDecoration(
                                    color: AppColors.appBgroudColors,
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 70.h,
                                      ),
                                      Image.asset(
                                          "assets/images/1644646893.png")
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 100.h,
                                  padding: EdgeInsets.only(
                                      top:
                                          MediaQuery.of(context).padding.top.h),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(25.r),
                                        bottomRight: Radius.circular(25.r)),
                                    gradient: const LinearGradient(
                                      colors: AppColors.gradientColors,
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 18.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Profil",
                                            style: GoogleFonts.quicksand(
                                              color: AppColors.appColorWhite,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  left: 0.w,
                                  right: 0.w,
                                  top: 120.h,
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                          radius: 53.r,
                                          backgroundColor:
                                              AppColors.appColorWhite,
                                          child: controller.photo.value != ""
                                              ? CircleAvatar(
                                                  radius: 50.r,
                                                  backgroundColor:
                                                      AppColors.appColorWhite,
                                                  backgroundImage: NetworkImage(
                                                      controller.photo.value),
                                                )
                                              : CircleAvatar(
                                                  radius: 50.r,
                                                  backgroundColor:
                                                      AppColors.appColorWhite,
                                                  backgroundImage:
                                                      const AssetImage(
                                                          AppImage.profile),
                                                )),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Text(
                                        controller.namaSiswa.value
                                            .toTitleCase(),
                                        style: GoogleFonts.quicksand(
                                          fontSize: 15.sp,
                                          color: AppColors.appColorBlack,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "X perhotalan 1",
                                        style: GoogleFonts.quicksand(
                                          fontSize: 15.sp,
                                          color: AppColors.appColorBlack,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ));
                    },
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 10.h),
                            height: 60.h,
                            decoration: BoxDecoration(
                              color: AppColors.appColorWhite,
                              border: Border.all(
                                width: 1.0,
                                color: Colors.grey.withOpacity(0.3),
                              ),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "25",
                                      style: GoogleFonts.quicksand(
                                        color: AppColors.appGreenlight,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                    Text(
                                      "Post",
                                      style: GoogleFonts.quicksand(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.sp,
                                      ),
                                    )
                                  ],
                                ),
                                Container(
                                  color: Colors.grey.withOpacity(0.7),
                                  width: 2.w,
                                  height: double.infinity,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "8",
                                      style: GoogleFonts.quicksand(
                                        color: AppColors.appGreenlight,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                    Text(
                                      "Foto",
                                      style: GoogleFonts.quicksand(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.sp,
                                      ),
                                    )
                                  ],
                                ),
                                Container(
                                  color: Colors.grey.withOpacity(0.7),
                                  width: 2.w,
                                  height: double.infinity,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "10",
                                      style: GoogleFonts.quicksand(
                                        color: AppColors.appGreenlight,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                    Text(
                                      "Pengumuman",
                                      style: GoogleFonts.quicksand(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.sp,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Material(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10.r),
                            onTap: () {},
                            child: Container(
                              height: 60.h,
                              width: 60.w,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1.0,
                                  color: Colors.grey.withOpacity(0.3),
                                ),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Center(
                                child: Image.asset(
                                  AppImage.iconSettings,
                                  height: 25.h,
                                  width: 25.w,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: InkWell(
                    onTap: () => Get.toNamed(Routes.ADD_SATATUS),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 15.w),
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: AppColors.appColorWhite,
                        border: Border.all(
                          width: 1.0,
                          color: Colors.grey.withOpacity(0.3),
                        ),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 5.w,
                                vertical: 5.h,
                              ),
                              child: Image.asset(
                                AppImage.iconsSend,
                                height: 20.h,
                                width: 20.w,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Row(
                              children: [
                                Text(
                                  "Apa yang anda pikirkan?",
                                  style: GoogleFonts.quicksand(
                                      color: Colors.grey, fontSize: 12.sp),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                    child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Obx(
                    () => controller.listStatus.isNotEmpty
                        ? ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.listStatus.length,
                            itemBuilder: (context, index) {
                              final data = controller.listStatus[index];
                              return Padding(
                                padding: EdgeInsets.only(
                                  bottom: 10.h,
                                ),
                                child: Material(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.r),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(10.r),
                                    onTap: () => Get.toNamed(
                                        Routes.DETAIL_STATUS,
                                        arguments: [data]),
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10.h),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.r)),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.w),
                                            child: Row(
                                              children: [
                                                CircleAvatar(
                                                  radius: 20.r,
                                                  backgroundColor:
                                                      AppColors.appColorWhite,
                                                  backgroundImage:
                                                      NetworkImage(data.img!),
                                                ),
                                                SizedBox(
                                                  width: 10.w,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                  data.nama!
                                                                      .toTitleCase(),
                                                                  style: GoogleFonts
                                                                      .quicksand(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        10.sp,
                                                                  ),
                                                                ),
                                                                if (data.tipe ==
                                                                    "pengumuman")
                                                                  SizedBox(
                                                                    width: 10.w,
                                                                  ),
                                                                if (data.tipe ==
                                                                    "pengumuman")
                                                                  Image.asset(
                                                                    "assets/icons/check.png",
                                                                    height: 15,
                                                                    width: 15,
                                                                  )
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              "${DateFormat("d MMMM yyyy, hh:mm Wib", "id_ID").format(data.tanggal!)} ",
                                                              style: GoogleFonts
                                                                  .quicksand(
                                                                      color: Colors
                                                                          .grey,
                                                                      fontSize:
                                                                          10),
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
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          if (data.judul != "null")
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.w),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                      child: Text(
                                                    data.judul!,
                                                    style:
                                                        GoogleFonts.quicksand(
                                                      fontSize: 10.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: AppColors
                                                          .appColorBlack,
                                                    ),
                                                  )),
                                                ],
                                              ),
                                            ),
                                          if (data.judul != "null")
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                          Container(
                                            width: double.infinity,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 10.w),
                                            child: HtmlWidget(
                                              data.detail!
                                                  .replaceAll("null", ""),
                                              textStyle: GoogleFonts.quicksand(
                                                fontSize: 10.sp,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Container(
                                            height: 1.h,
                                            width: double.infinity,
                                            color: Colors.grey.withOpacity(0.4),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.w,
                                                vertical: 10.h),
                                            width: double.infinity,
                                            child: Row(
                                              children: [
                                                Row(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Image.asset(
                                                          AppImage.iconLike,
                                                          height: 10.h,
                                                          width: 10.w,
                                                        ),
                                                        SizedBox(
                                                          width: 5.w,
                                                        ),
                                                        Text(
                                                          "0 like",
                                                          style: GoogleFonts
                                                              .quicksand(
                                                                  fontSize:
                                                                      10.sp,
                                                                  color: Colors
                                                                      .grey),
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      width: 10.w,
                                                    ),
                                                    InkWell(
                                                      child: Row(
                                                        children: [
                                                          Image.asset(
                                                            AppImage
                                                                .iconKomentar,
                                                            height: 10.h,
                                                            width: 10.w,
                                                          ),
                                                          SizedBox(
                                                            width: 5.w,
                                                          ),
                                                          Text(
                                                            data.komencount
                                                                .toString(),
                                                            style: GoogleFonts
                                                                .quicksand(
                                                                    fontSize:
                                                                        10.sp,
                                                                    color: Colors
                                                                        .grey),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        : Column(
                            children: [
                              SizedBox(
                                height: 20.h,
                              ),
                              ClipOval(
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  color: Colors.white,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.h, vertical: 10.h),
                                  child: const CircularProgressIndicator(
                                    color: AppColors.appGreenlight,
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ),
                ))
              ],
            ),
            if (controller.isLoading.isTrue)
              Container(
                height: SizeConfig.screenHeight,
                width: SizeConfig.screenWidth,
                color: Colors.black.withOpacity(0.7),
                child: Center(
                  child: SizedBox(
                    height: 200.h,
                    width: 200.w,
                    child: Lottie.asset(
                      "assets/lotties/28896-pen-and-book.json",
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

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}
