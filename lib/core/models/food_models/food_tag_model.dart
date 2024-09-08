/*
 
 */

import 'package:wahiddarbar/core/utilities/static_methods.dart';

class FoodTagModel {
  int id;
  String name;
  String slug;

  FoodTagModel();

  FoodTagModel.set({this.id, this.name, this.slug});

  factory FoodTagModel.fromJson(Map<String, dynamic> json) => FoodTagModel.set(
        id: SM.toInt(json['id']),
        name: SM.toStr(json['name']),
        slug: SM.toStr(json['slug']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'slug': slug,
      };
}
