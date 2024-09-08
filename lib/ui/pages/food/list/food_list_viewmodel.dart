/*
 
 */

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:stacked/stacked.dart';
import 'package:wahiddarbar/core/models/food_models/food_category_model.dart';
import 'package:wahiddarbar/core/models/food_models/food_model.dart';
import 'package:wahiddarbar/core/models/food_models/food_search_model.dart';
import 'package:wahiddarbar/core/models/order_models/order_line_item_model.dart';
import 'package:wahiddarbar/core/services/food_service.dart';
import 'package:wahiddarbar/core/services/global_service.dart';
import 'package:wahiddarbar/core/services/order_service.dart';
import 'package:wahiddarbar/core/utilities/enums.dart';
import 'package:wahiddarbar/core/utilities/service_locator.dart';
import 'package:wahiddarbar/ui/helpers/colors.dart';
import 'package:wahiddarbar/ui/pages/food/search/food_search_view.dart';
import 'package:wahiddarbar/ui/pages/order/cart/cart_viewmodel.dart';

class FoodListViewModel extends FutureViewModel {
  final FoodSearchModel model;
  final String mode;
  final ScrollController scrollController;
  final FoodCategoryModel categoryModel;

  FoodListViewModel({
    this.mode,
    this.model,
    this.categoryModel,
    this.scrollController,
  });

  final FoodService _foodService = locator<FoodService>();
  final OrderService _orderService = locator<OrderService>();
  final GlobalService _globalService = locator<GlobalService>();

  List<FoodModel> foods = List<FoodModel>();

  @override
  Future futureToRun() async {
    await initialize();
  }

  Future<void> initialize() async {
    _globalService.foodListViewModel = this;

    if (mode == FoodSearchModel.Search) {
      await getFoods(ActionType.Search);
    } else if (mode == FoodSearchModel.Latest) {
      await getFoods(ActionType.Latest);
    } else if (mode == FoodSearchModel.Category) {
      await getFoods(ActionType.Category);
    }

    scrollController.addListener(() async {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        model.page++;
        if (mode == FoodSearchModel.Search) {
          await getFoods(ActionType.Search);
        } else if (mode == FoodSearchModel.Latest) {
          await getFoods(ActionType.Latest);
        } else if (mode == FoodSearchModel.Category) {
          await getFoods(ActionType.Category);
        }
        print(foods.length);
      }
    });
    print(foods.length);
  }

  var itemsLoaded = false;

  setItemsLoaded(bool value) {
    itemsLoaded = value;
    notifyListeners();
  }

  Future<void> getFoods(ActionType actionType) async {
    setBusy(true);
    setItemsLoaded(false);
    var result = await _foodService.list(model, actionType);
    if (result.isSuccess == false) {
      print(result.message);
      setBusy(false);
      notifyListeners();
      return;
    }
    if (model.page == 1) foods.clear();
    foods.addAll(result.results);
    setBusy(false);
    notifyListeners();
    setItemsLoaded(true);
  }

  goToSearchPage(BuildContext context, FocusNode node) {
    node.unfocus();
    pushNewScreen(
      context,
      screen: FoodSearchView(
        category: categoryModel,
      ),
      withNavBar: false,
      pageTransitionAnimation: PageTransitionAnimation.fade,
    );
  }

  void addToCart(FoodModel food) {
    _orderService.add(
        lineItem: OrderLineItemModel.createItem(
          name: food.name,
          productId: food.id,
          price: food.price,
          quantity: 1,
        ),
        food: food);

    var text = 'addedToCart'.tr(namedArgs: {'food': food.name});

    final _cartViewModel = locator<CartViewModel>();

    if (_cartViewModel != null) {
      _cartViewModel.calculateTotalPrice();
    }

    _globalService.homeViewModel
        .showSnackbar(color: ThemeColors.Fb, message: text);

    _globalService.homeViewModel.notifyListeners();
    notifyListeners();
  }
}
