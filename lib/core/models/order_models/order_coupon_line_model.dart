/*
 
 */

import 'package:wahiddarbar/core/utilities/static_methods.dart';

class OrderCouponLineModel {
  int id;
  String code;
  String discount;

  OrderCouponLineModel();

  OrderCouponLineModel.set({
    this.id,
    this.code,
    this.discount,
  });

  factory OrderCouponLineModel.fromJson(Map<String, dynamic> json) =>
      OrderCouponLineModel.set(
        id: SM.toInt(json['id']),
        code: SM.toStr(json['code']),
        discount: SM.toStr(json['discount']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'code': code,
        'discount': discount,
      };
}
