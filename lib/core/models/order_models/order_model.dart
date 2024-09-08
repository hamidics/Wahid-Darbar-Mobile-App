/*
 
 */
import 'package:easy_localization/easy_localization.dart';
import 'package:wahiddarbar/core/models/customer_models/customer_billing_model.dart';
import 'package:wahiddarbar/core/models/customer_models/customer_shipping_model.dart';
import 'package:wahiddarbar/core/models/order_models/order_coupon_line_model.dart';
import 'package:wahiddarbar/core/models/order_models/order_fee_line_model.dart';
import 'package:wahiddarbar/core/models/order_models/order_line_item_model.dart';
import 'package:wahiddarbar/core/models/order_models/order_shipping_line_model.dart';

class OrderModel {
  int id;
  String number;
  String orderKey;
  String createdVia;
  String status;
  String currency;
  DateTime dateCreated;
  String discountTotal;
  String shippingTotal;
  String total;
  int customerId;
  String customerIpAddress;
  String customerNote;
  CustomerBillingModel billing;
  CustomerShippingModel shipping;
  String paymentMethod;
  String paymentMethodTitle;
  String transactionId;
  DateTime datePaid;
  DateTime dateCompleted;
  String cartHash;
  List<OrderLineItemModel> lineItems;
  List<OrderShippingLineModel> shippingLines;
  List<OrderFeeLineModel> feeLines;
  List<OrderCouponLineModel> couponLines;
  bool setPaid;

  OrderModel();

  OrderModel.set({
    this.id,
    this.number,
    this.orderKey,
    this.createdVia,
    this.status,
    this.currency,
    this.dateCreated,
    this.discountTotal,
    this.shippingTotal,
    this.total,
    this.customerId,
    this.customerIpAddress,
    this.customerNote,
    this.billing,
    this.shipping,
    this.paymentMethod,
    this.paymentMethodTitle,
    this.transactionId,
    this.datePaid,
    this.dateCompleted,
    this.cartHash,
    this.lineItems,
    this.shippingLines,
    this.feeLines,
    this.couponLines,
    this.setPaid,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel.set(
        id: json['id'],
        number: json['number'],
        orderKey: json['order_key'],
        createdVia: json['created_via'],
        status: json['status'],
        currency: json['currency'],
        dateCreated: DateTime.parse(json['date_created']),
        discountTotal: json['discount_total'],
        shippingTotal: json['shipping_total'],
        total: json['total'],
        customerId: json['customer_id'],
        customerIpAddress: json['customer_ip_address'],
        customerNote: json['customer_note'],
        billing: CustomerBillingModel.fromJson(json['billing']),
        shipping: CustomerShippingModel.fromJson(json['shipping']),
        paymentMethod: json['payment_method'],
        paymentMethodTitle: json['payment_method_title'],
        transactionId: json['transaction_id'],
        datePaid: json['date_paid'],
        dateCompleted: json['date_completed'],
        cartHash: json['cart_hash'],
        lineItems: List<OrderLineItemModel>.from(
            json['line_items'].map((x) => OrderLineItemModel.fromJson(x))),
        shippingLines: List<OrderShippingLineModel>.from(json['shipping_lines']
            .map((x) => OrderShippingLineModel.fromJson(x))),
        feeLines: List<OrderFeeLineModel>.from(
            json['fee_lines'].map((x) => OrderFeeLineModel.fromJson(x))),
        couponLines: List<OrderCouponLineModel>.from(
            json['coupon_lines'].map((x) => OrderCouponLineModel.fromJson(x))),
      );

  OrderModel.create({
    this.customerId,
    this.customerNote,
    this.billing,
    this.shipping,
    this.paymentMethod = 'cod',
    this.paymentMethodTitle = 'پرداخت هنگام دریافت محصول',
    this.lineItems,
    this.shippingLines,
    this.feeLines,
    this.couponLines,
    this.setPaid = false,
  });

  Map<String, dynamic> toJson() => {
        'customer_id': customerId,
        'customer_note': customerNote,
        'billing': billing.toJson(),
        'shipping': shipping.toJson(),
        'payment_method': paymentMethod,
        'payment_method_title': paymentMethodTitle,
        'set_paid': false,
        'line_items': lineItems.map((x) => x.toJson()).toList(),
        'shipping_lines': shippingLines.map((x) => x).toList(),
        'fee_lines': feeLines.map((x) => x).toList(),
        'coupon_lines': couponLines.map((x) => x).toList(),
      };

  getStatusTitle() {
    switch (status) {
      case 'any':
        return 'any'.tr();
        break;
      case 'pending':
        return 'pending'.tr();
        break;
      case 'processing':
        return 'processing'.tr();
        break;
      case 'on-hold':
        return 'on-hold'.tr();
        break;
      case 'completed':
        return 'completed'.tr();
        break;
      case 'cancelled':
        return 'cancelled'.tr();
        break;
      case 'refunded':
        return 'refunded'.tr();
        break;
      case 'failed':
        return 'failed'.tr();
        break;
      case 'trash':
        return 'trash'.tr();
        break;
    }
  }
}
