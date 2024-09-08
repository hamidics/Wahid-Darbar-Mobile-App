/*
 
 */

import 'package:wahiddarbar/core/utilities/static_methods.dart';

class OrderLineItemModel {
  int id;
  String name;
  int productId;
  int variationId;
  int quantity;
  String subTotal;
  String total;
  String sku;
  String price;

  OrderLineItemModel();

  OrderLineItemModel.set({
    this.id,
    this.name,
    this.productId,
    this.variationId,
    this.quantity,
    this.subTotal,
    this.total,
    this.sku,
    this.price,
  });

  OrderLineItemModel.createItem({
    this.name,
    this.productId,
    this.variationId,
    this.quantity,
    this.price,
  });

  factory OrderLineItemModel.fromJson(Map<String, dynamic> json) =>
      OrderLineItemModel.set(
        id: SM.toInt(json['id']),
        name: SM.toStr(json['name']),
        productId: SM.toInt(json['product_id']),
        variationId: SM.toInt(json['variation_id']),
        quantity: SM.toInt(json['quantity']),
        subTotal: SM.toStr(json['subtotal']),
        total: SM.toStr(json['total']),
        sku: SM.toStr(json['sku']),
        price: SM.toStr(json['price']),
      );

  Map<String, dynamic> toJson() => {
        // 'id': id,
        // 'name': name,
        'product_id': productId,
        // 'variation_id': variationId,
        'quantity': quantity,
        // 'subtotal': subTotal,
        // 'total': total,
        // 'sku': sku,
        // 'price': price,
      };
}
