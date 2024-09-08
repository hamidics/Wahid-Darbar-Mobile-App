/*
 
 */

import 'package:wahiddarbar/core/utilities/static_methods.dart';

class ShippingZoneLocationModel {
  String code;
  String type;

  ShippingZoneLocationModel();

  ShippingZoneLocationModel.set({
    this.code,
    this.type,
  });

  factory ShippingZoneLocationModel.fromJson(Map<String, dynamic> json) =>
      ShippingZoneLocationModel.set(
        code: SM.toStr(json['code']),
        type: SM.toStr(json['type']),
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'type': type,
      };
}
