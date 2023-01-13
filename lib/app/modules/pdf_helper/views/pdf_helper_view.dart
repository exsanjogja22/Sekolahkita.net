import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smkn1contoh/app/config/app_colors.dart';
import 'package:smkn1contoh/app/modules/detail_status/views/detail_status_view.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfHelperView extends StatelessWidget {
  const PdfHelperView({
    Key? key,
    this.url,
    this.judul,
    this.id,
  }) : super(key: key);
  final String? url;
  final String? judul;
  final String? id;

  @override
  Widget build(BuildContext context) {
    final GlobalKey<SfPdfViewerState> pdfViewerKey = GlobalKey();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarColors,
        centerTitle: true,
        title: Text(
          judul!.toTitleCase(),
          style: GoogleFonts.quicksand(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 18.sp,
          ),
        ),
        actions: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 15.w,
            child: InkWell(
              onTap: () {},
              child: Icon(
                Icons.help,
                size: 15.w,
                color: AppColors.appGreenlight,
              ),
            ),
          ),
          SizedBox(
            width: 5.w,
          ),
          CircleAvatar(
            radius: 15.w,
            backgroundColor: Colors.white,
            child: InkWell(
              onTap: () async {
                await Share.shareWithResult(
                    'chttps://smk1contoh.sekolahkita.net/app/student/elearning/detail_materi/$id');
              },
              child: Icon(
                Icons.share,
                size: 15.w,
                color: AppColors.appGreenlight,
              ),
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
        ],
        leading: Padding(
          padding: EdgeInsets.all(10.w),
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
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Expanded(
              child: SfPdfViewer.network(
                url!,
                key: pdfViewerKey,
              ),
            )
          ],
        ),
      ),
    );
  }
}
