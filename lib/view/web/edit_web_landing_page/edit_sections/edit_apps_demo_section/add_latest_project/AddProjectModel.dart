class AddProjectModel {
  AddProjectModel({
    required this.status,
    required this.msg,
    required this.data,
  });
  late final int status;
  late final String msg;
  late final List<GetProjectData> data;

  AddProjectModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    msg = json['msg'];
    data = List.from(json['data']).map((e)=>GetProjectData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['msg'] = msg;
    _data['data'] = data.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class GetProjectData {
  GetProjectData({
    required this.id,
    required this.appName,
    required this.appShortDescription,
    required this.appMediaFileType,
    required this.appMediaFile,
    required this.videoThumbnail,
    required this.registerDate,
    required this.updatedAt,
    required this.createdAt,
  });
  late final String id;
  late final String appName;
  late final String appShortDescription;
  late final String appMediaFileType;
  late final String appMediaFile;
  late final String videoThumbnail;
  late final String registerDate;
  late final String updatedAt;
  late final String createdAt;

  GetProjectData.fromJson(Map<String, dynamic> json){
    id = json['_id'];
    appName = json['app_name'];
    appShortDescription = json['app_short_description'];
    appMediaFileType = json['app_media_file_type'];
    appMediaFile = json['app_media_file'];
    videoThumbnail = json['video_thumbnail'];
    registerDate = json['register_date'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['app_name'] = appName;
    _data['app_short_description'] = appShortDescription;
    _data['app_media_file_type'] = appMediaFileType;
    _data['app_media_file'] = appMediaFile;
    _data['video_thumbnail'] = videoThumbnail;
    _data['register_date'] = registerDate;
    _data['updated_at'] = updatedAt;
    _data['created_at'] = createdAt;
    return _data;
  }
}