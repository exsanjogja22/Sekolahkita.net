import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../../config/app_colors.dart';
import '../../../data/models/notifikasi_model.dart';
import '../../../routes/app_pages.dart';
import '../controllers/notifikasi_controller.dart';

class NotifikasiView extends GetView<NotifikasiController> {
  const NotifikasiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBgroudColors,
      appBar: AppBar(
        backgroundColor: AppColors.appBarColors,
        title: Text(
          'Notifikasi',
          style: GoogleFonts.quicksand(
              fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        child: SingleChildScrollView(
          child: FutureBuilder<List<Data>?>(
              future: controller.initNotifikasi,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      snapshot.data!.length,
                      (index) {
                        final data = snapshot.data![index];
                        return ListNotifikasiWidget(
                          data: data,
                        );
                      },
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
              }),
        ),
      ),
    );
  }
}

class ListNotifikasiWidget extends StatelessWidget {
  const ListNotifikasiWidget({
    Key? key,
    required this.data,
  }) : super(key: key);
  final Data data;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.h),
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: () {
            Get.toNamed(Routes.TUGAS);
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 15.w,
              vertical: 15.h,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    ClipOval(
                      child: Container(
                        height: 40.h,
                        width: 40.w,
                        color: AppColors.appGreenlight.withOpacity(0.3),
                        child: Center(
                          child: Image.asset(
                            "assets/icons/announcement.png",
                            height: 20.h,
                            width: 20.w,
                            color: AppColors.appGreenlight,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                      child: Text(
                        "PENGUMUMAN",
                        style: GoogleFonts.quicksand(
                            fontSize: 12.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          "${DateFormat("d/M/y", "id_ID").format(data.waktu!.startDate!)}, ${data.waktu!.startTime}",
                          style: GoogleFonts.quicksand(fontSize: 12.sp),
                        ),
                        Text(
                          "${DateFormat("d/M/y", "id_ID").format(data.waktu!.endDate!)}, ${data.waktu!.endTime}",
                          style: GoogleFonts.quicksand(fontSize: 12.sp),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "${data.dari}, ",
                        style: GoogleFonts.quicksand(
                          color: Colors.blue,
                          fontSize: 12.sp,
                        ),
                        children: [
                          TextSpan(
                            text: "Memberikan tugas baru ${data.detail}",
                            style: GoogleFonts.quicksand(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 12.sp,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
