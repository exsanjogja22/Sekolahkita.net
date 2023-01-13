class KbmVirtual {
  String? pesan;
  Data? data;
  bool? status;

  KbmVirtual({this.pesan, this.data, this.status});

  KbmVirtual.fromJson(Map<String, dynamic> json) {
    pesan = json['pesan'];
    data = json['data'] != null ? Data?.fromJson(json['data']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['pesan'] = pesan;
    if (data.isNotEmpty) {
      data['data'] = data;
    }
    data['status'] = status;
    return data;
  }
}

class Data {
  List<DataKbm>? row;
  String? totalData;

  Data({this.row, this.totalData});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['row'] != null) {
      row = <DataKbm>[];
      json['row'].forEach((v) {
        row?.add(DataKbm.fromJson(v));
      });
    }
    totalData = json['totalData'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (row != null) {
      data['row'] = row?.map((v) => v.toJson()).toList();
    }
    data['totalData'] = totalData;
    return data;
  }
}

class DataKbm {
  String? idKbm;
  String? judul;
  DateTime? tanggalKbm;
  String? jamMulai;
  String? jamSelesai;
  String? statusLive;
  String? urlKbmLive;
  String? namaPelajaran;
  String? namaGuru;
  String? photo;
  String? background;
  String? totalMateri;
  List<DaftarMateri>? daftarMateri;

  DataKbm(
      {this.idKbm,
      this.judul,
      this.tanggalKbm,
      this.jamMulai,
      this.jamSelesai,
      this.statusLive,
      this.urlKbmLive,
      this.namaPelajaran,
      this.namaGuru,
      this.photo,
      this.background,
      this.totalMateri,
      this.daftarMateri});

  DataKbm.fromJson(Map<String, dynamic> json) {
    idKbm = json['id_kbm'];
    judul = json['judul'];
    tanggalKbm = DateTime.parse(json['tanggal_kbm']);
    jamMulai = json['jam_mulai'];
    jamSelesai = json['jam_selesai'];
    statusLive = json['status_live'];
    urlKbmLive = json['url_kbm_live'];
    namaPelajaran = json['nama_pelajaran'];
    namaGuru = json['nama_guru'];
    photo = json['photo'];
    background = json['background'];
    totalMateri = json['total_materi'];
    if (json['daftar_materi'] != null) {
      daftarMateri = <DaftarMateri>[];
      json['daftar_materi'].forEach((v) {
        daftarMateri?.add(DaftarMateri.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id_kbm'] = idKbm;
    data['judul'] = judul;
    data['tanggal_kbm'] = tanggalKbm;
    data['jam_mulai'] = jamMulai;
    data['jam_selesai'] = jamSelesai;
    data['status_live'] = statusLive;
    data['url_kbm_live'] = urlKbmLive;
    data['nama_pelajaran'] = namaPelajaran;
    data['nama_guru'] = namaGuru;
    data['photo'] = photo;
    data['background'] = background;
    data['total_materi'] = totalMateri;
    if (daftarMateri != null) {
      data['daftar_materi'] = daftarMateri?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DaftarMateri {
  String? id;
  String? judul;
  String? mapel;

  DaftarMateri({this.id, this.judul, this.mapel});

  DaftarMateri.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    judul = json['judul'];
    mapel = json['mapel'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['judul'] = judul;
    data['mapel'] = mapel;
    return data;
  }
}
