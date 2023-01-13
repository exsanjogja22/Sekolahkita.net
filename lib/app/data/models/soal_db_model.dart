class SoalDb {
  String? id;
  String? path;
  String? createdAt;
  String? updatedAt;

  SoalDb({this.id, this.path, this.createdAt, this.updatedAt});

  SoalDb.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    path = json['path'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['path'] = path;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
