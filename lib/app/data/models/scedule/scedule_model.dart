class Scedule {
  bool? status;
  String? pesan;
  Data? data;

  Scedule({this.status, this.pesan, this.data});

  Scedule.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    pesan = json['pesan'];
    data = json['data'] != null ? Data?.fromJson(json['data']) : null;
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

class Data {
  String? tipeJadwal;
  Data({this.tipeJadwal});
  Data.fromJson(Map<String, dynamic> json) {
    tipeJadwal = json['tipe_jadwal'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['tipe_jadwal'] = tipeJadwal;
    return data;
  }
}
