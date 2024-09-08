/*
 
 */

import 'package:wahiddarbar/core/models/common_models/result_model.dart';
import 'package:wahiddarbar/core/models/customer_models/customer_model.dart';
import 'package:wahiddarbar/core/models/order_models/order_model.dart';
import 'package:wahiddarbar/core/models/order_models/order_search_model.dart';
import 'package:wahiddarbar/core/services/global_service.dart';
import 'package:wahiddarbar/core/utilities/enums.dart';

abstract class CustomerService {
  GlobalService globalService;
  Future<ResultModel<CustomerModel>> retrieve();
  Future<ResultModel<CustomerModel>> update(CustomerModel model);
  Future<ResultModel<OrderModel>> orders(
      OrderSearchModel model, ActionType actionType);
}
