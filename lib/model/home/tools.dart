class Tools {
  Tools({
    required this.type,
    required this.message,
    required this.data,
  });
  late final String type;
  late final String message;
  late final List<Tool> data;

  Tools.fromJson(Map<String, dynamic> json){
    type = json['type'];
    message = json['message'];
    data = List.from(json['data']).map((e)=>Tool.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['type'] = type;
    _data['message'] = message;
    _data['data'] = data.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Tool {
  Tool({
    required this.toolId,
    required this.name,
    required this.description,
    required this.imageUrl,
  });
  late final String toolId;
  late final String name;
  late final String description;
  late final String imageUrl;

  Tool.fromJson(Map<String, dynamic> json){
    toolId = json['toolId'];
    name = json['name'];
    description = json['description'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['toolId'] = toolId;
    _data['name'] = name;
    _data['description'] = description;
    _data['imageUrl'] = imageUrl;
    return _data;
  }
}