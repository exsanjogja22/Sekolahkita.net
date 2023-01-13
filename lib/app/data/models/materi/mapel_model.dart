class Mapel {
  String? idkelas;
  String? pesan;
  bool? status;
  List<DataMapel>? data;

  Mapel({this.idkelas, this.pesan, this.status, this.data});

  Mapel.fromJson(Map<String, dynamic> json) {
    idkelas = json['idkelas'];
    pesan = json['pesan'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DataMapel>[];
      json['data'].forEach((v) {
        data?.add(DataMapel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['idkelas'] = idkelas;
    data['pesan'] = pesan;
    data['status'] = status;
    if (data.isNotEmpty) {
      data['data'] = data;
    }
    return data;
  }
}

class DataMapel {
  String? id;
  String? idkelas;
  String? nama;
  String? img;

  DataMapel({this.id, this.idkelas, this.nama, this.img});

  DataMapel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idkelas = json['idkelas'];
    nama = json['nama'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['idkelas'] = idkelas;
    data['nama'] = nama;
    data['img'] = img;
    return data;
  }
}
