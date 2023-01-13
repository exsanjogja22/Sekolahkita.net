import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../config/app_colors.dart';
import '../controllers/tanggal_lahir_controller.dart';

class TanggalLahirView extends GetView<TanggalLahirController> {
  const TanggalLahirView(this.tanggalLahir, {Key? key}) : super(key: key);
  final String? tanggalLahir;
  @override
  Widget build(BuildContext context) {
    controller.tanggalC.text =
        DateFormat('yMd').format(DateTime.parse(tanggalLahir!));
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.appBarColors,
        title: Text(
          'Ubah Tanggal Lahir',
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
              controller.updateProfil(context, controller.tanggalRl.value);
            },
            child: Text(
              "Ubah",
              style:
                  GoogleFonts.quicksand(color: Colors.white, fontSize: 14.sp),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 10.w),
            alignment: Alignment.centerLeft,
            decoration: const BoxDecoration(color: Colors.white),
            child: TextField(
              controller: controller.tanggalC,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    helpText: "Ubah Tanggal Lahir",
                    builder: (context, child) {
                      return Theme(
                          data: ThemeData.light().copyWith(
                            primaryColor: AppColors.appGreenlight,
                            buttonTheme: const ButtonThemeData(
                                textTheme: ButtonTextTheme.primary),
                            colorScheme: const ColorScheme.light(
                                    primary: AppColors.appGreenlight)
                                .copyWith(secondary: AppColors.appGreenlight),
                          ),
                          child: child!);
                    },
                    context: context,
                    initialDate: tanggalLahir != "Set Sekarang"
                        ? DateTime.parse(tanggalLahir!)
                        : DateTime.now(),
                    firstDate: DateTime(
                        2000), //DateTime.now() - not to allow to choose before today.
                    lastDate: DateTime(2101));
                if (pickedDate != null) {
                  controller.tanggalRl.value =
                      DateFormat("y-M-d").format(pickedDate);
                  final dataDate = DateFormat('yMd').format(pickedDate);
                  controller.tanggalC.text = dataDate;
                } else {
                  if (kDebugMode) {
                    print("Date is not selected");
                  }
                }
              },
              keyboardType: TextInputType.none,
              style:
                  GoogleFonts.quicksand(color: Colors.black87, fontSize: 14.sp),
              decoration: InputDecoration(
                border: InputBorder.none,
                helperStyle: GoogleFonts.quicksand(
                  color: Colors.black38,
                  fontSize: 12.sp,
                ),
                hintText: "d/M/yyyy",
                hintStyle: GoogleFonts.quicksand(
                  color: Colors.black38,
                  fontSize: 12.sp,
                ),
                suffixIcon: InkWell(
                  child: Icon(
                    Icons.date_range_rounded,
                    size: 20.w,
                    color: const Color(0xff08B197),
                  ),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(
                            2000), //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2101));
                    if (pickedDate != null) {
                      final dataDate = DateFormat('yMd').format(pickedDate);
                      controller.tanggalC.text = dataDate;
                    } else {
                      if (kDebugMode) {
                        print("Date is not selected");
                      }
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
