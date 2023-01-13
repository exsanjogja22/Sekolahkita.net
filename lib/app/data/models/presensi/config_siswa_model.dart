class ConfigSiswa {
  bool? status;
  DataConfig? data;
  String? pesan;

  ConfigSiswa({this.status, this.data, this.pesan});

  ConfigSiswa.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? DataConfig?.fromJson(json['data']) : null;
    pesan = json['pesan'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    if (data.isNotEmpty) {
      data['data'] = data;
    }
    data['pesan'] = pesan;
    return data;
  }
}

class DataConfig {
  String? jamDatangAwal;
  String? jamDatangAkhir;
  String? jamPulangAwal;
  String? jamPulangAkhir;
  double? systemLatitude;
  double? systemLongitude;
  int? systemRadius;

  DataConfig(
      {this.jamDatangAwal,
      this.jamDatangAkhir,
      this.jamPulangAwal,
      this.jamPulangAkhir,
      this.systemLatitude,
      this.systemLongitude,
      this.systemRadius});

  DataConfig.fromJson(Map<String, dynamic> json) {
    jamDatangAwal = json['jam_datang_awal'];
    jamDatangAkhir = json['jam_datang_akhir'];
    jamPulangAwal = json['jam_pulang_awal'];
    jamPulangAkhir = json['jam_pulang_akhir'];
    systemLatitude = json['system_latitude'];
    systemLongitude = json['system_longitude'];
    systemRadius = json['system_radius'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['jam_datang_awal'] = jamDatangAwal;
    data['jam_datang_akhir'] = jamDatangAkhir;
    data['jam_pulang_awal'] = jamPulangAwal;
    data['jam_pulang_akhir'] = jamPulangAkhir;
    data['system_latitude'] = systemLatitude;
    data['system_longitude'] = systemLongitude;
    data['system_radius'] = systemRadius;
    return data;
  }
}
