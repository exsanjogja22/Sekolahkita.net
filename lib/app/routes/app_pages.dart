import 'package:get/get.dart';

import '../modules/add_satatus/bindings/add_satatus_binding.dart';
import '../modules/add_satatus/views/add_satatus_view.dart';
import '../modules/akun_saya/bindings/akun_saya_binding.dart';
import '../modules/akun_saya/views/akun_saya_view.dart';
import '../modules/berita/bindings/berita_binding.dart';
import '../modules/berita/views/berita_view.dart';
import '../modules/detail_status/bindings/detail_status_binding.dart';
import '../modules/detail_status/views/detail_status_view.dart';
import '../modules/e_konseling/bindings/e_konseling_binding.dart';
import '../modules/e_konseling/views/e_konseling_view.dart';
import '../modules/jadwal/bindings/jadwal_binding.dart';
import '../modules/jadwal/views/jadwal_view.dart';
import '../modules/kamera_helper/bindings/kamera_helper_binding.dart';
import '../modules/kamera_helper/views/kamera_helper_view.dart';
import '../modules/kebijakan_privasi/bindings/kebijakan_privasi_binding.dart';
import '../modules/kebijakan_privasi/views/kebijakan_privasi_view.dart';
import '../modules/komentar_status/bindings/komentar_status_binding.dart';
import '../modules/komentar_status/views/komentar_status_view.dart';
import '../modules/lembar_jawab/bindings/lembar_jawab_binding.dart';
import '../modules/lembar_jawab/views/lembar_jawab_view.dart';
import '../modules/lembar_jawab_essay/bindings/lembar_jawab_essay_binding.dart';
import '../modules/lembar_jawab_essay/views/lembar_jawab_essay_view.dart';
import '../modules/list_materi/bindings/list_materi_binding.dart';
import '../modules/list_materi/views/list_materi_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/loginmain/bindings/loginmain_binding.dart';
import '../modules/loginmain/views/loginmain_view.dart';
import '../modules/mainpage/bindings/mainpage_binding.dart';
import '../modules/mainpage/views/mainpage_view.dart';
import '../modules/map_helper/bindings/map_helper_binding.dart';
import '../modules/map_helper/views/map_helper_view.dart';
import '../modules/notifikasi/bindings/notifikasi_binding.dart';
import '../modules/notifikasi/views/notifikasi_view.dart';
import '../modules/pdf_helper/bindings/pdf_helper_binding.dart';
import '../modules/pdf_helper/views/pdf_helper_view.dart';
import '../modules/profil/bindings/profil_binding.dart';
import '../modules/profil/views/profil_view.dart';
import '../modules/statistik/bindings/statistik_binding.dart';
import '../modules/statistik/views/statistik_view.dart';
import '../modules/status/bindings/status_binding.dart';
import '../modules/status/views/status_view.dart';
import '../modules/tugas/bindings/tugas_binding.dart';
import '../modules/tugas/views/tugas_view.dart';
import '../modules/tugas_aktif/bindings/tugas_aktif_binding.dart';
import '../modules/tugas_aktif/views/tugas_aktif_view.dart';
import '../modules/tugas_selesai/bindings/tugas_selesai_binding.dart';
import '../modules/tugas_selesai/views/tugas_selesai_view.dart';
import '../modules/welcome/bindings/welcome_binding.dart';
import '../modules/welcome/views/welcome_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();
  static final routes = [
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.LOGINMAIN,
      page: () => const LoginmainView(),
      binding: LoginmainBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(microseconds: 500),
    ),
    GetPage(
      name: _Paths.MAINPAGE,
      page: () => const MainpageView(),
      binding: MainpageBinding(),
    ),
    GetPage(
      name: _Paths.PROFIL,
      page: () => const ProfilView(),
      binding: ProfilBinding(),
    ),
    GetPage(
      name: _Paths.JADWAL,
      page: () => const JadwalView(),
      binding: JadwalBinding(),
    ),
    GetPage(
        name: _Paths.TUGAS,
        page: () => const TugasView(),
        binding: TugasBinding(),
        transition: Transition.rightToLeft),
    GetPage(
      name: _Paths.STATUS,
      page: () => const StatusView(),
      binding: StatusBinding(),
    ),
    GetPage(
      name: _Paths.ADD_SATATUS,
      page: () => const AddSatatusView(),
      binding: AddSatatusBinding(),
    ),
    GetPage(
        name: _Paths.TUGAS_SELESAI,
        page: () => const TugasSelesaiView(),
        binding: TugasSelesaiBinding(),
        transition: Transition.rightToLeft),
    GetPage(
      name: _Paths.TUGAS_AKTIF,
      page: () => const TugasAktifView(),
      binding: TugasAktifBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.LEMBAR_JAWAB,
      page: () => const LembarJawabView(),
      binding: LembarJawabBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_STATUS,
      page: () => const DetailStatusView(),
      binding: DetailStatusBinding(),
    ),
    GetPage(
      name: _Paths.KOMENTAR_STATUS,
      page: () => const KomentarStatusView(),
      binding: KomentarStatusBinding(),
      transition: Transition.downToUp,
      transitionDuration: const Duration(microseconds: 500),
    ),
    GetPage(
      name: _Paths.STATISTIK,
      page: () => const StatistikView(),
      binding: StatistikBinding(),
    ),
    GetPage(
      name: _Paths.E_KONSELING,
      page: () => const EKonselingView(),
      binding: EKonselingBinding(),
    ),
    GetPage(
      name: _Paths.BERITA,
      page: () => const BeritaView(),
      binding: BeritaBinding(),
    ),
    GetPage(
      name: _Paths.KAMERA_HELPER,
      page: () => const KameraHelperView(),
      binding: KameraHelperBinding(),
    ),
    GetPage(
      name: _Paths.MAP_HELPER,
      page: () => const MapHelperView(),
      binding: MapHelperBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFIKASI,
      page: () => const NotifikasiView(),
      binding: NotifikasiBinding(),
    ),
    GetPage(
      name: _Paths.WELCOME,
      page: () => const WelcomeView(),
      binding: WelcomeBinding(),
    ),
    GetPage(
      name: _Paths.LEMBAR_JAWAB_ESSAY,
      page: () => const LembarJawabEssayView(),
      binding: LembarJawabEssayBinding(),
    ),
    GetPage(
      name: _Paths.LIST_MATERI,
      page: () => const ListMateriView(),
      binding: ListMateriBinding(),
    ),
    GetPage(
      name: _Paths.PDF_HELPER,
      page: () => const PdfHelperView(),
      binding: PdfHelperBinding(),
    ),
    GetPage(
      name: _Paths.AKUN_SAYA,
      page: () => const AkunSayaView(),
      binding: AkunSayaBinding(),
    ),
    GetPage(
      name: _Paths.KEBIJAKAN_PRIVASI,
      page: () => const KebijakanPrivasiView(),
      binding: KebijakanPrivasiBinding(),
    ),
  ];
}
