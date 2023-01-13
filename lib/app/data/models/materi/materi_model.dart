class Materi {
  String? pesan;
  DataMateri? dataMateri;
  bool? status;

  Materi({this.pesan, this.dataMateri, this.status});

  Materi.fromJson(Map<String, dynamic> json) {
    pesan = json['pesan'];
    dataMateri =
        json['data'] != null ? DataMateri?.fromJson(json['data']) : null;
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

class DataMateri {
  String? mapel;
  String? topik;
  List<ListMateri>? data;
  String? totalData;

  DataMateri({this.mapel, this.topik, this.data, this.totalData});

  DataMateri.fromJson(Map<String, dynamic> json) {
    mapel = json['mapel'];
    topik = json['topik'];
    if (json['data'] != null) {
      data = <ListMateri>[];
      json['data'].forEach((v) {
        data?.add(ListMateri.fromJson(v));
      });
    }
    totalData = json['totalData'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['mapel'] = mapel;
    data['topik'] = topik;
    if (data.isEmpty) {
      data['data'] = data;
    }
    data['totalData'] = totalData;
    return data;
  }
}

class ListMateri {
  String? id;
  String? judul;
  String? jenjang;
  String? materiType;
  int? countExternalLink;
  Waktu? waktu;
  Guru? guru;

  ListMateri(
      {this.id,
      this.judul,
      this.jenjang,
      this.materiType,
      this.countExternalLink,
      this.waktu,
      this.guru});

  ListMateri.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    judul = json['judul'];
    jenjang = json['jenjang'];
    materiType = json['materi_type'];
    countExternalLink = json['count_external_link'];
    waktu = json['waktu'] != null ? Waktu?.fromJson(json['waktu']) : null;
    guru = json['guru'] != null ? Guru?.fromJson(json['guru']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['judul'] = judul;
    data['jenjang'] = jenjang;
    data['materi_type'] = materiType;
    data['count_external_link'] = countExternalLink;
    if (waktu != null) {
      data['waktu'] = waktu?.toJson();
    }
    if (guru != null) {
      data['guru'] = guru?.toJson();
    }
    return data;
  }
}

class Waktu {
  DateTime? created;
  DateTime? updated;

  Waktu({this.created, this.updated});

  Waktu.fromJson(Map<String, dynamic> json) {
    created = DateTime.parse(json['created']);
    updated = DateTime.parse(json['updated']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['created'] = created;
    data['updated'] = updated;
    return data;
  }
}

class Guru {
  String? namaGuru;
  String? photo;
  String? namaPelajaran;

  Guru({this.namaGuru, this.photo, this.namaPelajaran});

  Guru.fromJson(Map<String, dynamic> json) {
    namaGuru = json['nama_guru'];
    photo = json['photo'];
    namaPelajaran = json['nama_pelajaran'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['nama_guru'] = namaGuru;
    data['photo'] = photo;
    data['nama_pelajaran'] = namaPelajaran;
    return data;
  }
}
