class RiportKelasOnline {
  bool? status;
  String? pesan;
  DataKelasOnline? data;

  RiportKelasOnline({this.status, this.pesan, this.data});

  RiportKelasOnline.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    pesan = json['pesan'];
    data =
        json['data'] != null ? DataKelasOnline?.fromJson(json['data']) : null;
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

class DataKelasOnline {
  int? totalKbm;
  int? totalJoinKbm;
  int? totalNojoinKbm;
  int? persentaseJoinKbm;

  DataKelasOnline(
      {this.totalKbm,
      this.totalJoinKbm,
      this.totalNojoinKbm,
      this.persentaseJoinKbm});

  DataKelasOnline.fromJson(Map<String, dynamic> json) {
    totalKbm = json['total_kbm'];
    totalJoinKbm = json['total_join_kbm'];
    totalNojoinKbm = json['total_nojoin_kbm'];
    persentaseJoinKbm = json['persentase_join_kbm'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['total_kbm'] = totalKbm;
    data['total_join_kbm'] = totalJoinKbm;
    data['total_nojoin_kbm'] = totalNojoinKbm;
    data['persentase_join_kbm'] = persentaseJoinKbm;
    return data;
  }
}
