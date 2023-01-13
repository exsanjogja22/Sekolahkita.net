class KecamatanData {
  List<Kecamatan>? kecamatan;

  KecamatanData({this.kecamatan});

  KecamatanData.fromJson(Map<String, dynamic> json) {
    if (json['kecamatan'] != null) {
      kecamatan = <Kecamatan>[];
      json['kecamatan'].forEach((v) {
        kecamatan?.add(Kecamatan.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (kecamatan != null) {
      data['kecamatan'] = kecamatan?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Kecamatan {
  int? id;
  String? idKota;
  String? nama;

  Kecamatan({this.id, this.idKota, this.nama});

  Kecamatan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idKota = json['id_kota'];
    nama = json['nama'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['id_kota'] = idKota;
    data['nama'] = nama;
    return data;
  }
}
