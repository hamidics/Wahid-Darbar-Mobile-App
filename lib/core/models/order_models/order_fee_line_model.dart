/*
 
 */

import 'package:wahiddarbar/core/utilities/static_methods.dart';

class OrderFeeLineModel {
  int id;
  String name;
  String total;

  OrderFeeLineModel();

  OrderFeeLineModel.set({
    this.id,
    this.name,
    this.total,
  });

  factory OrderFeeLineModel.fromJson(Map<String, dynamic> json) =>
      OrderFeeLineModel.set(
        id: SM.toInt(json['id']),
        name: SM.toStr(json['name']),
        total: SM.toStr(json['total']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'total': total,
      };
}
