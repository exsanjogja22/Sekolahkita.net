import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_8.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../data/models/status/status_model.dart';
import '../../../routes/app_pages.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_image.dart';
import '../controllers/detail_status_controller.dart';

class DetailStatusView extends GetView<DetailStatusController> {
  const DetailStatusView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final data = Get.arguments[0] as DataStatus;
    return Scaffold(
      backgroundColor: AppColors.appBgroudColors,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0.h),
        child: AppBar(
          backgroundColor: AppColors.appGreenlight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(25.r),
            ),
          ),
          title: Text(
            'Post',
            style: GoogleFonts.quicksand(
              color: AppColors.appColorWhite,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.all(13),
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
        ),
      ),
      body: Container(
        width: double.infinity,
        color: AppColors.appBgroudColors,
        child: SingleChildScrollView(
            child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20.r,
                          backgroundColor: AppColors.appColorWhite,
                          backgroundImage: NetworkImage(data.img!),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Text(
                                          data.nama!.toTitleCase(),
                                          style: GoogleFonts.quicksand(
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xff505764),
                                            fontSize: 10.sp,
                                          ),
                                        ),
                                        if (data.tipe == "pengumuman")
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                        if (data.tipe == "pengumuman")
                                          Image.asset(
                                            "assets/icons/check.png",
                                            height: 15.h,
                                            width: 15.w,
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
                                      "${DateFormat("d MMMM yyyy, hh:mm Wib ", "id_ID").format(data.tanggal!)} ",
                                      style: GoogleFonts.quicksand(
                                          color: const Color(0xffD2D3D9),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(10))),
                              builder: (context) => const PopupPengaturan(),
                            );
                          },
                          child: const Icon(
                            Icons.more_vert,
                            color: Colors.grey,
                            size: 20,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  if (data.judul != "null")
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                            data.judul!,
                            style: GoogleFonts.quicksand(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.appColorBlack,
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
                    margin: EdgeInsets.symmetric(horizontal: 10.w),
                    child: HtmlWidget(
                      data.detail!.replaceAll("null", ""),
                      textStyle: GoogleFonts.quicksand(
                        color: const Color(0xff676767),
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
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
                                  style: GoogleFonts.quicksand(
                                      fontSize: 10.sp, color: Colors.grey),
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
                                    AppImage.iconKomentar,
                                    height: 10.h,
                                    width: 10.w,
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                    data.komencount.toString(),
                                    style: GoogleFonts.quicksand(
                                        fontSize: 10.sp, color: Colors.grey),
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
            SizedBox(
              height: 10.h,
            ),
            Container(
                width: double.infinity,
                height: 60.h,
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                ),
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Obx(
                  () => Row(
                    children: [
                      if (controller.photo.value == "")
                        CircleAvatar(
                          radius: 20.r,
                          backgroundColor: AppColors.appColorWhite,
                          backgroundImage: const AssetImage(AppImage.profile),
                        ),
                      if (controller.photo.value != "")
                        CircleAvatar(
                          radius: 20.r,
                          backgroundColor: AppColors.appColorWhite,
                          backgroundImage: NetworkImage(controller.photo.value),
                        ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Get.toNamed(Routes.KOMENTAR_STATUS,
                                arguments: [data]);
                          },
                          child: Container(
                            height: 40.h,
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30.r),
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.3),
                              ),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  "Tulis komentar anda.....",
                                  style: GoogleFonts.quicksand(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xff747474),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Image.asset(
                        AppImage.iconsSend,
                        width: 40.w,
                        height: 40.h,
                      ),
                    ],
                  ),
                )),
            SizedBox(
              height: 15.h,
            ),
            GetBuilder<DetailStatusController>(builder: (_) {
              return FutureBuilder(
                future:
                    controller.getDataKomentar(data.id!.toString(), data.tipe!),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final dataKomen = snapshot.data![index];
                        return Container(
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(horizontal: 15.w),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 20.r,
                                    backgroundColor:
                                        Colors.grey.withOpacity(0.3),
                                    backgroundImage: NetworkImage(
                                      dataKomen.photo!,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Expanded(
                                      child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              dataKomen.komentarNama!,
                                              style: GoogleFonts.quicksand(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 10.sp,
                                                color: const Color(0xff505764),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 3.h,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            height: 10.h,
                                            width: 40.w,
                                            decoration: BoxDecoration(
                                              color: const Color(0xffFCC800),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Center(
                                              child: Text(
                                                dataKomen.source!,
                                                style: GoogleFonts.quicksand(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 8.sp,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ))
                                ],
                              ),
                              Column(
                                children: [
                                  Obx(() => ChatBubble(
                                        clipper: dataKomen.komentarNama ==
                                                controller.namaSiswa.value
                                            ? ChatBubbleClipper8(
                                                type: BubbleType.sendBubble)
                                            : ChatBubbleClipper8(
                                                type:
                                                    BubbleType.receiverBubble),
                                        alignment: dataKomen.komentarNama ==
                                                controller.namaSiswa.value
                                            ? Alignment.topRight
                                            : Alignment.topLeft,
                                        margin: EdgeInsets.only(top: 20.h),
                                        backGroundColor:
                                            dataKomen.komentarNama ==
                                                    controller.namaSiswa.value
                                                ? const Color(0xff08b197)
                                                : Colors.white,
                                        child: Container(
                                          constraints: BoxConstraints(
                                            maxWidth: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.7,
                                          ),
                                          child: Column(
                                            children: [
                                              Text(
                                                dataKomen.komentarIsi!,
                                                style: GoogleFonts.quicksand(
                                                    fontSize: 10.sp,
                                                    color: dataKomen
                                                                .komentarNama ==
                                                            controller
                                                                .namaSiswa.value
                                                        ? Colors.white
                                                        : Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 10.h),
                                    child: Row(
                                      mainAxisAlignment:
                                          dataKomen.komentarNama ==
                                                  controller.namaSiswa.value
                                              ? MainAxisAlignment.end
                                              : MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          dataKomen.komentarTanggal!,
                                          style: GoogleFonts.quicksand(
                                              fontSize: 10.sp,
                                              color: Colors.black),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    if (kDebugMode) {
                      print(snapshot.error);
                    }
                  }
                  return Center(
                    child: ClipOval(
                      child: Container(
                        height: 40.h,
                        width: 40.w,
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.h, vertical: 10.h),
                        child: const CircularProgressIndicator(
                          color: AppColors.appGreenlight,
                        ),
                      ),
                    ),
                  );
                },
              );
            })
          ],
        )),
      ),
    );
  }
}

class PopupPengaturan extends StatelessWidget {
  const PopupPengaturan({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180.h,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Pengaturan Post",
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
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey)),
            child: ListTile(
              onTap: () {
                Get.back();
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(10.r))),
                  builder: (context) => DraggableScrollableSheet(
                    initialChildSize: 0.4,
                    maxChildSize: 0.8,
                    minChildSize: 0.32,
                    expand: false,
                    builder: (context, scrollController) =>
                        SingleChildScrollView(
                            controller: scrollController,
                            child: Column(children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 10.h),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Laporkan",
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
                                        backgroundColor: const Color(0xffF97276)
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
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 15.w, vertical: 5.h),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.grey)),
                                child: ListTile(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.r)),
                                        title: Text(
                                          'Info',
                                          style: GoogleFonts.quicksand(
                                              color: Colors.black,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        content: Text(
                                          'Anda yakin ingin mengajukan pelaporan ?',
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
                                              Get.back();
                                              Get.back();
                                              Get.snackbar("Berhasil",
                                                  "Laporan Anda akan direspon dalam 2x 24 jam",
                                                  snackPosition:
                                                      SnackPosition.BOTTOM,
                                                  colorText:
                                                      AppColors.appGreenlight,
                                                  backgroundColor: AppColors
                                                      .appGreenlight
                                                      .withOpacity(0.4));
                                            },
                                            child: Text(
                                              'OK',
                                              style: GoogleFonts.quicksand(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  title: Text(
                                    "Menganding unsur Suku, Agama, Ras, dan Antargolongan",
                                    style: GoogleFonts.quicksand(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 15.h, vertical: 5.w),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.grey)),
                                child: ListTile(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.r)),
                                        title: Text(
                                          'Info',
                                          style: GoogleFonts.quicksand(
                                              color: Colors.black,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        content: Text(
                                          'Anda yakin ingin mengajukan pelaporan ?',
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
                                              Get.back();
                                              Get.back();
                                              Get.snackbar("Berhasil",
                                                  "Laporan Anda akan direspon dalam 2x 24 jam",
                                                  snackPosition:
                                                      SnackPosition.BOTTOM,
                                                  colorText:
                                                      AppColors.appGreenlight,
                                                  backgroundColor: AppColors
                                                      .appGreenlight
                                                      .withOpacity(0.4));
                                            },
                                            child: Text(
                                              'OK',
                                              style: GoogleFonts.quicksand(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  title: Text(
                                    "Mengandiung unsur HOAX",
                                    style: GoogleFonts.quicksand(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 15.w, vertical: 5.h),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.grey)),
                                child: ListTile(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.r)),
                                        title: Text(
                                          'Info',
                                          style: GoogleFonts.quicksand(
                                              color: Colors.black,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        content: Text(
                                          'Anda yakin ingin mengajukan pelaporan ?',
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
                                              Get.back();
                                              Get.back();
                                              Get.snackbar("Berhasil",
                                                  "Laporan Anda akan direspon dalam 2x 24 jam",
                                                  snackPosition:
                                                      SnackPosition.BOTTOM,
                                                  colorText:
                                                      AppColors.appGreenlight,
                                                  backgroundColor: AppColors
                                                      .appGreenlight
                                                      .withOpacity(0.4));
                                            },
                                            child: Text(
                                              'OK',
                                              style: GoogleFonts.quicksand(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  title: Text(
                                    "Melanggar penulisan postingan karena melanggar aturan",
                                    style: GoogleFonts.quicksand(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 15.w, vertical: 5.h),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.grey)),
                                child: ListTile(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.r)),
                                        title: Text(
                                          'Info',
                                          style: GoogleFonts.quicksand(
                                              color: Colors.black,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        content: Text(
                                          'Anda yakin ingin mengajukan pelaporan ?',
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
                                              Get.back();
                                              Get.back();
                                              Get.snackbar("Berhasil",
                                                  "Laporan Anda akan direspon dalam 2x 24 jam",
                                                  snackPosition:
                                                      SnackPosition.BOTTOM,
                                                  colorText:
                                                      AppColors.appGreenlight,
                                                  backgroundColor: AppColors
                                                      .appGreenlight
                                                      .withOpacity(0.4));
                                            },
                                            child: Text(
                                              'OK',
                                              style: GoogleFonts.quicksand(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  title: Text(
                                    "Blokir user ini",
                                    style: GoogleFonts.quicksand(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )
                            ])),
                  ),
                );
              },
              leading: const Icon(
                Icons.flag_rounded,
                color: Colors.grey,
                size: 25,
              ),
              title: Text(
                "Laporkan",
                style: GoogleFonts.quicksand(
                    fontSize: 12.sp, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey)),
            child: ListTile(
              onTap: () {
                Get.back();
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(10.r))),
                  builder: (context) => DraggableScrollableSheet(
                    initialChildSize: 0.4,
                    maxChildSize: 0.8,
                    minChildSize: 0.32,
                    expand: false,
                    builder: (context, scrollController) =>
                        SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 10.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Laporkan ke sekolah",
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
                                    backgroundColor: const Color(0xffF97276)
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
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 15.w, vertical: 5.h),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(color: Colors.grey)),
                            child: ListTile(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.r)),
                                    title: Text(
                                      'Info',
                                      style: GoogleFonts.quicksand(
                                          color: Colors.black,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    content: Text(
                                      'Anda yakin ingin mengajukan pelaporan ?',
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
                                          Get.back();
                                          Get.back();
                                          Get.snackbar("Berhasil",
                                              "Laporan Anda akan direspon dalam 2x 24 jam",
                                              snackPosition:
                                                  SnackPosition.BOTTOM,
                                              colorText:
                                                  AppColors.appGreenlight,
                                              backgroundColor: AppColors
                                                  .appGreenlight
                                                  .withOpacity(0.4));
                                        },
                                        child: Text(
                                          'OK',
                                          style: GoogleFonts.quicksand(),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              title: Text(
                                "Menganding unsur kekerasan, obat-obat terlarang dan sex bebas",
                                style: GoogleFonts.quicksand(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 15.w, vertical: 5.h),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(color: Colors.grey)),
                            child: ListTile(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.r)),
                                    title: Text(
                                      'Info',
                                      style: GoogleFonts.quicksand(
                                          color: Colors.black,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    content: Text(
                                      'Anda yakin ingin mengajukan pelaporan ?',
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
                                          Get.back();
                                          Get.back();
                                          Get.snackbar("Berhasil",
                                              "Laporan Anda akan direspon dalam 2x 24 jam",
                                              snackPosition:
                                                  SnackPosition.BOTTOM,
                                              colorText:
                                                  AppColors.appGreenlight,
                                              backgroundColor: AppColors
                                                  .appGreenlight
                                                  .withOpacity(0.4));
                                        },
                                        child: Text(
                                          'OK',
                                          style: GoogleFonts.quicksand(),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              title: Text(
                                "Mengandiung unsur kata tidak pantas",
                                style: GoogleFonts.quicksand(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 15.w, vertical: 5.h),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(color: Colors.grey)),
                            child: ListTile(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.r)),
                                    title: Text(
                                      'Info',
                                      style: GoogleFonts.quicksand(
                                          color: Colors.black,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    content: Text(
                                      'Anda yakin ingin mengajukan pelaporan ?',
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
                                          Get.back();
                                          Get.back();
                                          Get.snackbar("Berhasil",
                                              "Laporan Anda akan direspon dalam 2x 24 jam",
                                              snackPosition:
                                                  SnackPosition.BOTTOM,
                                              colorText:
                                                  AppColors.appGreenlight,
                                              backgroundColor: AppColors
                                                  .appGreenlight
                                                  .withOpacity(0.4));
                                        },
                                        child: Text(
                                          'OK',
                                          style: GoogleFonts.quicksand(),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              title: Text(
                                "Mengandung unsur bullying",
                                style: GoogleFonts.quicksand(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              leading: const Icon(
                Icons.flag_rounded,
                color: Colors.grey,
                size: 25,
              ),
              title: Text(
                "Laporkan ke sekolah",
                style: GoogleFonts.quicksand(
                    fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
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
