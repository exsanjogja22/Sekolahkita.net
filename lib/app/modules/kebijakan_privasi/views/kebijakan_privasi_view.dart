import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smkn1contoh/app/config/app_colors.dart';

import '../controllers/kebijakan_privasi_controller.dart';

class KebijakanPrivasiView extends GetView<KebijakanPrivasiController> {
  const KebijakanPrivasiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.appBarColors,
          centerTitle: true,
          title: Text("Kebijakan Privasi & Ketentuan",
              style: GoogleFonts.quicksand(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 18)),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: HtmlWidget(
              """<h2>Kebijakan Privasi</h2> 
                <p>Kebijakan Privasi ini adalah sebuah komitmen nyata dari Platform Sekolahkita.net untuk melindungi dan menghargai setiap data dan informasi pribadi pengguna situs www.sekolahkita.net atau aplikasi yang kami kelola (selanjutnya disebut “aplikasi”).<br><br>Kebijakan Privasi ini mengatur landasan dasar mengenai bagaimana Kami menggunakan informasi pribadi yang Kami kumpulkan dan/atau Anda berikan. Kebijakan ini berlaku bagi seluruh pengguna Platform dibawah naungan Platform Sekolahkita.net . Mohon untuk membaca Kebijakan Privasi ini dengan seksama sehingga Anda dapat memahami pendekatan dan cara Kami dalam menggunakan informasi tersebut.<br><br>Kebijakan Privasi ini mencakup hal-hal sebagai berikut :</p>
                <h3>1. Informasi Pribadi</h3>
                <p>Kami menggunakan Informasi Pribadi Anda untuk cara-cara berikut :<br><br><b>a. Informasi yang Anda berikan</b><br>Kami akan menggunakan informasi ini untuk menjalankan kewajiban Kami dalam menyediakan informasi, produk, dan jasa kepada Anda. Selain itu juga untuk memberitahukan Anda tentang perubahan pada jasa Kami. Selanjutnya untuk memastikan bahwa konten dari Platform Kami disajikan dengan cara yang paling efektif bagi Anda.<br><br><b>b. Informasi yang Kami kumpulkan</b><br>Kami akan menggunakan informasi ini untuk mengelola platform dan operasi internal Kami. Untuk memperbaiki platform Kami sehingga konten yang Kami sajikan akan semakin efektif untuk Anda. Sekaligus untuk memberikan masukan dan rekomendasi kepada Anda dan pengguna lain dalam Platform Kami mengenai produk dan jasa yang dapat menarik minat Anda dan mereka.</p>
                <h3>2. Penyimpanan Informasi Pribadi</h3>
                <p>Seluruh informasi Pribadi yang Anda berikan kepada Kami disimpan di server yang aman. Semua transaksi pembayaran pada Platform akan dienkripsi. Dengan menyerahkan Informasi Pribadi Anda pada Platform, Anda menyetujui pengalihan, penyimpanan, serta pengolahan yang terjadi pada Platform Kami. Kami akan mengambil langkah-langkah dalam batas kewajaran yang diperlukan untuk memastikan bahwa Informasi Pribadi tersebut diperlakukan dengan aman dan sesuai dengan Kebijakan Privasi serta Peraturan yang Berlaku.<br><br>Dalam situasi di mana Kami memberikan (atau Anda memilih) sebuah kata sandi (password) yang mengizinkan Anda untuk mengakses bagian-bagian tertentu pada Platform Kami, Anda bertanggung jawab untuk menjaga kerahasiaan kata sandi ini. Kami meminta Anda untuk tidak membagi kata sandi dengan siapa pun.<br><br>Mohon untuk dapat diperhatikan bahwa transmisi informasi melalui internet tidak sepenuhnya aman. Meskipun demikian, Kami akan berusaha sebaik mungkin untuk melindungi Informasi Pribadi tersebut. Kami tidak bisa menjamin keamanan data yang dikirimkan ke Platform Kami; risiko dari setiap transmisi menjadi tanggung jawab Anda. Begitu Kami menerima Informasi Pribadi Anda, Kami akan menggunakan prosedur yang ketat dan fitur keamanan untuk mencegah akses yang tidak diizinkan.<br><br></p>
                <h3>4. Cookies</h3>
                <p>Platform Sekolahkita.net menggunakan fitur Google Analytics Demographics and Interest. Data yang Kami peroleh berupa lokasi, nama sekolah, dan lain-lain. Informasi ini akan Kami gunakan untuk pengembangan situs dan konten di Platform Sekolahkita.net .<br><br></p>
                <h3>5. Penyimpanan dan Penghapusan Informasi</h3>
                <p>Platform Sekolahkita.net akan menyimpan informasi selama akun Anda tetap aktif dan dapat melakukan penghapusan sesuai dengan ketentuan yang berlaku.</p>
                <h3>6. Pembaruan Kebijakan Privasi</h3>
                <p>Platform Sekolahkita.net dapat sewaktu-waktu melakukan perubahan atau pembaruan Kebijakan Privasi ini. Kami menyarankan agara Pengguna membaca secara seksama dan memeriksa halaman Kebijakan Privasi ini dari waktu ke waktu untuk mengetahui perubahan apapun. Jika Pengguna masih menggunakan layanan Platform Sekolahkita.net , maka Pengguna dianggap menyetujui semua perubahan dalam Kebijakan Privasi ini.</p>
                <h3>7. Hubungi Kami</h3>
                <p>Jika Anda memiliki pertanyaan atau saran tentang Syarat dan Ketentuan kami, jangan ragu untuk menghubungi kami di<b> sekolahkitanet@gmail.com </b> atau <b> info@watulintang.com </b></p>
                """,
              textStyle: GoogleFonts.quicksand(color: Colors.black),
            ),
          ),
        ));
  }
}
