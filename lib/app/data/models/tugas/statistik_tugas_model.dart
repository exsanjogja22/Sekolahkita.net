class StatistikTugas {
  bool? status;
  DataStatistikTugas? data;
  String? pesan;

  StatistikTugas({this.status, this.data, this.pesan});
  StatistikTugas.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null
        ? DataStatistikTugas?.fromJson(json['data'])
        : null;
    pesan = json['pesan'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    if (data.isNotEmpty) {
      data['data'] = data;
    }
    data['pesan'] = pesan;
    return data;
  }
}

class DataStatistikTugas {
  String? tahun;
  String? semester;
  Statistik? statistik;

  DataStatistikTugas({this.tahun, this.semester, this.statistik});

  DataStatistikTugas.fromJson(Map<String, dynamic> json) {
    tahun = json['tahun'];
    semester = json['semester'];
    statistik = json['statistik'] != null
        ? Statistik?.fromJson(json['statistik'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['tahun'] = tahun;
    data['semester'] = semester;
    if (statistik != null) {
      data['statistik'] = statistik?.toJson();
    }
    return data;
  }
}

class Statistik {
  int? semuaTugas;
  int? belumDikerjakan;
  int? jumlahRemidi;
  int? remidiSelesai;

  Statistik(
      {this.semuaTugas,
      this.belumDikerjakan,
      this.jumlahRemidi,
      this.remidiSelesai});

  Statistik.fromJson(Map<String, dynamic> json) {
    semuaTugas = json['semua_tugas'];
    belumDikerjakan = json['belum_dikerjakan'];
    jumlahRemidi = json['jumlah_remidi'];
    remidiSelesai = json['remidi_selesai'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['semua_tugas'] = semuaTugas;
    data['belum_dikerjakan'] = belumDikerjakan;
    data['jumlah_remidi'] = jumlahRemidi;
    data['remidi_selesai'] = remidiSelesai;
    return data;
  }
}
