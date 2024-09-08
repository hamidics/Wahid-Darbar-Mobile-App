/*
 
 */

import 'package:wahiddarbar/core/utilities/static_methods.dart';

class ShippingMethodModel {
  int id;
  String title;
  String description;

  ShippingMethodModel();

  ShippingMethodModel.set({
    this.id,
    this.title,
    this.description,
  });

  factory ShippingMethodModel.fromJson(Map<String, dynamic> json) =>
      ShippingMethodModel.set(
        id: SM.toInt(json['id']),
        title: SM.toStr(json['name']),
        description: SM.toStr(json['description']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': title,
        'description': description,
      };
}
