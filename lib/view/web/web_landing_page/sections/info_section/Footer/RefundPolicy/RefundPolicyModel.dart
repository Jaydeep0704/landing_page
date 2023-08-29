class RefundPolicyModel {
  RefundPolicyModel({
    required this.status,
    required this.allrefundpolicy,
  });
  late final int status;
  late final List<Allrefundpolicy> allrefundpolicy;

  RefundPolicyModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    allrefundpolicy = List.from(json['allrefundpolicy']).map((e)=>Allrefundpolicy.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['allrefundpolicy'] = allrefundpolicy.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Allrefundpolicy {
  Allrefundpolicy({
    required this.id,
    required this.refundPolicy,
    required this.updatedAt,
    required this.createdAt,
  });
  late final String id;
  late final String refundPolicy;
  late final String updatedAt;
  late final String createdAt;

  Allrefundpolicy.fromJson(Map<String, dynamic> json){
    id = json['_id'];
    refundPolicy = json['refund_policy'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['refund_policy'] = refundPolicy;
    _data['updated_at'] = updatedAt;
    _data['created_at'] = createdAt;
    return _data;
  }
}