class Komentar {
  String? pesan;
  List<DataKomentar>? data;
  String? notifToken;
  int? countall;
  bool? status;

  Komentar(
      {this.pesan, this.data, this.notifToken, this.countall, this.status});

  Komentar.fromJson(Map<String, dynamic> json) {
    pesan = json['pesan'];
    if (json['data'] != null) {
      data = <DataKomentar>[];
      json['data'].forEach((v) {
        data?.add(DataKomentar.fromJson(v));
      });
    }
    notifToken = json['notifToken'].toString();
    countall = json['countall'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['pesan'] = pesan;
    if (data.isNotEmpty) {
      data['data'] = data;
    }
    data['notifToken'] = notifToken;
    data['countall'] = countall;
    data['status'] = status;
    return data;
  }
}

class DataKomentar {
  int? komentarId;
  String? komentarNama;
  String? komentarIsi;
  String? komentarTanggal;
  String? source;
  String? photo;

  DataKomentar(
      {this.komentarId,
      this.komentarNama,
      this.komentarIsi,
      this.komentarTanggal,
      this.source,
      this.photo});

  DataKomentar.fromJson(Map<String, dynamic> json) {
    komentarId = json['komentar_id'];
    komentarNama = json['komentar_nama'];
    komentarIsi = json['komentar_isi'];
    komentarTanggal = json['komentar_tanggal'];
    source = json['source'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['komentar_id'] = komentarId;
    data['komentar_nama'] = komentarNama;
    data['komentar_isi'] = komentarIsi;
    data['komentar_tanggal'] = komentarTanggal;
    data['source'] = source;
    data['photo'] = photo;
    return data;
  }
}
