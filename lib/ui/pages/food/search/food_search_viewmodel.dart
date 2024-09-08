/*
 
 */

import 'package:wahiddarbar/core/models/food_models/food_category_model.dart';
import 'package:wahiddarbar/core/models/food_models/food_model.dart';
import 'package:wahiddarbar/core/models/food_models/food_search_model.dart';
import 'package:wahiddarbar/core/models/order_models/order_line_item_model.dart';
import 'package:wahiddarbar/core/utilities/enums.dart';
import 'package:wahiddarbar/core/utilities/base_logic_viewmodel.dart';
import 'package:wahiddarbar/core/utilities/service_locator.dart';
import 'package:wahiddarbar/ui/helpers/colors.dart';
import 'package:wahiddarbar/ui/pages/order/cart/cart_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:wahiddarbar/ui/pages/order/cart/cart_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';

class FoodSearchViewModel extends BaseLogicViewModel {
  List<FoodModel> foods = List<FoodModel>();

  final FoodCategoryModel category;

  FoodSearchViewModel({Key key, this.category});

  var itemsLoaded = false;

  setItemsLoaded(bool value) {
    itemsLoaded = value;
    notifyListeners();
  }

  Future<void> loadFoods(FocusNode node, String value) async {
    setBusy(true);
    node.unfocus();
    setItemsLoaded(false);

    var searchModel;
    if (category != null) {
      searchModel = FoodSearchModel.searchAndCategory(
          search: value, category: category.id.toString());
    } else {
      searchModel = FoodSearchModel.search(
        page: 1,
        perPage: 12,
        search: value,
      );
    }

    var result = await foodService.list(searchModel,
        (category != null) ? ActionType.SearchAndCategory : ActionType.Search);
    if (result.isSuccess == false) {
      setBusy(false);
      notifyListeners();
      return;
    }
    foods.addAll(result.results);
    setBusy(false);
    notifyListeners();
    setItemsLoaded(true);
  }

  void goToCart(BuildContext context) async {
    await pushNewScreen(
      context,
      screen: CartView(),
      withNavBar: true,
      pageTransitionAnimation: PageTransitionAnimation.scale,
    );
    globalService.homeViewModel.notifyListeners();
    notifyListeners();
  }

  void addToCart(FoodModel food) {
    orderService.add(
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

    globalService.homeViewModel
        .showSnackbar(color: ThemeColors.Fb, message: text);

    globalService.homeViewModel.notifyListeners();
    notifyListeners();
  }
}
