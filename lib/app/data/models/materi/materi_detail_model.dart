class MateriDetail {
  DataMateriDetail? data;
  bool? status;
  String? pesan;

  MateriDetail({this.data, this.status, this.pesan});

  MateriDetail.fromJson(Map<String, dynamic> json) {
    data =
        json['data'] != null ? DataMateriDetail?.fromJson(json['data']) : null;
    status = json['status'];
    pesan = json['pesan'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (data.isNotEmpty) {
      data['data'] = data.isEmpty;
    }
    data['status'] = status;
    data['pesan'] = pesan;
    return data;
  }
}

class DataMateriDetail {
  String? idMateri;
  String? judulMateri;
  String? namaGuru;
  String? namaPelajaran;
  String? detail;
  List<FileMateri>? file;
  Kuisioner? kuisioner;

  DataMateriDetail(
      {this.idMateri,
      this.judulMateri,
      this.namaGuru,
      this.namaPelajaran,
      this.detail,
      this.file,
      this.kuisioner});

  DataMateriDetail.fromJson(Map<String, dynamic> json) {
    idMateri = json['id_materi'];
    judulMateri = json['judul_materi'];
    namaGuru = json['nama_guru'];
    namaPelajaran = json['nama_pelajaran'];
    detail = json['detail'];
    if (json['file'] != null) {
      file = <FileMateri>[];
      json['file'].forEach((v) {
        file?.add(FileMateri.fromJson(v));
      });
    }
    kuisioner = json['kuisioner'] != null
        ? Kuisioner?.fromJson(json['kuisioner'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id_materi'] = idMateri;
    data['judul_materi'] = judulMateri;
    data['nama_guru'] = namaGuru;
    data['nama_pelajaran'] = namaPelajaran;
    data['detail'] = detail;
    if (file != null) {
      data['file'] = file?.map((v) => v.toJson()).toList();
    }
    if (kuisioner != null) {
      data['kuisioner'] = kuisioner?.toJson();
    }
    return data;
  }
}

class FileMateri {
  String? fileExtension;
  String? media;
  String? dataUrl;
  String? judul;
  String? detail;

  FileMateri(
      {this.fileExtension, this.media, this.dataUrl, this.judul, this.detail});

  FileMateri.fromJson(Map<String, dynamic> json) {
    fileExtension = json['file_extension'];
    media = json['media'];
    dataUrl = json['data_url'];
    judul = json['judul'];
    detail = json['detail'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['file_extension'] = fileExtension;
    data['media'] = media;
    data['data_url'] = dataUrl;
    data['judul'] = judul;
    data['detail'] = detail;
    return data;
  }
}

class Kuisioner {
  bool? wajibIsi;
  bool? statusIsian;
  List<DataKuisoner>? row;

  Kuisioner({this.wajibIsi, this.row});

  Kuisioner.fromJson(Map<String, dynamic> json) {
    wajibIsi = json['wajib_isi'];
    statusIsian = json['status_isian'];
    if (json['row'] != null) {
      row = <DataKuisoner>[];
      json['row'].forEach((v) {
        row?.add(DataKuisoner.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['wajib_isi'] = wajibIsi;
    data['status_isian'] = statusIsian;
    if (row != null) {
      data['row'] = row?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataKuisoner {
  String? mcId;
  String? mcJudul;
  List<OpsiJawaban>? opsiJawaban;

  DataKuisoner({this.mcId, this.mcJudul, this.opsiJawaban});

  DataKuisoner.fromJson(Map<String, dynamic> json) {
    mcId = json['mc_id'];
    mcJudul = json['mc_judul'];
    if (json['opsi_jawaban'] != null) {
      opsiJawaban = <OpsiJawaban>[];
      json['opsi_jawaban'].forEach((v) {
        opsiJawaban?.add(OpsiJawaban.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['mc_id'] = mcId;
    data['mc_judul'] = mcJudul;
    if (opsiJawaban != null) {
      data['opsi_jawaban'] = opsiJawaban?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OpsiJawaban {
  String? opsi;
  String? status;

  OpsiJawaban({this.opsi, this.status});

  OpsiJawaban.fromJson(Map<String, dynamic> json) {
    opsi = json['opsi'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['opsi'] = opsi;
    data['status'] = status;
    return data;
  }
}
