import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../config/app_colors.dart';
import '../../../data/models/presensi/riport_presensi_model.dart';
import '../../../data/models/riport_keaktifan_kbm_model.dart';
import '../../../data/models/riport_kelas_online_model.dart';
import '../controllers/statistik_controller.dart';
import 'aktifitas_belajar/keaktifan_kbm_widget.dart';
import 'aktifitas_belajar/kelas_online_widget.dart';
import 'aktifitas_belajar/presensi_harian_widget.dart';

class AktifitasBelajar extends StatelessWidget {
  const AktifitasBelajar({
    Key? key,
    this.kelas,
  }) : super(key: key);
  final String? kelas;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<StatistikController>();
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.w),
      child: SingleChildScrollView(
        child: Column(
          children: [
            GetBuilder<StatistikController>(
              id: 0,
              init: StatistikController(),
              builder: (_) {
                return FutureBuilder<DataRiportPresensi?>(
                    future: controller.getDataReport(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: [
                            SizedBox(
                              height: 35.h,
                              width: double.infinity.w,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Text(
                                          "Presensi Tahun ${controller.tahunAjar.value} ",
                                          style: GoogleFonts.quicksand(
                                            color: const Color(0xff155A5F),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 30.h,
                                    decoration: BoxDecoration(
                                      color: const Color(0xff6C99F6),
                                      borderRadius: BorderRadius.circular(5.h),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 10.w),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          hint: Row(
                                            children: [
                                              Text(
                                                'Bulan',
                                                style: GoogleFonts.quicksand(
                                                  color:
                                                      AppColors.appColorWhite,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12.sp,
                                                ),
                                              ),
                                            ],
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          dropdownColor:
                                              const Color(0xff6C99F6),
                                          value: controller.selectedBulan,
                                          items: controller.bulan.map(
                                            (value) {
                                              return DropdownMenuItem<String>(
                                                value: value["code"],
                                                child: Text(
                                                  value['month'],
                                                  style: GoogleFonts.quicksand(
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        AppColors.appColorWhite,
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
                                            controller.selectedBulan = value!;
                                            controller.getDataReport();
                                            controller.update([0]);
                                          },
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            PresensiHarian(
                              data: snapshot.data,
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                          ],
                        );
                      } else {
                        return const SizedBox();
                      }
                    });
              },
            ),
            GetBuilder<StatistikController>(
              id: 1,
              builder: (_) {
                return FutureBuilder<List<DataRiport>?>(
                    future: controller.getDataReportKbm(kelas!),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.isNotEmpty) {
                          return Column(
                            children: [
                              SizedBox(
                                height: 35.h,
                                width: double.infinity.w,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Text(
                                            "Keaktifan KBM Tahun ${controller.tahunAjar.value}",
                                            style: GoogleFonts.quicksand(
                                              color: const Color(0xff155A5F),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 30.h,
                                      decoration: BoxDecoration(
                                        color: const Color(0xff6C99F6),
                                        borderRadius:
                                            BorderRadius.circular(5.h),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 10.w),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<String>(
                                            hint: Row(
                                              children: [
                                                Text(
                                                  'Bulan',
                                                  style: GoogleFonts.quicksand(
                                                    color:
                                                        AppColors.appColorWhite,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12.sp,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            dropdownColor:
                                                const Color(0xff6C99F6),
                                            value: controller.selectedBulan1,
                                            items: controller.bulan.map(
                                              (value) {
                                                return DropdownMenuItem<String>(
                                                  value: value["code"],
                                                  child: Text(
                                                    value['month'],
                                                    style:
                                                        GoogleFonts.quicksand(
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: AppColors
                                                          .appColorWhite,
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
                                              controller.selectedBulan1 =
                                                  value!;
                                              controller
                                                  .getDataReportKbm(kelas!);
                                              controller.update([1]);
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              KeaktifanKbm(data: snapshot.data),
                              SizedBox(
                                height: 15.h,
                              ),
                            ],
                          );
                        }
                        return const SizedBox();
                      }
                      return const SizedBox();
                    });
              },
            ),
            GetBuilder<StatistikController>(
              id: 2,
              init: StatistikController(),
              initState: (_) {},
              builder: (_) {
                return FutureBuilder<DataKelasOnline?>(
                  future: controller.getDataReportKbmVir(kelas!),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          SizedBox(
                            height: 35.h,
                            width: double.infinity.w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Text(
                                        "Kelas online Tahun ${controller.tahunAjar.value}",
                                        style: GoogleFonts.quicksand(
                                          color: const Color(0xff155A5F),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 30.h,
                                  decoration: BoxDecoration(
                                    color: const Color(0xff6C99F6),
                                    borderRadius: BorderRadius.circular(5.h),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 10.w),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        hint: Text(
                                          'Bulan',
                                          style: GoogleFonts.quicksand(
                                            color: AppColors.appColorWhite,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                        dropdownColor: const Color(0xff6C99F6),
                                        value: controller.selectedBulan2,
                                        items: controller.bulan.map(
                                          (value) {
                                            return DropdownMenuItem<String>(
                                              value: value['code'],
                                              child: Text(
                                                value['month'],
                                                style: GoogleFonts.quicksand(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            );
                                          },
                                        ).toList(),
                                        icon: Icon(
                                          Icons.arrow_drop_down,
                                          size: 20.w,
                                          color: Colors.white,
                                        ),
                                        onChanged: (value) {
                                          controller.selectedBulan2 = value!;
                                          controller
                                              .getDataReportKbmVir(kelas!);
                                          controller.update([2]);
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          KelasOnine(
                            data: snapshot.data,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                        ],
                      );
                    }
                    return const SizedBox();
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
