/*
 
 */

import 'dart:convert';
import 'dart:math';

import 'package:wahiddarbar/core/models/common_models/result_model.dart';
import 'package:wahiddarbar/core/models/food_models/food_model.dart';
import 'package:wahiddarbar/core/models/food_models/food_search_model.dart';
import 'package:wahiddarbar/core/services/global_service.dart';
import 'package:wahiddarbar/core/services/food_service.dart';
import 'package:wahiddarbar/core/utilities/enums.dart';
import 'package:http/http.dart' as http;
import 'package:wahiddarbar/core/utilities/static_methods.dart';

import 'global_service_controller.dart';

class FoodServiceController implements FoodService {
  @override
  GlobalService globalService = GlobalServiceController();

  @override
  Future<ResultModel<FoodModel>> randomFoods() async {
    var result = ResultModel<FoodModel>();
    result.isSuccess = true;
    result.message = 'Success';
    result.results = List<FoodModel>();

    var random = Random();

    var randomPage = random.nextInt(10) + 1;

    var randomQuery = '?page=$randomPage&per_page=7';

    var url = globalService.apiUrl + 'Foods' + randomQuery + '&';

    url = globalService.addKeys(url);

    url = globalService.addLanguage(url, SM.locale);

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
      result.results.add(FoodModel.fromJson(i));
    }
    return result;
  }

  @override
  Future<ResultModel<FoodModel>> retrieve(int id) async {
    var result = ResultModel<FoodModel>();
    result.isSuccess = true;
    result.message = 'Success';
    result.result = FoodModel();

    var url = globalService.apiUrl + 'Products/' + id.toString() + '?';

    url = globalService.addKeys(url);

    url = globalService.addLanguage(url, SM.locale);

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

    result.result = FoodModel.fromJson(model);

    return result;
  }

  @override
  Future<ResultModel<FoodModel>> list(
      FoodSearchModel model, ActionType actionType) async {
    var result = ResultModel<FoodModel>();
    result.isSuccess = true;
    result.message = 'Success';
    result.results = List<FoodModel>();

    var url = globalService.apiUrl + 'Products';

    if (actionType == ActionType.Latest) {
      url += model.latestQuery();
    } else if (actionType == ActionType.Category) {
      url += model.categoryQuery();
    } else if (actionType == ActionType.Search) {
      url += model.searchQuery();
    } else if (actionType == ActionType.SearchAndCategory) {
      url += model.searchAndCategoryQuery();
    } else if (actionType == ActionType.Include) {
      url += model.includeQuery();
    }

    url += '&';

    url = globalService.addKeys(url);

    url = globalService.addLanguage(url, SM.locale);

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
      result.results.add(FoodModel.fromJson(i));
    }
    return result;
  }
}
