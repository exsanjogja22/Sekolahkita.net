class TahunAjar {
  bool? status;
  String? pesan;
  Data? data;

  TahunAjar({this.status, this.pesan, this.data});

  TahunAjar.fromJson(Map<String, dynamic> json) {
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
  String? kode;
  String? nama;
  String? jenjang;
  String? tahun;
  String? semester;

  Data({this.kode, this.nama, this.jenjang, this.tahun, this.semester});

  Data.fromJson(Map<String, dynamic> json) {
    kode = json['kode'];
    nama = json['nama'];
    jenjang = json['jenjang'];
    tahun = json['tahun'];
    semester = json['semester'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['kode'] = kode;
    data['nama'] = nama;
    data['jenjang'] = jenjang;
    data['tahun'] = tahun;
    data['semester'] = semester;
    return data;
  }
}
