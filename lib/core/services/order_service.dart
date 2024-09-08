/*
 
 */

import 'package:wahiddarbar/core/models/common_models/result_model.dart';
import 'package:wahiddarbar/core/models/order_models/order_line_item_model.dart';
import 'package:wahiddarbar/core/models/order_models/order_model.dart';
import 'package:wahiddarbar/core/models/order_models/order_food_item_model.dart';
import 'package:wahiddarbar/core/models/order_models/order_search_model.dart';
import 'package:wahiddarbar/core/models/food_models/food_model.dart';
import 'package:wahiddarbar/core/services/global_service.dart';
import 'package:wahiddarbar/core/utilities/enums.dart';
import 'package:wahiddarbar/ui/pages/order/cart/cart_viewmodel.dart';

abstract class OrderService {
  GlobalService globalService;
  CartViewModel cartViewModel;
  List<OrderLineItemModel> cart;
  List<OrderFoodItemModel> foods;
  List<FoodModel> easyAccessFoods;
  void add({OrderLineItemModel lineItem, FoodModel food});
  void remove(int foodId);
  void addQuantity(int foodId);
  void removeItem(int foodId);
  bool find(int foodId);
  int getQuantity(int foodId);
  int getTotalQuantity();
  String getTotalPrice();
  Future<ResultModel<OrderModel>> retrieve(int id);
  Future<ResultModel<OrderModel>> list(
      OrderSearchModel model, ActionType actionType);
  Future<ResultModel<OrderModel>> create(OrderModel model);
}
