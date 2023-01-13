class SceduleDay {
  bool? status;
  String? pesan;
  Data? data;

  SceduleDay({this.status, this.pesan, this.data});

  SceduleDay.fromJson(Map<String, dynamic> json) {
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
  List<DataJadwalDay>? dataJadwal;

  Data({this.tipeJadwal, this.dataJadwal});

  Data.fromJson(Map<String, dynamic> json) {
    tipeJadwal = json['tipe_jadwal'];
    if (json['data_jadwal'] != null) {
      dataJadwal = <DataJadwalDay>[];
      json['data_jadwal'].forEach((v) {
        dataJadwal?.add(DataJadwalDay.fromJson(v));
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

class DataJadwalDay {
  int? id;
  String? hari;
  List<Jadwal>? jadwal;

  DataJadwalDay({this.id, this.hari, this.jadwal});

  DataJadwalDay.fromJson(Map<String, dynamic> json) {
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
  Jam? jam;
  String? mapel;
  String? namaGuru;
  String? avatarGuru;
  Jadwal({this.jam, this.mapel, this.namaGuru, this.avatarGuru});

  Jadwal.fromJson(Map<String, dynamic> json) {
    jam = json['jam'] != null ? Jam?.fromJson(json['jam']) : null;
    mapel = json['mapel'];
    namaGuru = json['nama_guru'];
    avatarGuru = json["avatar_guru"];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (jam != null) {
      data['jam'] = jam?.toJson();
    }
    data['mapel'] = mapel;
    data['nama_guru'] = namaGuru;
    data["avatar_guru"] = avatarGuru;
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
