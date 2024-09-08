/*
 
 */

import 'package:wahiddarbar/core/utilities/static_methods.dart';

class ShippingZoneModel {
  int id;
  String name;
  int order;

  ShippingZoneModel();

  ShippingZoneModel.set({
    this.id,
    this.name,
    this.order,
  });

  factory ShippingZoneModel.fromJson(Map<String, dynamic> json) =>
      ShippingZoneModel.set(
        id: SM.toInt(json['id']),
        name: SM.toStr(json['name']),
        order: SM.toInt(json['order']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'order': order,
      };
}
