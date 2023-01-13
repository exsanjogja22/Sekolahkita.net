class SoalPg {
  bool? status;
  DataSoalPg? data;

  SoalPg({this.status, this.data});

  SoalPg.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? DataSoalPg?.fromJson(json['data']) : null;
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

class DataSoalPg {
  String? judul;
  String? kelas;
  String? jurusan;
  String? pesan;
  Soal? soal;
  List<Opsijawaban>? opsijawaban;
  String? soalTipe;
  Waktu? waktu;
  String? statusTes;

  DataSoalPg(
      {this.judul,
      this.kelas,
      this.jurusan,
      this.pesan,
      this.soal,
      this.opsijawaban,
      this.soalTipe,
      this.waktu,
      this.statusTes});

  DataSoalPg.fromJson(Map<String, dynamic> json) {
    judul = json['judul'];
    kelas = json['kelas'];
    jurusan = json['jurusan'];
    pesan = json['pesan'];
    soal = json['soal'] != null ? Soal?.fromJson(json['soal']) : null;
    if (json['opsijawaban'] != null) {
      opsijawaban = <Opsijawaban>[];
      json['opsijawaban'].forEach((v) {
        opsijawaban?.add(Opsijawaban.fromJson(v));
      });
    }
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
    if (opsijawaban != null) {
      data['opsijawaban'] = opsijawaban?.map((v) => v.toJson()).toList();
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

  Soal({this.file, this.status, this.ext, this.type, this.pesan});

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

class Opsijawaban {
  int? nomor;
  List<Opsi>? opsi;

  Opsijawaban({this.nomor, this.opsi});

  Opsijawaban.fromJson(Map<String, dynamic> json) {
    nomor = json['nomor'];
    if (json['opsi'] != null) {
      opsi = <Opsi>[];
      json['opsi'].forEach((v) {
        opsi?.add(Opsi.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['nomor'] = nomor;
    if (opsi != null) {
      data['opsi'] = opsi?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Opsi {
  String? key;
  String? jawab;
  String? status;

  Opsi({this.key, this.jawab, this.status});

  Opsi.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    jawab = json['jawab'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['key'] = key;
    data['jawab'] = jawab;
    data['status'] = status;
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
