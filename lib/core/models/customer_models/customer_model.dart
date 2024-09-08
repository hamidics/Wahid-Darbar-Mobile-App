/*
 
 */

import 'package:wahiddarbar/core/models/customer_models/customer_billing_model.dart';
import 'package:wahiddarbar/core/models/customer_models/customer_shipping_model.dart';
import 'package:wahiddarbar/core/utilities/static_methods.dart';

class CustomerModel {
  int id;
  String email;
  String firstName;
  String lastName;
  String userName;
  String password;
  CustomerBillingModel billing;
  CustomerShippingModel shipping;
  bool isPayingCustomer;
  String avatarUrl;
  String role;

  CustomerModel();

  CustomerModel.create({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.userName,
    this.billing,
    this.shipping,
    this.isPayingCustomer,
    this.avatarUrl,
    this.role,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) =>
      CustomerModel.create(
          id: SM.toInt(json['id']),
          email: SM.toStr(json['email']),
          firstName: SM.toStr(json['first_name']),
          lastName: SM.toStr(json['last_name']),
          userName: SM.toStr(json['username']),
          billing: CustomerBillingModel.fromJson(json['billing']),
          shipping: CustomerShippingModel.fromJson(json['shipping']),
          isPayingCustomer: SM.toBool(json['is_paying_customer']),
          avatarUrl: SM.toStr(json['avatar_url']),
          role: SM.toStr(json['role']));

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'first_name': firstName,
        'last_name': lastName,
        'username': userName,
        'billing': billing.toJson(),
        'shipping': shipping.toJson(),
        'is_paying_customer': isPayingCustomer,
        'avatar_url': avatarUrl,
        'role': role,
      };
}
