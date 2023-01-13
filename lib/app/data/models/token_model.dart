class Token {
  bool? status;
  String? token;
  String? pesan;

  Token({this.status, this.token, this.pesan});

  Token.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    token = json['token'];
    pesan = json['pesan'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['token'] = token;
    data['pesan'] = pesan;
    return data;
  }
}
