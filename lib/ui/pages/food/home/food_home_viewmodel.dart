/*
 
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:stacked/stacked.dart';
import 'package:wahiddarbar/core/models/food_models/food_category_model.dart';
import 'package:wahiddarbar/core/models/food_models/food_category_search_model.dart';
import 'package:wahiddarbar/core/models/food_models/food_model.dart';
import 'package:wahiddarbar/core/services/category_service.dart';
import 'package:wahiddarbar/core/services/user_service.dart';
import 'package:wahiddarbar/core/utilities/service_locator.dart';
import 'package:wahiddarbar/ui/helpers/utils.dart';
import 'package:wahiddarbar/ui/pages/food/search/food_search_view.dart';

class FoodHomeViewModel extends FutureViewModel {
  final CategoryService _categoryService = locator<CategoryService>();
  final UserService _userService = locator<UserService>();

  List<FoodModel> latestFoods = List<FoodModel>();
  List<FoodCategoryModel> categories = List<FoodCategoryModel>();
  var sliderImages = List<CachedNetworkImage>();

  @override
  Future<void> futureToRun() async {
    await initialize();
  }

  Future<void> initialize() async {
    await loadSliderImages();
    await loadCategories();
    notifyListeners();
  }

  Future<void> loadSliderImages() async {
    setBusy(true);
    var result = await _userService.loadSliders();
    if (result.isSuccess == false) {
      print(result.message);
      setBusy(false);
      notifyListeners();
      return;
    }

    var img1 = Utils.createCachedImage(imageUrl: result.result[0]);
    sliderImages.add(img1);
    var img2 = Utils.createCachedImage(imageUrl: result.result[1]);
    sliderImages.add(img2);

    setBusy(false);
    notifyListeners();
  }

  Future<void> loadCategories() async {
    setBusy(true);
    var model = FoodCategorySearchModel.all(perPage: 100);
    var result = await _categoryService.allCategories(model);
    if (result.isSuccess == false) {
      print(result.message);
      setBusy(false);
      notifyListeners();
      return;
    }
    categories.clear();
    categories.addAll(result.results);
    setBusy(false);
    notifyListeners();
  }

  goToSearchPage(BuildContext context, FocusNode node) {
    node.unfocus();
    pushNewScreen(
      context,
      screen: FoodSearchView(),
      withNavBar: false,
      pageTransitionAnimation: PageTransitionAnimation.fade,
    );
  }
}
