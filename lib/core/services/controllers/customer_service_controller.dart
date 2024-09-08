/*
 
 */

import 'dart:convert';
import 'dart:io';

import 'package:wahiddarbar/core/models/common_models/result_model.dart';
import 'package:wahiddarbar/core/models/customer_models/customer_model.dart';
import 'package:wahiddarbar/core/models/order_models/order_model.dart';
import 'package:wahiddarbar/core/models/order_models/order_search_model.dart';
import 'package:wahiddarbar/core/services/controllers/global_service_controller.dart';
import 'package:wahiddarbar/core/services/customer_service.dart';
import 'package:wahiddarbar/core/services/global_service.dart';
import 'package:wahiddarbar/core/utilities/enums.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:wahiddarbar/core/utilities/static_methods.dart';

class CustomerServiceController implements CustomerService {
  @override
  GlobalService globalService = GlobalServiceController();

  @override
  Future<ResultModel<CustomerModel>> retrieve() async {
    var result = ResultModel<CustomerModel>();
    result.isSuccess = true;
    result.message = 'Success';
    result.result = CustomerModel();

    var userId;

    await SharedPreferences.getInstance()
        .then((value) => userId = value.getString('userId'));

    var url = globalService.apiUrl + 'Customers/' + userId.toString() + '?';

    url = globalService.addKeys(url);

    if (SM.locale != 'ps-AF') {
      url = globalService.addLanguage(url, SM.locale);
    }

    print(url);

    var response = await http.get(
      url,
    );

    if (response.statusCode != 200) {
      result.isSuccess = false;
      result.message = response.body;
      return result;
    }

    var model = json.decode(response.body);

    result.result = CustomerModel.fromJson(model);

    return result;
  }

  @override
  Future<ResultModel<CustomerModel>> update(CustomerModel model) async {
    var result = ResultModel<CustomerModel>();
    result.isSuccess = true;
    result.message = 'Success';
    result.result = CustomerModel();

    var userId;

    await SharedPreferences.getInstance()
        .then((value) => userId = value.getString('userId'));

    var url = globalService.apiUrl + 'Customers/' + userId.toString() + '?';

    url = globalService.addKeys(url);

    if (SM.locale != 'ps-AF') {
      url = globalService.addLanguage(url, SM.locale);
    }

    print(url);

    var response = await http.put(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: json.encode(model.toJson()),
    );

    print(response.statusCode);
    if (response.statusCode != 200) {
      result.isSuccess = false;
      result.message = response.body;
      return result;
    }

    var customer = json.decode(response.body);

    result.result = CustomerModel.fromJson(customer);

    return result;
  }

  @override
  Future<ResultModel<OrderModel>> orders(
      OrderSearchModel model, ActionType actionType) async {
    var result = ResultModel<OrderModel>();
    result.isSuccess = true;
    result.message = 'Success';
    result.results = List<OrderModel>();

    await SharedPreferences.getInstance()
        .then((value) => model.customer = int.parse(value.getString('userId')));

    var url = globalService.apiUrl + 'Orders';

    if (actionType == ActionType.Latest) {
      url += model.customerQuery();
    } else if (actionType == ActionType.Search) {
      url += model.searchQuery();
    }

    url += '&';

    url = globalService.addKeys(url);

    if (SM.locale != 'ps-AF') {
      url = globalService.addLanguage(url, SM.locale);
    }

    print(url);

    var response = await http.get(
      url,
    );

    if (response.statusCode != 200) {
      result.isSuccess = false;
      result.message = response.body;
      return result;
    }

    List data = json.decode(response.body);

    for (var i in data) {
      result.results.add(OrderModel.fromJson(i));
    }
    return result;
  }
}
