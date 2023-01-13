class TopikMateri {
  bool? status;
  String? pesan;
  List<DataTopik>? data;

  TopikMateri({this.status, this.pesan, this.data});

  TopikMateri.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    pesan = json['pesan'];
    if (json['data'] != null) {
      data = <DataTopik>[];
      json['data'].forEach((v) {
        data?.add(DataTopik.fromJson(v));
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

class DataTopik {
  String? id;
  String? nama;

  DataTopik({this.id, this.nama});

  DataTopik.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['nama'] = nama;
    return data;
  }
}
