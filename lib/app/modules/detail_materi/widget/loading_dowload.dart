import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../controllers/detail_materi_controller.dart';

class LoadingDowload extends StatelessWidget {
  const LoadingDowload({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final DetailMateriController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.4),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 100.h,
            width: 100.w,
            child: Lottie.asset(
              "assets/lotties/loading.json",
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            "Loading Download......${controller.isLoadingProgres.toString()}",
            style: GoogleFonts.quicksand(
                fontSize: 12.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
