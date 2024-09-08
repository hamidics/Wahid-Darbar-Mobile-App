/*
 
 */

import 'package:wahiddarbar/core/models/common_models/result_model.dart';
import 'package:wahiddarbar/core/models/food_models/food_category_model.dart';
import 'package:wahiddarbar/core/models/food_models/food_category_search_model.dart';
import 'package:wahiddarbar/core/services/global_service.dart';

abstract class CategoryService {
  GlobalService globalService;

  Future<ResultModel<FoodCategoryModel>> getCategory(String id);

  Future<ResultModel<FoodCategoryModel>> allCategories(
      FoodCategorySearchModel model);

  Future<ResultModel<FoodCategoryModel>> randomCategory(
      FoodCategorySearchModel model);

  Future<ResultModel<FoodCategoryModel>> searchCategories(
      FoodCategorySearchModel model);

  Future<ResultModel<FoodCategoryModel>> subCategories(
      FoodCategorySearchModel model);
}
