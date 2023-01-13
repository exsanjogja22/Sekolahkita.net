class RiportKeaktifanKbm {
  bool? status;
  String? pesan;
  List<DataRiport>? data;

  RiportKeaktifanKbm({this.status, this.pesan, this.data});

  RiportKeaktifanKbm.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    pesan = json['pesan'];
    if (json['data'] != null) {
      data = <DataRiport>[];
      json['data'].forEach((v) {
        data?.add(DataRiport.fromJson(v));
      });
    }
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

class DataRiport {
  String? mapel;
  int? jmlPertemuan;
  int? jmlHadir;
  int? jmlTidakHadir;
  int? persentaseKehadiran;

  DataRiport(
      {this.mapel,
      this.jmlPertemuan,
      this.jmlHadir,
      this.jmlTidakHadir,
      this.persentaseKehadiran});

  DataRiport.fromJson(Map<String, dynamic> json) {
    mapel = json['mapel'];
    jmlPertemuan = json['jml_pertemuan'];
    jmlHadir = json['jml_hadir'];
    jmlTidakHadir = json['jml_tidak_hadir'];
    persentaseKehadiran = json['persentase_kehadiran'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['mapel'] = mapel;
    data['jml_pertemuan'] = jmlPertemuan;
    data['jml_hadir'] = jmlHadir;
    data['jml_tidak_hadir'] = jmlTidakHadir;
    data['persentase_kehadiran'] = persentaseKehadiran;
    return data;
  }
}
