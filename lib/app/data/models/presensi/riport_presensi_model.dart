class RiportPresensi {
  bool? status;
  DataRiportPresensi? data;
  String? pesan;

  RiportPresensi({this.status, this.data, this.pesan});

  RiportPresensi.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null
        ? DataRiportPresensi?.fromJson(json['data'])
        : null;
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

class DataRiportPresensi {
  RiportPresensiHarian? presensiHarian;
  RiportPresensiKegiatan? presensiKegiatan;
  List<ListKegiatan>? listKegiatan;

  DataRiportPresensi(
      {this.presensiHarian, this.presensiKegiatan, this.listKegiatan});

  DataRiportPresensi.fromJson(Map<String, dynamic> json) {
    presensiHarian = json['presensi_harian'] != null
        ? RiportPresensiHarian?.fromJson(json['presensi_harian'])
        : null;
    presensiKegiatan = json['presensi_kegiatan'] != null
        ? RiportPresensiKegiatan?.fromJson(json['presensi_kegiatan'])
        : null;
    if (json['list_kegiatan'] != null) {
      listKegiatan = <ListKegiatan>[];
      json['list_kegiatan'].forEach((v) {
        listKegiatan?.add(ListKegiatan.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (presensiHarian != null) {
      data['presensi_harian'] = presensiHarian?.toJson();
    }
    if (presensiKegiatan != null) {
      data['presensi_kegiatan'] = presensiKegiatan?.toJson();
    }
    if (listKegiatan != null) {
      data['list_kegiatan'] = listKegiatan?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RiportPresensiHarian {
  int? jmlHariEfektif;
  int? jmlSakit;
  int? jmlIzin;
  int? jmlAlfa;
  int? jmlHadir;
  int? jmlTerlambat;
  int? persentaseHadir;

  RiportPresensiHarian(
      {this.jmlHariEfektif,
      this.jmlSakit,
      this.jmlIzin,
      this.jmlAlfa,
      this.jmlHadir,
      this.jmlTerlambat,
      this.persentaseHadir});

  RiportPresensiHarian.fromJson(Map<String, dynamic> json) {
    jmlHariEfektif = json['jml_hari_efektif'];
    jmlSakit = json['jml_sakit'];
    jmlIzin = json['jml_izin'];
    jmlAlfa = json['jml_alfa'];
    jmlHadir = json['jml_hadir'];
    jmlTerlambat = json['jml_terlambat'];
    persentaseHadir = json['persentase_hadir'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['jml_hari_efektif'] = jmlHariEfektif;
    data['jml_sakit'] = jmlSakit;
    data['jml_izin'] = jmlIzin;
    data['jml_alfa'] = jmlAlfa;
    data['jml_hadir'] = jmlHadir;
    data['jml_terlambat'] = jmlTerlambat;
    data['persentase_hadir'] = persentaseHadir;
    return data;
  }
}

class RiportPresensiKegiatan {
  int? jmlKegiatan;
  int? jmlHadir;
  int? jmlTidakHadir;
  int? persentaseHadir;

  RiportPresensiKegiatan(
      {this.jmlKegiatan,
      this.jmlHadir,
      this.jmlTidakHadir,
      this.persentaseHadir});

  RiportPresensiKegiatan.fromJson(Map<String, dynamic> json) {
    jmlKegiatan = json['jml_kegiatan'];
    jmlHadir = json['jml_hadir'];
    jmlTidakHadir = json['jml_tidak_hadir'];
    persentaseHadir = json['persentase_hadir'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['jml_kegiatan'] = jmlKegiatan;
    data['jml_hadir'] = jmlHadir;
    data['jml_tidak_hadir'] = jmlTidakHadir;
    data['persentase_hadir'] = persentaseHadir;
    return data;
  }
}

class ListKegiatan {
  String? kodeKegiatan;
  String? namaKegiatan;
  DateTime? tanggalPresensi;

  ListKegiatan({this.kodeKegiatan, this.namaKegiatan, this.tanggalPresensi});

  ListKegiatan.fromJson(Map<String, dynamic> json) {
    kodeKegiatan = json['kode_kegiatan'];
    namaKegiatan = json['nama_kegiatan'];
    tanggalPresensi = DateTime.parse(json['tanggal_presensi']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['kode_kegiatan'] = kodeKegiatan;
    data['nama_kegiatan'] = namaKegiatan;
    data['tanggal_presensi'] = tanggalPresensi;
    return data;
  }
}
