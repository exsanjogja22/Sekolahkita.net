import 'package:get/get.dart';

import '../../../modules/akun_saya/controllers/akun_saya_controller.dart';
import '../../../modules/akun_saya/controllers/email_controller.dart';
import '../../../modules/akun_saya/controllers/agama_controller.dart';
import '../../../modules/akun_saya/controllers/alamat_asli_controller.dart';
import '../../../modules/akun_saya/controllers/alamat_tinggal_controller.dart';
import '../../../modules/akun_saya/controllers/jenis_kelamin_controller.dart';
import '../../../modules/akun_saya/controllers/tanggal_lahir_controller.dart';
import '../../../modules/akun_saya/controllers/telepon_controller.dart';
import '../../../modules/akun_saya/controllers/tempat_lahir_controller.dart';

class AkunSayaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmailController>(
      () => EmailController(),
    );
    Get.lazyPut<TeleponController>(
      () => TeleponController(),
    );
    Get.lazyPut<AlamatTinggalController>(
      () => AlamatTinggalController(),
    );
    Get.lazyPut<AlamatAsliController>(
      () => AlamatAsliController(),
    );
    Get.lazyPut<AgamaController>(
      () => AgamaController(),
    );
    Get.lazyPut<JenisKelaminController>(
      () => JenisKelaminController(),
    );
    Get.lazyPut<TanggalLahirController>(
      () => TanggalLahirController(),
    );
    Get.lazyPut<TempatLahirController>(
      () => TempatLahirController(),
    );
    Get.lazyPut<AkunSayaController>(
      () => AkunSayaController(),
    );
  }
}
