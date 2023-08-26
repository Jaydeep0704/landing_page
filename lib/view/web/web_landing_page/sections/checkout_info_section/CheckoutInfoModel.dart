class CheckOutModel {
  CheckOutModel({
    required this.status,
    required this.msg,
    required this.data,
  });
  late final int status;
  late final String msg;
  late final List<CheckOutData> data;

  CheckOutModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    msg = json['msg'];
    data = List.from(json['data']).map((e)=>CheckOutData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['msg'] = msg;
    _data['data'] = data.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class CheckOutData {
  CheckOutData({
    required this.id,
    required this.title,
    required this.description,
    required this.fileMediaType,
    required this.files,
    required this.registerDate,
    required this.updatedAt,
    required this.createdAt,
  });
  late final String id;
  late final String title;
  late final String description;
  late final String fileMediaType;
  late final String files;
  late final String registerDate;
  late final String updatedAt;
  late final String createdAt;

  CheckOutData.fromJson(Map<String, dynamic> json){
    id = json['_id'];
    title = json['title'];
    description = json['description'];
    fileMediaType = json['file_media_type'];
    files = json['files'];
    registerDate = json['register_date'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['title'] = title;
    _data['description'] = description;
    _data['file_media_type'] = fileMediaType;
    _data['files'] = files;
    _data['register_date'] = registerDate;
    _data['updated_at'] = updatedAt;
    _data['created_at'] = createdAt;
    return _data;
  }
}