import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/app_colors.dart';
import '../controllers/agama_controller.dart';

class AgamaView extends GetView<AgamaController> {
  const AgamaView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.appBarColors,
        title: Text(
          'Ubah Agama',
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
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 10.w, right: 10.w),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            height: 50.h,
            child: Row(mainAxisSize: MainAxisSize.max, children: [
              GetBuilder<AgamaController>(builder: (_) {
                return DropdownButton(
                  underline: Container(),
                  elevation: 16,
                  value: controller.selectedName,
                  hint: SizedBox(
                    width: MediaQuery.of(context).size.width - 44.w,
                    child: const Text('Pilih Agama'),
                  ),
                  style: GoogleFonts.quicksand(
                      color: Colors.black87, fontSize: 14.sp),
                  items: controller.agama
                      .map(
                        (list) => DropdownMenuItem(
                          value: list.id,
                          child: Text("${list.agama}",
                              style: GoogleFonts.quicksand(
                                  color: Colors.black, fontSize: 14.sp)),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    controller.selectedName = value.toString();
                    controller.update();
                  },
                );
              }),
            ]),
          ),
        ],
      ),
    );
  }
}
