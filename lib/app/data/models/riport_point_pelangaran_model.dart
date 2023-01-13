class RiportPointPelangaran {
  bool? status;
  String? pesan;
  DataPelangaran? data;

  RiportPointPelangaran({this.status, this.pesan, this.data});

  RiportPointPelangaran.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    pesan = json['pesan'];
    data = json['data'] != null ? DataPelangaran?.fromJson(json['data']) : null;
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

class DataPelangaran {
  int? jmlPelanggaran;
  int? totalSkor;
  List<ListPelanggaran>? listPelanggaran;

  DataPelangaran({this.jmlPelanggaran, this.totalSkor, this.listPelanggaran});

  DataPelangaran.fromJson(Map<String, dynamic> json) {
    jmlPelanggaran = json['jml_pelanggaran'];
    totalSkor = json['total_skor'];
    if (json['list_pelanggaran'] != null) {
      listPelanggaran = <ListPelanggaran>[];
      json['list_pelanggaran'].forEach((v) {
        listPelanggaran?.add(ListPelanggaran.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['jml_pelanggaran'] = jmlPelanggaran;
    data['total_skor'] = totalSkor;
    if (listPelanggaran != null) {
      data['list_pelanggaran'] =
          listPelanggaran?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListPelanggaran {
  String? namaPelanggaran;
  int? jmlSkor;
  String? tipePelanggaran;
  String? tanggalPelanggaran;

  ListPelanggaran(
      {this.namaPelanggaran,
      this.jmlSkor,
      this.tipePelanggaran,
      this.tanggalPelanggaran});

  ListPelanggaran.fromJson(Map<String, dynamic> json) {
    namaPelanggaran = json['nama_pelanggaran'];
    jmlSkor = json['jml_skor'];
    tipePelanggaran = json['tipe_pelanggaran'];
    tanggalPelanggaran = json['tanggal_pelanggaran'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['nama_pelanggaran'] = namaPelanggaran;
    data['jml_skor'] = jmlSkor;
    data['tipe_pelanggaran'] = tipePelanggaran;
    data['tanggal_pelanggaran'] = tanggalPelanggaran;
    return data;
  }
}
