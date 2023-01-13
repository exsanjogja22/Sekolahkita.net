class SoalEssay {
  bool? status;
  DataSoalEssay? data;

  SoalEssay({this.status, this.data});

  SoalEssay.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? DataSoalEssay?.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    if (data.isNotEmpty) {
      data['data'] = data;
    }
    return data;
  }
}

class DataSoalEssay {
  String? judul;
  String? kelas;
  String? jurusan;
  String? pesan;
  Soal? soal;
  Jawabansaya? jawabansaya;
  String? soalTipe;
  Waktu? waktu;
  String? statusTes;

  DataSoalEssay(
      {this.judul,
      this.kelas,
      this.jurusan,
      this.pesan,
      this.soal,
      this.jawabansaya,
      this.soalTipe,
      this.waktu,
      this.statusTes});

  DataSoalEssay.fromJson(Map<String, dynamic> json) {
    judul = json['judul'];
    kelas = json['kelas'];
    jurusan = json['jurusan'];
    pesan = json['pesan'];
    soal = json['soal'] != null ? Soal?.fromJson(json['soal']) : null;
    jawabansaya = json['jawabansaya'] != null
        ? Jawabansaya?.fromJson(json['jawabansaya'])
        : null;
    soalTipe = json['soal_tipe'];
    waktu = json['waktu'] != null ? Waktu?.fromJson(json['waktu']) : null;
    statusTes = json['status_tes'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['judul'] = judul;
    data['kelas'] = kelas;
    data['jurusan'] = jurusan;
    data['pesan'] = pesan;
    if (soal != null) {
      data['soal'] = soal?.toJson();
    }
    if (jawabansaya != null) {
      data['jawabansaya'] = jawabansaya?.toJson();
    }
    data['soal_tipe'] = soalTipe;
    if (waktu != null) {
      data['waktu'] = waktu?.toJson();
    }
    data['status_tes'] = statusTes;
    return data;
  }
}

class Soal {
  String? file;
  String? text;
  bool? status;
  String? ext;
  String? type;
  String? pesan;

  Soal({this.file, this.text, this.status, this.ext, this.type, this.pesan});

  Soal.fromJson(Map<String, dynamic> json) {
    file = json['file'] ?? "";
    text = json['text'] ?? "";
    status = json['status'];
    ext = json['ext'];
    type = json['type'];
    pesan = json['pesan'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['file'] = file;
    data['text'] = text;
    data['status'] = status;
    data['ext'] = ext;
    data['type'] = type;
    data['pesan'] = pesan;
    return data;
  }
}

class Jawabansaya {
  int? progress;
  String? filejawban;
  String? linkexternal;
  String? keterangan;

  Jawabansaya(
      {this.progress, this.filejawban, this.linkexternal, this.keterangan});

  Jawabansaya.fromJson(Map<String, dynamic> json) {
    progress = json['progress'];
    filejawban = json['filejawban'];
    linkexternal = json['linkexternal'];
    keterangan = json['keterangan'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['progress'] = progress;
    data['filejawban'] = filejawban;
    data['linkexternal'] = linkexternal;
    data['keterangan'] = keterangan;
    return data;
  }
}

class Waktu {
  String? startTanggal;
  String? endTanggal;
  String? startTime;
  String? endTime;
  String? status;
  String? waktuStatus;

  Waktu(
      {this.startTanggal,
      this.endTanggal,
      this.startTime,
      this.endTime,
      this.status,
      this.waktuStatus});

  Waktu.fromJson(Map<String, dynamic> json) {
    startTanggal = json['start_tanggal'];
    endTanggal = json['end_tanggal'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    status = json['status'];
    waktuStatus = json['waktu_status'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['start_tanggal'] = startTanggal;
    data['end_tanggal'] = endTanggal;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['status'] = status;
    data['waktu_status'] = waktuStatus;
    return data;
  }
}
