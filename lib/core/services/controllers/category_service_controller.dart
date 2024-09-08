/*
 
 */

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wahiddarbar/core/models/common_models/result_model.dart';
import 'package:wahiddarbar/core/models/food_models/food_category_model.dart';
import 'package:wahiddarbar/core/models/food_models/food_category_search_model.dart';
import 'package:wahiddarbar/core/services/category_service.dart';
import 'package:wahiddarbar/core/services/global_service.dart';
import 'package:wahiddarbar/core/utilities/static_methods.dart';

import 'global_service_controller.dart';

class CategoryServiceController implements CategoryService {
  @override
  GlobalService globalService = GlobalServiceController();

  @override
  Future<ResultModel<FoodCategoryModel>> getCategory(String id) async {
    var result = ResultModel<FoodCategoryModel>();
    result.isSuccess = true;
    result.message = 'Success';
    result.result = FoodCategoryModel();
    result.results = List<FoodCategoryModel>();

    var url = globalService.apiUrl + 'Products/Categories/' + id + '?';

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

    var data = json.decode(response.body);

    result.result = FoodCategoryModel.fromJson(data);

    return result;
  }

  @override
  Future<ResultModel<FoodCategoryModel>> allCategories(
      FoodCategorySearchModel model) async {
    var result = ResultModel<FoodCategoryModel>();
    result.isSuccess = true;
    result.message = 'Success';
    result.results = List<FoodCategoryModel>();

    var url =
        globalService.apiUrl + 'Products/Categories' + model.allQuery() + '&';

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
      result.results.add(FoodCategoryModel.fromJson(i));
    }

    result.results.sort((a, b) => a.menuOrder.compareTo(b.menuOrder));

    return result;
  }

  @override
  Future<ResultModel<FoodCategoryModel>> randomCategory(
      FoodCategorySearchModel model) async {
    var result = ResultModel<FoodCategoryModel>();
    result.isSuccess = true;
    result.message = 'Success';
    result.results = List<FoodCategoryModel>();

    var randomQuery = '?order=desc&orderby=count';

    var url = globalService.apiUrl + 'Products/Categories' + randomQuery + '&';

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
      result.results.add(FoodCategoryModel.fromJson(i));
    }
    return result;
  }

  @override
  Future<ResultModel<FoodCategoryModel>> searchCategories(
      FoodCategorySearchModel model) async {
    var result = ResultModel<FoodCategoryModel>();
    result.isSuccess = true;
    result.message = 'Success';
    result.results = List<FoodCategoryModel>();

    var url = globalService.apiUrl +
        'Products/Categories' +
        model.searchQuery() +
        '&';

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
      result.results.add(FoodCategoryModel.fromJson(i));
    }
    return result;
  }

  @override
  Future<ResultModel<FoodCategoryModel>> subCategories(
      FoodCategorySearchModel model) async {
    var result = ResultModel<FoodCategoryModel>();
    result.isSuccess = true;
    result.message = 'Success';
    result.results = List<FoodCategoryModel>();

    var url =
        globalService.apiUrl + 'Products/Categories' + model.childQuery() + '&';

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
      result.results.add(FoodCategoryModel.fromJson(i));
    }
    return result;
  }
}
