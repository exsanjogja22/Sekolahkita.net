class DetailTugas {
  bool? status;
  DataDetail? data;
  String? pesan;

  DetailTugas({this.status, this.data, this.pesan});

  DetailTugas.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? DataDetail?.fromJson(json['data']) : null;
    pesan = json['pesan'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    if (data.isNotEmpty) {
      data['data'];
    }
    data['pesan'] = pesan;
    return data;
  }
}

class DataDetail {
  String? judul;
  String? kelas;
  String? jurusan;
  bool? showNilai;
  String? keterangan;
  Soal? soal;
  JawabanSaya? jawabanSaya;
  Guru? guru;
  ResumGuru? resumGuru;
  Waktu? waktu;

  DataDetail(
      {this.judul,
      this.kelas,
      this.jurusan,
      this.showNilai,
      this.keterangan,
      this.soal,
      this.jawabanSaya,
      this.guru,
      this.resumGuru,
      this.waktu});

  DataDetail.fromJson(Map<String, dynamic> json) {
    judul = json['judul'];
    kelas = json['kelas'];
    jurusan = json['jurusan'];
    showNilai = json['show_nilai'];
    keterangan = json['keterangan'];
    soal = json['soal'] != null ? Soal?.fromJson(json['soal']) : null;
    jawabanSaya = json['jawaban_saya'] != null
        ? JawabanSaya?.fromJson(json['jawaban_saya'])
        : null;
    guru = json['guru'] != null ? Guru?.fromJson(json['guru']) : null;
    resumGuru = json['resum_guru'] != null
        ? ResumGuru?.fromJson(json['resum_guru'])
        : null;
    waktu = json['waktu'] != null ? Waktu?.fromJson(json['waktu']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['judul'] = judul;
    data['kelas'] = kelas;
    data['jurusan'] = jurusan;
    data['show_nilai'] = showNilai;
    data['keterangan'] = keterangan;
    if (soal != null) {
      data['soal'] = soal?.toJson();
    }
    if (jawabanSaya != null) {
      data['jawaban_saya'] = jawabanSaya?.toJson();
    }
    if (guru != null) {
      data['guru'] = guru?.toJson();
    }
    if (resumGuru != null) {
      data['resum_guru'] = resumGuru?.toJson();
    }
    if (waktu != null) {
      data['waktu'] = waktu?.toJson();
    }
    return data;
  }
}

class Soal {
  String? soalTipe;
  int? soalJumlah;

  Soal({this.soalTipe, this.soalJumlah});

  Soal.fromJson(Map<String, dynamic> json) {
    soalTipe = json['soal_tipe'];
    soalJumlah = json['soal_jumlah'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['soal_tipe'] = soalTipe;
    data['soal_jumlah'] = soalJumlah;
    return data;
  }
}

class JawabanSaya {
  int? totalJawab;
  int? statusRemidi;
  String? fileJawab;
  String? status;

  JawabanSaya(
      {this.totalJawab, this.statusRemidi, this.fileJawab, this.status});

  JawabanSaya.fromJson(Map<String, dynamic> json) {
    totalJawab = json['total_jawab'] ?? 0;
    statusRemidi = json['status_remidi'];
    fileJawab = json['file_jawab'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['total_jawab'] = totalJawab;
    data['status_remidi'] = statusRemidi;
    data['file_jawab'] = fileJawab;
    data['status'] = status;
    return data;
  }
}

class Guru {
  String? nama;
  String? mapel;
  String? avatar;

  Guru({this.nama, this.mapel, this.avatar});

  Guru.fromJson(Map<String, dynamic> json) {
    nama = json['nama'];
    mapel = json['mapel'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['nama'] = nama;
    data['mapel'] = mapel;
    data['avatar'] = avatar;
    return data;
  }
}

class ResumGuru {
  String? catatan;
  int? nilai;
  int? persentase;
  bool? statusSusulan;

  ResumGuru({this.catatan, this.nilai, this.persentase, this.statusSusulan});

  ResumGuru.fromJson(Map<String, dynamic> json) {
    catatan = json['catatan'];
    nilai = json['nilai'];
    persentase = json['persentase'];
    statusSusulan = json['status_susulan'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['catatan'] = catatan;
    data['nilai'] = nilai;
    data['persentase'] = persentase;
    data['status_susulan'] = statusSusulan;
    return data;
  }
}

class Waktu {
  String? tipe;
  DataWaktu? dataWaktu;

  Waktu({this.tipe, this.dataWaktu});

  Waktu.fromJson(Map<String, dynamic> json) {
    tipe = json['tipe'];
    dataWaktu = json['data_waktu'] != null
        ? DataWaktu?.fromJson(json['data_waktu'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['tipe'] = tipe;
    if (dataWaktu != null) {
      data['data_waktu'] = dataWaktu?.toJson();
    }
    return data;
  }
}

class DataWaktu {
  dynamic tanggal;
  Jam? jam;

  DataWaktu({this.tanggal, this.jam});

  DataWaktu.fromJson(Map<String, dynamic> json) {
    tanggal = json['tanggal'];
    jam = json['jam'] != null ? Jam?.fromJson(json['jam']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['tanggal'] = tanggal;
    if (jam != null) {
      data['jam'] = jam?.toJson();
    }
    return data;
  }
}

class Jam {
  String? mulai;
  String? selesai;

  Jam({this.mulai, this.selesai});

  Jam.fromJson(Map<String, dynamic> json) {
    mulai = json['mulai'];
    selesai = json['selesai'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['mulai'] = mulai;
    data['selesai'] = selesai;
    return data;
  }
}
