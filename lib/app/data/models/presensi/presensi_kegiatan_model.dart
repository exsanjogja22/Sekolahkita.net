class PresensiKegiatan {
  bool? status;
  String? pesan;
  List<DataPresensiKegiatan>? data;

  PresensiKegiatan({this.status, this.pesan, this.data});

  PresensiKegiatan.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    pesan = json['pesan'];
    if (json['data'] != null) {
      data = <DataPresensiKegiatan>[];
      json['data'].forEach((v) {
        data?.add(DataPresensiKegiatan.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['pesan'] = pesan;
    if (data.isNotEmpty) {
      data['data'] = data;
    }
    return data;
  }
}

class DataPresensiKegiatan {
  String? mkKode;
  String? mkTitle;
  String? mkDescription;
  bool? sudahPresensi;
  String? waktuPresensi;
  bool? buttonStatus;
  bool? usePhoto;
  bool? useGps;
  List<String>? labelHari;

  DataPresensiKegiatan(
      {this.mkKode,
      this.mkTitle,
      this.mkDescription,
      this.sudahPresensi,
      this.waktuPresensi,
      this.buttonStatus,
      this.usePhoto,
      this.useGps,
      this.labelHari});

  DataPresensiKegiatan.fromJson(Map<String, dynamic> json) {
    mkKode = json['mk_kode'];
    mkTitle = json['mk_title'];
    mkDescription = json['mk_description'];
    sudahPresensi = json['sudah_presensi'];
    waktuPresensi = json['waktu_presensi'];
    buttonStatus = json['button_status'];
    usePhoto = json['use_photo'];
    useGps = json['use_gps'];
    labelHari = json['label_hari'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['mk_kode'] = mkKode;
    data['mk_title'] = mkTitle;
    data['mk_description'] = mkDescription;
    data['sudah_presensi'] = sudahPresensi;
    data['waktu_presensi'] = waktuPresensi;
    data['button_status'] = buttonStatus;
    data['use_photo'] = usePhoto;
    data['use_gps'] = useGps;
    data['label_hari'] = labelHari;
    return data;
  }
}
