class ReorderComponentModel {
  ReorderComponentModel({
    required this.status,
    required this.msg,
    required this.data,
  });
  late final int status;
  late final String msg;
  late final List<ComponentList> data;

  ReorderComponentModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    msg = json['msg'];
    data = List.from(json['data']).map((e)=>ComponentList.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['msg'] = msg;
    _data['data'] = data.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class ComponentList {
  ComponentList({
    required this.id,
    required this.componentName,
    required this.componentIndex,
  });
  late final String id;
  late final String componentName;
  late final String componentIndex;

  ComponentList.fromJson(Map<String, dynamic> json){
    id = json['_id'];
    componentName = json['component_name'];
    componentIndex = json['component_index'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['component_name'] = componentName;
    _data['component_index'] = componentIndex;
    return _data;
  }
}