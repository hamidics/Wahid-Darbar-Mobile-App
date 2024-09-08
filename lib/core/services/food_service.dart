/*
 
 */

import 'package:wahiddarbar/core/models/common_models/result_model.dart';
import 'package:wahiddarbar/core/models/food_models/food_model.dart';
import 'package:wahiddarbar/core/models/food_models/food_search_model.dart';
import 'package:wahiddarbar/core/services/global_service.dart';
import 'package:wahiddarbar/core/utilities/enums.dart';

abstract class FoodService {
  GlobalService globalService;

  Future<ResultModel<FoodModel>> randomFoods();

  Future<ResultModel<FoodModel>> retrieve(int id);

  Future<ResultModel<FoodModel>> list(
      FoodSearchModel model, ActionType actionType);
}
