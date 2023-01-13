class Profil {
  bool? status;
  String? pesan;
  Biodata? biodata;
  Profil({this.status, this.pesan, this.biodata});
  Profil.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    pesan = json['pesan'];
    biodata =
        json['biodata'] != null ? Biodata?.fromJson(json['biodata']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['pesan'] = pesan;
    if (biodata != null) {
      data['biodata'] = biodata?.toJson();
    }
    return data;
  }
}

class Biodata {
  String? nis;
  String? namaSiswa;
  String? tempatLahir;
  DateTime? tglLahir;
  String? jenisKelamin;
  String? agama;
  String? alamatAsli;
  String? alamatTinggal;
  String? phone;
  String? sekolahAsal;
  String? tahunMasuk;
  String? namaIbu;
  String? namaBapak;
  String? photo;
  String? notiftoken;

  Biodata(
      {this.nis,
      this.namaSiswa,
      this.tempatLahir,
      this.tglLahir,
      this.jenisKelamin,
      this.agama,
      this.alamatAsli,
      this.alamatTinggal,
      this.phone,
      this.sekolahAsal,
      this.tahunMasuk,
      this.namaIbu,
      this.namaBapak,
      this.photo,
      this.notiftoken});

  Biodata.fromJson(Map<String, dynamic> json) {
    nis = json['nis'];
    namaSiswa = json['nama_siswa'];
    tempatLahir = json['tempat_lahir'];
    tglLahir = DateTime.parse(json['tgl_lahir'] + " 00:00:00");
    jenisKelamin = json['jenis_kelamin'];
    agama = json['agama'];
    alamatAsli = json['alamat_asli'];
    alamatTinggal = json['alamat_tinggal'];
    phone = json['phone'];
    sekolahAsal = json['sekolah_asal'];
    tahunMasuk = json['tahun_masuk'];
    namaIbu = json['nama_ibu'];
    namaBapak = json['nama_bapak'];
    photo = json['photo'];
    notiftoken = json['notiftoken'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['nis'] = nis;
    data['nama_siswa'] = namaSiswa;
    data['tempat_lahir'] = tempatLahir;
    data['tgl_lahir'] = tglLahir;
    data['jenis_kelamin'] = jenisKelamin;
    data['agama'] = agama;
    data['alamat_asli'] = alamatAsli;
    data['alamat_tinggal'] = alamatTinggal;
    data['phone'] = phone;
    data['sekolah_asal'] = sekolahAsal;
    data['tahun_masuk'] = tahunMasuk;
    data['nama_ibu'] = namaIbu;
    data['nama_bapak'] = namaBapak;
    data['photo'] = photo;
    data['notiftoken'] = notiftoken;
    return data;
  }
}
