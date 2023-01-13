import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TextWelcomeWidget extends StatelessWidget {
  const TextWelcomeWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 30.h,
        ),
        Text(
          "Hai, Selamat Datang ",
          style: GoogleFonts.quicksand(
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
            color: Colors.black,
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        Text(
          "Masuk sebagai Siswa yang sudah terdaftar di website resmi sekolah dengan akun anda",
          maxLines: 2,
          style: GoogleFonts.quicksand(
            fontSize: 12.sp,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
