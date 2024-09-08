/*
 
 */

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wahiddarbar/core/models/common_models/result_model.dart';
import 'package:wahiddarbar/core/models/food_models/food_model.dart';
import 'package:wahiddarbar/core/models/order_models/order_food_item_model.dart';
import 'package:wahiddarbar/core/models/order_models/order_line_item_model.dart';
import 'package:wahiddarbar/core/models/order_models/order_model.dart';
import 'package:wahiddarbar/core/models/order_models/order_search_model.dart';
import 'package:wahiddarbar/core/services/controllers/global_service_controller.dart';
import 'package:wahiddarbar/core/services/global_service.dart';
import 'package:wahiddarbar/core/services/order_service.dart';
import 'package:wahiddarbar/core/utilities/enums.dart';
import 'package:wahiddarbar/core/utilities/static_methods.dart';
import 'package:wahiddarbar/ui/pages/order/cart/cart_viewmodel.dart';

class OrderServiceController implements OrderService {
  @override
  GlobalService globalService = GlobalServiceController();

  @override
  CartViewModel cartViewModel;

  @override
  List<OrderLineItemModel> cart = List<OrderLineItemModel>();

  @override
  List<OrderFoodItemModel> foods = List<OrderFoodItemModel>();

  @override
  List<FoodModel> easyAccessFoods = List<FoodModel>();

  @override
  void add({OrderLineItemModel lineItem, FoodModel food}) {
    var item = cart.firstWhere(
        (element) => element.productId == lineItem.productId,
        orElse: () => null);
    var orderItem = foods.firstWhere(
        (element) => element.foodId == lineItem.productId,
        orElse: () => null);
    if (item != null && orderItem != null) {
      item.quantity++;
      orderItem.quantity++;
    } else {
      cart.add(lineItem);
      foods.add(
        OrderFoodItemModel.create(
          name: food.name,
          foodId: food.id,
          quantity: lineItem.quantity,
          salePrice: food.salePrice,
          regularPrice: food.regularPrice,
          images: food.images,
        ),
      );
      easyAccessFoods.add(food);
    }
  }

  @override
  void remove(int foodId) {
    var item = cart.firstWhere((element) => element.productId == foodId);
    var orderItem = foods.firstWhere((element) => element.foodId == foodId);
    if (item.quantity == 1) {
      cart.remove(item);
      foods.remove(orderItem);
    } else {
      item.quantity--;
      orderItem.quantity--;
    }
  }

  @override
  void addQuantity(int foodId) {
    var item = cart.firstWhere((element) => element.productId == foodId);
    var orderItem = foods.firstWhere((element) => element.foodId == foodId);
    item.quantity++;
    orderItem.quantity++;
  }

  @override
  void removeItem(int foodId) {
    var item = cart.firstWhere((element) => element.productId == foodId);
    var orderItem = foods.firstWhere((element) => element.foodId == foodId);
    cart.remove(item);
    foods.remove(orderItem);
  }

  @override
  bool find(int foodId) {
    var item = cart.firstWhere((element) => element.productId == foodId,
        orElse: () => null);
    var orderItem = foods.firstWhere((element) => element.foodId == foodId,
        orElse: () => null);
    if (item != null && orderItem != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  int getQuantity(int foodId) {
    var item = foods.firstWhere((element) => element.foodId == foodId);
    return item.quantity;
  }

  @override
  int getTotalQuantity() {
    var quantity = 0;
    for (var item in cart) {
      quantity += item.quantity;
    }
    return quantity;
  }

  @override
  String getTotalPrice() {
    int price = 0;
    for (var item in cart) {
      var itemPrice = item.quantity * int.parse(item.price);
      price += itemPrice;
    }
    return price.toString();
  }

  @override
  Future<ResultModel<OrderModel>> retrieve(int id) async {
    var result = ResultModel<OrderModel>();
    result.isSuccess = true;
    result.message = 'Success';
    result.result = OrderModel();

    var url = globalService.apiUrl + 'Orders/' + id.toString() + '?';

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

    result.result = OrderModel.fromJson(model);

    return result;
  }

  @override
  Future<ResultModel<OrderModel>> list(
      OrderSearchModel model, ActionType actionType) async {
    var result = ResultModel<OrderModel>();
    result.isSuccess = true;
    result.message = 'Success';
    result.results = List<OrderModel>();

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

  @override
  Future<ResultModel<OrderModel>> create(OrderModel model) async {
    var result = ResultModel<OrderModel>();
    result.isSuccess = true;
    result.message = 'Success';
    result.result = OrderModel();

    var url = globalService.apiUrl + 'Orders' + '?';

    url = globalService.addKeys(url);

    if (SM.locale != 'ps-AF') {
      url = globalService.addLanguage(url, SM.locale);
    }

    print(url);

    var response = await http.post(
      url,
      headers: {
        'Content-type': 'application/json',
      },
      body: json.encode(model.toJson()),
    );

    if (response.statusCode != 201) {
      result.isSuccess = false;
      result.message = response.body;
      return result;
    }

    print(response.body);

    var data = json.decode(response.body);

    print(data);

    result.result = OrderModel.fromJson(data);

    return result;
  }
}
