/*
 
 */

import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:wahiddarbar/core/models/order_models/order_model.dart';
import 'package:wahiddarbar/core/models/order_models/order_search_model.dart';
import 'package:wahiddarbar/core/services/order_service.dart';
import 'package:wahiddarbar/core/utilities/enums.dart';
import 'package:wahiddarbar/core/utilities/service_locator.dart';

class CustomerOrderListViewModel extends FutureViewModel {
  final OrderService _orderService = locator<OrderService>();

  List<OrderModel> orders = List<OrderModel>();

  @override
  Future futureToRun() async {
    await initialize();
  }

  Future initialize() async {
    await getOrders();
    notifyListeners();
  }

  Future getOrders() async {
    var userId;
    await SharedPreferences.getInstance()
        .then((value) => userId = int.parse(value.getString('userId')));

    var searchModel = OrderSearchModel.customer(customer: userId);

    setBusy(true);
    var result = await _orderService.list(searchModel, ActionType.Latest);
    if (result.isSuccess == false) {
      print(result.message);
      setBusy(false);
      notifyListeners();
      return;
    }
    orders.addAll(result.results);
    setBusy(false);
    notifyListeners();
  }

  String convertedDate(String date) {
    if (date.contains('فروردین')) {
      date = date.replaceAll('فروردین', 'حمل');
    } else if (date.contains('تیر')) {
      date = date.replaceAll('تیر', 'سرطان');
    } else if (date.contains('مهر')) {
      date = date.replaceAll('مهر', 'میزان');
    } else if (date.contains('دی')) {
      date = date.replaceAll('دی', 'جدی');
    } else if (date.contains('اردیبهشت')) {
      date = date.replaceAll('اردیبهشت', 'ثور');
    } else if (date.contains('مرداد')) {
      date = date.replaceAll('مرداد', 'اسد');
    } else if (date.contains('آبان')) {
      date = date.replaceAll('آبان', 'عقرب');
    } else if (date.contains('بهمن')) {
      date = date.replaceAll('بهمن', 'دلو');
    } else if (date.contains('خرداد')) {
      date = date.replaceAll('خرداد', 'جوزا');
    } else if (date.contains('شهریور')) {
      date = date.replaceAll('شهریور', 'سنبله');
    } else if (date.contains('آذر')) {
      date = date.replaceAll('آذر', 'قوس');
    } else if (date.contains('اسفند')) {
      date = date.replaceAll('اسفند', 'حوت');
    }
    return date;
  }
}
