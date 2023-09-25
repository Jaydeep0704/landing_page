// ignore_for_file: no_leading_underscores_for_local_identifiers

class PolicyPrivacy {
  PolicyPrivacy({
    required this.status,
    required this.allprivacy,
  });
  late final int status;
  late final List<AllprivacyData> allprivacy;

  PolicyPrivacy.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    allprivacy = List.from(json['allprivacy'])
        .map((e) => AllprivacyData.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['allprivacy'] = allprivacy.map((e) => e.toJson()).toList();
    return _data;
  }
}

class AllprivacyData {
  AllprivacyData({
    required this.id,
    required this.privacy,
    required this.updatedAt,
    // required this.createdAt,
  });
  late final String id;
  late final String privacy;
  late final String updatedAt;
  // late final String createdAt;

  AllprivacyData.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    privacy = json['privacy'];
    updatedAt = json['updated_at'];
    // createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['privacy'] = privacy;
    _data['updated_at'] = updatedAt;
    // _data['created_at'] = createdAt;
    return _data;
  }
}
