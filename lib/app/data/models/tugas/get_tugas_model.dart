class GetTugas {
  bool? status;
  String? pesan;
  DataTugas? data;

  GetTugas({this.status, this.pesan, this.data});

  GetTugas.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    pesan = json['pesan'];
    data = json['data'] != null ? DataTugas?.fromJson(json['data']) : null;
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

class DataTugas {
  int? totalTugas;
  List<Tugas>? tugas;

  DataTugas({this.totalTugas, this.tugas});

  DataTugas.fromJson(Map<String, dynamic> json) {
    totalTugas = json['totalTugas'];
    if (json['tugas'] != null) {
      tugas = <Tugas>[];
      json['tugas'].forEach((v) {
        tugas?.add(Tugas.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['totalTugas'] = totalTugas;
    if (tugas != null) {
      data['tugas'] = tugas?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tugas {
  String? idTugas;
  String? idkbm;
  String? idkelas;
  String? judul;
  String? namaGuru;
  String? namaPelajaran;
  String? idPelajaran;
  String? statusTugas;
  HasilPengerjaan? hasilPengerjaan;
  Soal? soal;
  Waktu? waktu;

  Tugas(
      {this.idTugas,
      this.idkbm,
      this.idkelas,
      this.judul,
      this.namaGuru,
      this.namaPelajaran,
      this.idPelajaran,
      this.statusTugas,
      this.hasilPengerjaan,
      this.soal,
      this.waktu});

  Tugas.fromJson(Map<String, dynamic> json) {
    idTugas = json['id_tugas'];
    idkbm = json['idkbm'];
    idkelas = json['idkelas'];
    judul = json['judul'];
    namaGuru = json['nama_guru'];
    namaPelajaran = json['nama_pelajaran'];
    idPelajaran = json['id_pelajaran'];
    statusTugas = json['status_tugas'];
    hasilPengerjaan = json['hasil_pengerjaan'] != null
        ? HasilPengerjaan?.fromJson(json['hasil_pengerjaan'])
        : null;
    soal = json['soal'] != null ? Soal?.fromJson(json['soal']) : null;
    waktu = json['waktu'] != null ? Waktu?.fromJson(json['waktu']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id_tugas'] = idTugas;
    data['idkbm'] = idkbm;
    data['idkelas'] = idkelas;
    data['judul'] = judul;
    data['nama_guru'] = namaGuru;
    data['nama_pelajaran'] = namaPelajaran;
    data['id_pelajaran'] = idPelajaran;
    data['status_tugas'] = statusTugas;
    if (hasilPengerjaan != null) {
      data['hasil_pengerjaan'] = hasilPengerjaan?.toJson();
    }
    if (soal != null) {
      data['soal'] = soal?.toJson();
    }
    if (waktu != null) {
      data['waktu'] = waktu?.toJson();
    }
    return data;
  }
}

class HasilPengerjaan {
  String? statusRemidi;
  String? statusResume;

  HasilPengerjaan({this.statusRemidi, this.statusResume});

  HasilPengerjaan.fromJson(Map<String, dynamic> json) {
    statusRemidi = json['status_remidi'].toString();
    statusResume = json['status_resume'].toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status_remidi'] = statusRemidi;
    data['status_resume'] = statusResume;
    return data;
  }
}

class Soal {
  String? jenisSoal;
  String? totalSoal;

  Soal({this.jenisSoal, this.totalSoal});
  Soal.fromJson(Map<String, dynamic> json) {
    jenisSoal = json['jenis_soal'];
    totalSoal = json['total_soal'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['jenis_soal'] = jenisSoal;
    data['total_soal'] = totalSoal;
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

class RangeTanggal {
  String? mulai;
  String? selesai;
  RangeTanggal({this.mulai, this.selesai});

  RangeTanggal.fromJson(Map<String, dynamic> json) {
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
