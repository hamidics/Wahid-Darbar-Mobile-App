/*
 
 */

import 'package:wahiddarbar/core/utilities/static_methods.dart';

class OrderShippingLineModel {
  int id;
  String methodTitle;
  String methodId;
  String total;

  OrderShippingLineModel();

  OrderShippingLineModel.create({
    this.methodTitle,
    this.methodId,
    this.total,
  });

  factory OrderShippingLineModel.fromJson(Map<String, dynamic> json) =>
      OrderShippingLineModel.create(
        methodTitle: SM.toStr(json['method_title']),
        methodId: SM.toStr(json['method_id']),
        total: SM.toStr(json['total']),
      );

  Map<String, dynamic> toJson() => {
        'method_title': methodTitle,
        'method_id': methodId,
        'total': total,
      };
}
