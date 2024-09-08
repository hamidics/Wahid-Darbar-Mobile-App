/*
 
 */

import 'package:wahiddarbar/core/utilities/static_methods.dart';

class WooCommerceErrorModel {
  String message;
  String code;
  int statusCode;

  WooCommerceErrorModel({this.message});

  WooCommerceErrorModel.fromJson(dynamic json) {
    message = SM.toStr(json['message']);
    code = SM.toStr(json['code']);
    statusCode = SM.toInt(json['data']['status']);
  }
}
