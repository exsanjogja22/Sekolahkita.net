import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/app_colors.dart';
import '../../../data/providers/network/api_endpoints.dart';
import '../controllers/berita_controller.dart';

class BeritaView extends GetView<BeritaController> {
  const BeritaView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.appBgroudColors,
        appBar: AppBar(
          backgroundColor: AppColors.appBarColors,
          title: Text(
            'Berita & Informasi',
            style: GoogleFonts.quicksand(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: HtmlWidget(
            """
          <iframe src="${APIEndpoint.api}/public/berita/embed?category=0&sort=desc" width="100%"  height="2000"  scrolling="yes"></iframe>
              """,
            textStyle: GoogleFonts.quicksand(color: Colors.black),
          ),
        ));
  }
}
