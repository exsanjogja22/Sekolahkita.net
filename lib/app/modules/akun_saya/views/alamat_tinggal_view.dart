import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/app_colors.dart';
import '../controllers/alamat_tinggal_controller.dart';

class AlamatTinggaView extends GetView<AlamatTinggalController> {
  const AlamatTinggaView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.appBarColors,
        title: Text(
          'Ubah Alamat Tinggal',
          style: GoogleFonts.quicksand(
            fontSize: 18.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              controller.updateProfil(context);
            },
            child: Text(
              "Ubah",
              style:
                  GoogleFonts.quicksand(color: Colors.white, fontSize: 14.sp),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 10.w, right: 10.w),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              height: 50.h,
              child: Row(mainAxisSize: MainAxisSize.max, children: [
                GetBuilder<AlamatTinggalController>(builder: (_) {
                  return DropdownButton(
                    underline: Container(),
                    elevation: 16,
                    value: controller.selecteProvinsi,
                    hint: SizedBox(
                      width: MediaQuery.of(context).size.width - 44.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Pilih Provinsi'),
                          if (controller.isLoadingProvinsi.isTrue)
                            SizedBox(
                                height: 20.h,
                                width: 20.w,
                                child: const CircularProgressIndicator(
                                  color: AppColors.appGreenlight,
                                ))
                        ],
                      ),
                    ),
                    style: GoogleFonts.quicksand(
                      color: Colors.grey,
                      fontSize: 12.sp,
                    ),
                    items: controller.listProvinsi
                        .map(
                          (list) => DropdownMenuItem(
                            value: list.id.toString(),
                            child: Text(
                              list.nama!,
                              style: GoogleFonts.quicksand(
                                color: Colors.black,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      controller.selecteProvinsi = value.toString();
                      controller.listKabupatenKota.clear();
                      controller.kabupatenKota(value.toString());
                      controller.update();
                    },
                  );
                }),
              ]),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              padding: EdgeInsets.only(left: 10.w, right: 10.w),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              height: 50.h,
              child: Row(mainAxisSize: MainAxisSize.max, children: [
                GetBuilder<AlamatTinggalController>(builder: (_) {
                  return DropdownButton(
                    underline: Container(),
                    elevation: 16,
                    value: controller.selecteKabupaten,
                    hint: SizedBox(
                      width: MediaQuery.of(context).size.width - 44.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Pilih Kota/Kabupaten'),
                          if (controller.isLoadingKabupatenKoata.isTrue)
                            SizedBox(
                                height: 20.h,
                                width: 20.w,
                                child: const CircularProgressIndicator(
                                    color: AppColors.appGreenlight))
                        ],
                      ),
                    ),
                    style: GoogleFonts.quicksand(
                        color: Colors.grey, fontSize: 12.sp),
                    items: controller.listKabupatenKota
                        .map(
                          (list) => DropdownMenuItem(
                            value: list.id.toString(),
                            child: Text(
                              list.nama!,
                              style: GoogleFonts.quicksand(
                                color: Colors.black,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      controller.selecteKabupaten = value.toString();
                      controller.listKecamatanKota.clear();
                      controller.kecamatanKota(value.toString());
                      controller.update();
                    },
                  );
                }),
              ]),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              padding: EdgeInsets.only(left: 10.w, right: 10.w),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              height: 50.h,
              child: Row(mainAxisSize: MainAxisSize.max, children: [
                GetBuilder<AlamatTinggalController>(builder: (_) {
                  return DropdownButton(
                    underline: Container(),
                    elevation: 16,
                    value: controller.selecteKecamatan,
                    hint: SizedBox(
                      width: MediaQuery.of(context).size.width - 44.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Pilih Kota/Kecamatan'),
                          if (controller.isLoadingKecamatanKoata.isTrue)
                            SizedBox(
                                height: 20.h,
                                width: 20.h,
                                child: const CircularProgressIndicator(
                                    color: AppColors.appGreenlight))
                        ],
                      ),
                    ),
                    style: GoogleFonts.quicksand(
                      color: Colors.grey,
                      fontSize: 12.sp,
                    ),
                    items: controller.listKecamatanKota
                        .map(
                          (list) => DropdownMenuItem(
                            value: list.id.toString(),
                            child: Text(
                              list.nama!,
                              style: GoogleFonts.quicksand(
                                color: Colors.black,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      controller.selecteKecamatan = value.toString();
                      controller.update();
                    },
                  );
                }),
              ]),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              decoration: const BoxDecoration(color: Colors.white),
              width: MediaQuery.of(context).size.width,
              child: CupertinoTextField(
                controller: controller.alamatLengkap,
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                placeholder: 'Alamat Lengkap',
                style: GoogleFonts.quicksand(
                  color: Colors.black,
                  fontSize: 12.sp,
                ),
                maxLines: 12,
                decoration: BoxDecoration(
                  border: null,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
