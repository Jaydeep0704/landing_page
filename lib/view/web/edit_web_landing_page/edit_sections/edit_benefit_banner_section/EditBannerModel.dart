class BannerModel {
  BannerModel({
    required this.status,
    required this.msg,
    required this.data,
  });
  late final int status;
  late final String msg;
  late final List<BannerData> data;

  BannerModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    msg = json['msg'];
    data = List.from(json['data']).map((e)=>BannerData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['msg'] = msg;
    _data['data'] = data.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class BannerData {
  BannerData({
    required this.id,
    required this.title,
    required this.description,
    required this.registerDate,
    required this.updatedAt,
    required this.createdAt,
  });
  late final String id;
  late final String title;
  late final String description;
  late final String registerDate;
  late final String updatedAt;
  late final String createdAt;

  BannerData.fromJson(Map<String, dynamic> json){
    id = json['_id'];
    title = json['title'];
    description = json['description'];
    registerDate = json['register_date'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['title'] = title;
    _data['description'] = description;
    _data['register_date'] = registerDate;
    _data['updated_at'] = updatedAt;
    _data['created_at'] = createdAt;
    return _data;
  }
}