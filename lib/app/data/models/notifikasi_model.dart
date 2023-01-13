class Notifikasi {
  bool? status;
  String? pesan;
  List<Data>? data;

  Notifikasi({this.status, this.pesan, this.data});

  Notifikasi.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    pesan = json['pesan'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
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

class Data {
  String? dari;
  String? detail;
  Waktu? waktu;

  Data({this.dari, this.detail, this.waktu});

  Data.fromJson(Map<String, dynamic> json) {
    dari = json['dari'];
    detail = json['detail'];
    waktu = json['waktu'] != null ? Waktu?.fromJson(json['waktu']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['dari'] = dari;
    data['detail'] = detail;
    if (waktu != null) {
      data['waktu'] = waktu?.toJson();
    }
    return data;
  }
}

class Waktu {
  String? statusWaktu;
  DateTime? startDate;
  DateTime? endDate;
  String? startTime;
  String? endTime;

  Waktu(
      {this.statusWaktu,
      this.startDate,
      this.endDate,
      this.startTime,
      this.endTime});

  Waktu.fromJson(Map<String, dynamic> json) {
    statusWaktu = json['status_waktu'];
    startDate = DateTime.parse(json['start_date']);
    endDate = DateTime.parse(json['end_date']);
    startTime = json['start_time'];
    endTime = json['end_time'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status_waktu'] = statusWaktu;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    return data;
  }
}
