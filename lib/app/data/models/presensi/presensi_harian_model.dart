class PresensiHarian {
  bool? status;
  DataPresensi? data;
  String? pesan;

  PresensiHarian({this.status, this.data, this.pesan});
  PresensiHarian.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? DataPresensi?.fromJson(json['data']) : null;
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

class DataPresensi {
  String? waktuDatang;
  String? waktuPulang;
  String? statusDatang;
  String? statusPulang;

  DataPresensi(
      {this.waktuDatang,
      this.waktuPulang,
      this.statusDatang,
      this.statusPulang});

  DataPresensi.fromJson(Map<String, dynamic> json) {
    waktuDatang =
        json['waktu_datang'] == "" ? "00:00:00" : json['waktu_datang'];
    waktuPulang =
        json['waktu_pulang'] == "" ? "00:00:00" : json['waktu_pulang'];
    statusDatang = json['status_datang'] == "" ? "-" : json['status_datang'];
    statusPulang = json['status_pulang'] == "" ? "-" : json['status_pulang'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['waktu_datang'] = waktuDatang;
    data['waktu_pulang'] = waktuPulang;
    data['status_datang'] = statusDatang;
    data['status_pulang'] = statusPulang;
    return data;
  }
}
