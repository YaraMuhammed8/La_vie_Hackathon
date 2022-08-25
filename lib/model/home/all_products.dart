import 'package:la_vie/model/home/plants.dart';
import 'package:la_vie/model/home/seeds.dart';
import 'package:la_vie/model/home/tools.dart';

class AllProductsResponse {
  AllProductsResponse({
    required this.type,
    required this.message,
    required this.data,
  });
  late final String type;
  late final String message;
  late final Products data;

  AllProductsResponse.fromJson(Map<String, dynamic> json){
    type = json['type'];
    message = json['message'];
    data = Products.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['type'] = type;
    _data['message'] = message;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Products {
  Products({
    required this.plants,
    required this.seeds,
    required this.tools,
  });
  late final List<Plant> plants;
  late final List<Seed> seeds;
  late final List<Tool> tools;

  Products.fromJson(Map<String, dynamic> json){
    plants = List.from(json['plants']).map((e)=>Plant.fromJson(e)).toList();
    seeds = List.from(json['seeds']).map((e)=>Seed.fromJson(e)).toList();
    tools = List.from(json['tools']).map((e)=>Tool.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['plants'] = plants.map((e)=>e.toJson()).toList();
    _data['seeds'] = seeds.map((e)=>e.toJson()).toList();
    _data['tools'] = tools.map((e)=>e.toJson()).toList();
    return _data;
  }
}