class SceduleDate {
  bool? status;
  String? pesan;
  Data? data;

  SceduleDate({this.status, this.pesan, this.data});

  SceduleDate.fromJson(Map<String, dynamic> json) {
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
  String? tipeJadwal;
  List<DataJadwalDate>? dataJadwal;

  Data({this.tipeJadwal, this.dataJadwal});

  Data.fromJson(Map<String, dynamic> json) {
    tipeJadwal = json['tipe_jadwal'];
    if (json['data_jadwal'] != null) {
      dataJadwal = <DataJadwalDate>[];
      json['data_jadwal'].forEach((v) {
        dataJadwal?.add(DataJadwalDate.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['tipe_jadwal'] = tipeJadwal;
    if (dataJadwal != null) {
      data['data_jadwal'] = dataJadwal?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataJadwalDate {
  int? id;
  String? hari;
  List<Jadwal>? jadwal;

  DataJadwalDate({this.id, this.hari, this.jadwal});

  DataJadwalDate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hari = json['hari'];
    if (json['jadwal'] != null) {
      jadwal = <Jadwal>[];
      json['jadwal'].forEach((v) {
        jadwal?.add(Jadwal.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['hari'] = hari;
    if (jadwal != null) {
      data['jadwal'] = jadwal?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Jadwal {
  DateTime? tanggal;
  List<DataTanggal>? dataTanggal;

  Jadwal({this.tanggal, this.dataTanggal});

  Jadwal.fromJson(Map<String, dynamic> json) {
    tanggal = DateTime.parse(json["tanggal"]);
    if (json['data_tanggal'] != null) {
      dataTanggal = <DataTanggal>[];
      json['data_tanggal'].forEach((v) {
        dataTanggal?.add(DataTanggal.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['tanggal'] = tanggal;
    if (dataTanggal != null) {
      data['data_tanggal'] = dataTanggal?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataTanggal {
  String? tanggal;
  Jam? jam;
  String? mapel;
  String? namaGuru;
  String? avatarGuru;

  DataTanggal(
      {this.tanggal, this.jam, this.mapel, this.namaGuru, this.avatarGuru});

  DataTanggal.fromJson(Map<String, dynamic> json) {
    tanggal = json['tanggal'];
    jam = json['jam'] != null ? Jam?.fromJson(json['jam']) : null;
    mapel = json['mapel'];
    namaGuru = json['nama_guru'];
    avatarGuru = json['avatar_guru'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['tanggal'] = tanggal;
    if (jam != null) {
      data['jam'] = jam?.toJson();
    }
    data['mapel'] = mapel;
    data['nama_guru'] = namaGuru;
    data['avatar_guru'] = avatarGuru;
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
