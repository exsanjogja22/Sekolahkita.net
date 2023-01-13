class Status {
  List<DataStatus>? data;
  String? pesan;
  bool? status;

  Status({this.data, this.pesan, this.status});

  Status.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <DataStatus>[];
      json['data'].forEach((v) {
        data?.add(DataStatus.fromJson(v));
      });
    }
    pesan = json['pesan'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (data.isNotEmpty) {
      data['data'] = data;
    }
    data['pesan'] = pesan;
    data['status'] = status;
    return data;
  }
}

class DataStatus {
  int? id;
  String? author;
  String? nama;
  String? tipe;
  String? judul;
  String? detail;
  DateTime? tanggal;
  int? komencount;
  String? img;

  DataStatus(
      {this.id,
      this.author,
      this.nama,
      this.tipe,
      this.judul,
      this.detail,
      this.tanggal,
      this.komencount,
      this.img});

  DataStatus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    author = json['author'].toString();
    nama = json['nama'].toString();
    tipe = json['tipe'];
    judul = json['judul'].toString();
    detail = json['detail'].toString();
    tanggal = DateTime.parse(json['tanggal']);
    komencount = json['komencount'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['author'] = author;
    data['nama'] = nama;
    data['tipe'] = tipe;
    data['judul'] = judul;
    data['detail'] = detail;
    data['tanggal'] = tanggal;
    data['komencount'] = komencount;
    data['img'] = img;
    return data;
  }
}
