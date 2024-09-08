/*
 
 */

import 'package:wahiddarbar/core/models/common_models/image_model.dart';
import 'package:wahiddarbar/core/utilities/static_methods.dart';

class FoodCategoryModel {
  int id;
  String name;
  String slug;
  int parent;
  String description;
  String display;
  ImageModel image;
  int menuOrder;
  int count;

  FoodCategoryModel();

  FoodCategoryModel.set({
    this.id,
    this.name,
    this.slug,
    this.parent,
    this.description,
    this.display,
    this.image,
    this.menuOrder,
    this.count,
  });

  factory FoodCategoryModel.fromJson(Map<String, dynamic> json) =>
      FoodCategoryModel.set(
        id: SM.toInt(json['id']),
        name: SM.toStr(json['name']),
        slug: SM.toStr(json['slug']),
        parent: SM.toInt(json['parent']),
        description: SM.toStr(json['description']),
        display: SM.toStr(json['display']),
        image: json['image'] != null
            ? ImageModel.fromJson(json['image'])
            : ImageModel.image(),
        menuOrder: SM.toInt(json['menu_order']),
        count: SM.toInt(json['count']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'slug': slug,
        'parent': parent,
        'description': description,
        'display': display,
        'image': image.toJson(),
        'menu_order': menuOrder,
        'count': count,
      };

  FoodCategoryModel.createBase({
    this.id,
    this.name,
    this.slug,
    this.parent,
    this.image,
  });
}
