import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_image.dart';
import '../bindings/akun_saya_binding.dart';
import '../controllers/akun_saya_controller.dart';
import 'agama_view.dart';
import 'alamat_asli_view.dart';
import 'alamat_tinggal_view.dart';
import 'email_view.dart';
import 'jenis_kelamin_view.dart';
import 'tanggal_lahir_view.dart';
import 'telepon_view.dart';
import 'tempat_lahir_view.dart';

class AkunSayaView extends GetView<AkunSayaController> {
  const AkunSayaView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final kelas = Get.arguments[0];
    return Scaffold(
        backgroundColor: AppColors.appBgroudColors,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.appBarColors,
          title: Text(
            'Akun Saya',
            style: GoogleFonts.quicksand(
              fontSize: 18.sp,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: SizedBox(
          height: Get.height,
          width: Get.width,
          child: SingleChildScrollView(
            child: Obx(
              () => Column(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: 120.h,
                        width: Get.width,
                      ),
                      Container(
                        width: Get.width,
                        height: 70.h,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: AppColors.gradientColors,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        top: 10,
                        child: CircleAvatar(
                          radius: 50.w,
                          backgroundColor: Colors.white,
                          child: controller.photo.value != ""
                              ? Stack(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(controller.photo.value),
                                      radius: 45.w,
                                      backgroundColor: Colors.grey,
                                    ),
                                    if (controller.isLoadingImg.isTrue)
                                      const CircleAvatar(
                                        radius: 45,
                                        backgroundColor: Colors.transparent,
                                        child: SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                              color: Colors.white),
                                        ),
                                      )
                                  ],
                                )
                              : CircleAvatar(
                                  backgroundImage:
                                      const AssetImage(AppImage.profile),
                                  radius: 45.w,
                                  backgroundColor: Colors.grey,
                                ),
                        ),
                      ),
                      Positioned(
                        right: 125.w,
                        top: 80.h,
                        child: ClipOval(
                          child: Material(
                            color: AppColors.appGreenlight,
                            child: InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(10))),
                                  builder: (context) => Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15.w, vertical: 15.h),
                                    color: AppColors.appBgroudColors,
                                    height: 120,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Foto Profil",
                                          style: GoogleFonts.quicksand(
                                            color: AppColors.appGreenDrak,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Row(
                                          children: [
                                            Column(
                                              children: [
                                                ClipOval(
                                                  child: Material(
                                                    color: Colors.white,
                                                    child: InkWell(
                                                      onTap: () => controller
                                                          .selectImage(
                                                              ImageSource
                                                                  .camera),
                                                      child: SizedBox(
                                                        height: 40.h,
                                                        width: 40.w,
                                                        child: Center(
                                                            child: Icon(
                                                          Icons
                                                              .camera_alt_rounded,
                                                          color: AppColors
                                                              .appGreenlight,
                                                          size: 20.w,
                                                        )),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  "Kamera",
                                                  style: GoogleFonts.quicksand(
                                                    color:
                                                        AppColors.appGreenDrak,
                                                    fontSize: 12,
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              width: 20.w,
                                            ),
                                            Column(
                                              children: [
                                                ClipOval(
                                                  child: Material(
                                                    color: Colors.white,
                                                    child: InkWell(
                                                      onTap: () => controller
                                                          .selectImage(
                                                              ImageSource
                                                                  .gallery),
                                                      child: SizedBox(
                                                        height: 40.h,
                                                        width: 40.w,
                                                        child: Center(
                                                          child: Icon(
                                                            Icons.image,
                                                            color: AppColors
                                                                .appGreenlight,
                                                            size: 20.w,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  "Galeri",
                                                  style: GoogleFonts.quicksand(
                                                    color:
                                                        AppColors.appGreenDrak,
                                                    fontSize: 12,
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
                              child: SizedBox(
                                height: 40.h,
                                width: 40.w,
                                child: Center(
                                    child: Icon(
                                  Icons.camera_alt_rounded,
                                  color: Colors.white,
                                  size: 20.w,
                                )),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        controller.nama.value.toTitleCase(),
                        style: GoogleFonts.quicksand(
                          fontSize: 16.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Container(
                        width: 130.w,
                        padding: EdgeInsets.symmetric(vertical: 5.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: AppColors.appGreenlight.withOpacity(0.4),
                        ),
                        child: Center(
                          child: Text(
                            kelas,
                            style: GoogleFonts.quicksand(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.sp,
                              color: AppColors.appGreenlight,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Text(
                          'Akun',
                          style: GoogleFonts.quicksand(
                            color: const Color(0xff155A5F),
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: const Divider(
                          color: Colors.grey,
                          height: 4,
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Nama Lengkap",
                          style: GoogleFonts.quicksand(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                          ),
                        ),
                        subtitle: Text(
                          controller.nama.value.toTitleCase(),
                          style: GoogleFonts.quicksand(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Get.to(EmailView(controller.email.value),
                              transition: Transition.rightToLeft,
                              binding: AkunSayaBinding());
                        },
                        title: Text(
                          "Email",
                          style: GoogleFonts.quicksand(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                          ),
                        ),
                        subtitle: Text(
                          controller.email.value.toString(),
                          style: GoogleFonts.quicksand(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 15.w,
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Get.to(TempatLahirView(controller.tempatLahir.value),
                              transition: Transition.rightToLeft,
                              binding: AkunSayaBinding());
                        },
                        title: Text(
                          "Tempat Lahir",
                          style: GoogleFonts.quicksand(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                          ),
                        ),
                        subtitle: Text(
                          controller.tempatLahir.value.toTitleCase(),
                          style: GoogleFonts.quicksand(
                            color: Colors.black,
                            fontSize: 12.sp,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 15.w,
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Get.to(
                              TanggalLahirView(controller.tanggalLahir1.value),
                              transition: Transition.rightToLeft,
                              binding: AkunSayaBinding());
                        },
                        title: Text(
                          "Tanggal Lahir",
                          style: GoogleFonts.quicksand(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                          ),
                        ),
                        subtitle: Text(
                          controller.tanggalLahir.value,
                          style: GoogleFonts.quicksand(
                            color: Colors.black,
                            fontSize: 12.sp,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 15.w,
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Get.to(const JenisKelaminView(),
                              transition: Transition.rightToLeft,
                              binding: AkunSayaBinding());
                        },
                        title: Text(
                          "Jenis Kelamin",
                          style: GoogleFonts.quicksand(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                          ),
                        ),
                        subtitle: Text(
                          controller.jenisKelamin.value,
                          style: GoogleFonts.quicksand(
                            color: Colors.black,
                            fontSize: 12.sp,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 15.w,
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Get.to(const AgamaView(),
                              transition: Transition.rightToLeft,
                              binding: AkunSayaBinding());
                        },
                        title: Text(
                          "Agama",
                          style: GoogleFonts.quicksand(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                          ),
                        ),
                        subtitle: Text(
                          controller.agama.value,
                          style: GoogleFonts.quicksand(
                            color: Colors.black,
                            fontSize: 12.sp,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 15.w,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: const Divider(
                          color: Colors.grey,
                          height: 4,
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Get.to(const AlamatAsliView(),
                              transition: Transition.rightToLeft,
                              binding: AkunSayaBinding());
                        },
                        title: Text(
                          "Alamat Asli",
                          style: GoogleFonts.quicksand(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                          ),
                        ),
                        subtitle: Text(
                          controller.alamatAsli.value,
                          style: GoogleFonts.quicksand(
                            color: Colors.black,
                            fontSize: 12.sp,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 15.w,
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Get.to(const AlamatTinggaView(),
                              transition: Transition.rightToLeft,
                              binding: AkunSayaBinding());
                        },
                        title: Text(
                          "Alamat Tinggal",
                          style: GoogleFonts.quicksand(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                          ),
                        ),
                        subtitle: Text(
                          controller.alamatTinggal.value,
                          style: GoogleFonts.quicksand(
                            color: Colors.black,
                            fontSize: 12.sp,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 15.w,
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Get.to(TeleponView(controller.phone.value),
                              transition: Transition.rightToLeft,
                              binding: AkunSayaBinding());
                        },
                        title: Text(
                          "Telepon",
                          style: GoogleFonts.quicksand(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                          ),
                        ),
                        subtitle: Text(
                          controller.phone.value,
                          style: GoogleFonts.quicksand(
                            color: Colors.black,
                            fontSize: 12.sp,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 15.w,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
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
