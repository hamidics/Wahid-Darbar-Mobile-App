/*
 
 */

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:wahiddarbar/core/models/order_models/order_food_item_model.dart';
import 'package:wahiddarbar/core/utilities/service_locator.dart';
import 'package:wahiddarbar/core/utilities/static_methods.dart';
import 'package:wahiddarbar/ui/helpers/colors.dart';
import 'package:wahiddarbar/ui/helpers/styles.dart';
import 'package:wahiddarbar/ui/helpers/utils.dart';
import 'package:wahiddarbar/ui/pages/order/cart/cart_viewmodel.dart';
import 'package:wahiddarbar/ui/widgets/busy_overlay.dart';

class CartView extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    var screenSize = SM.getSize(context);
    return ViewModelBuilder<CartViewModel>.reactive(
      disposeViewModel: false,
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          title: Text('cart').tr(),
        ),
        body: SafeArea(
          child: BusyOverlay(
            show: viewModel.isBusy,
            child: Stack(
              fit: StackFit.expand,
              children: [
                SingleChildScrollView(
                  child: ListBody(
                    children: [
                      viewModel.foods.length == 0
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Utils.createSizedBox(
                                    height: screenSize.height * 0.35),
                                FittedBox(
                                    child: Icon(
                                  Icons.remove_shopping_cart,
                                  size: 30,
                                )),
                                FittedBox(
                                    child: Text(
                                  'cartIsEmpty',
                                  style: TextStyle(fontSize: 19),
                                ).tr()),
                              ],
                            )
                          : GridView.builder(
                              shrinkWrap: true,
                              itemCount: viewModel.foods.length,
                              controller: _scrollController,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                              ),
                              itemBuilder: (context, index) {
                                var food = viewModel.foods[index];
                                return _FoodItem(
                                  food: food,
                                  screenSize: screenSize,
                                  addFunction: () => viewModel.add(food),
                                  removeFunction: () => viewModel.remove(food),
                                  removeItemFunction: () =>
                                      viewModel.removeItem(food),
                                );
                              },
                            ),
                      Visibility(
                        visible: viewModel.orderService.cart.length > 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            FlatButton(
                              onPressed: () {},
                              child: FittedBox(
                                child: Text(
                                  'money',
                                  style: TextStyle(
                                      color: ThemeColors.Fb, fontSize: 19),
                                ).plural(int.parse(viewModel.totalPrice)),
                              ),
                              color: Colors.white,
                            ),
                            FlatButton(
                              onPressed: () => viewModel.goToCheckOut(context),
                              child: FittedBox(
                                child: Text(
                                  'finishOrder',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17),
                                ).tr(),
                              ),
                              color: ThemeColors.Fb,
                            ),
                          ],
                        ),
                      ),
                      Utils.createSizedBox(height: screenSize.height * .17)
                    ],
                  ),
                ),
                // Visibility(
                //   visible: viewModel.orderService.cart.length > 0,
                //   child: Positioned(
                //     bottom: screenSize.height * .07,
                //     child: Container(
                //       height: screenSize.height * 0.1,
                //       width: screenSize.width,
                //       color: ThemeColors.Fb,
                //       child: Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.end,
                //           children: [
                //             Padding(
                //               padding: const EdgeInsets.all(8.0),
                //               child: RaisedButton(
                //                 onPressed: () =>
                //                     viewModel.goToCheckOut(context),
                //                 child: Row(
                //                   children: [
                //                     Text('finishOrder').tr(),
                //                     Icon(Icons.playlist_add_check),
                //                   ],
                //                 ),
                //                 color: Colors.white,
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //     ),
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => locator<CartViewModel>(),
      onModelReady: (viewModel) => viewModel.initialize(),
    );
  }
}

class _FoodItem extends StatelessWidget {
  const _FoodItem({
    Key key,
    @required this.food,
    @required this.screenSize,
    @required this.addFunction,
    @required this.removeFunction,
    @required this.removeItemFunction,
  }) : super(key: key);

  final OrderFoodItemModel food;
  final Size screenSize;
  final Function addFunction;
  final Function removeFunction;
  final Function removeItemFunction;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(
            width: 1.0,
            color: Colors.grey[200],
          ),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: FittedBox(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: (food.images.length > 0)
                      ? Utils.createCachedImage(imageUrl: food.images[0].src)
                      : Utils.createAssetImage(
                          imageUrl: 'asset/images/no-image.png'),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    FittedBox(
                      child: Text(
                        food.name,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    (() {
                      if (food.salePrice != '') {
                        return Column(
                          children: [
                            Text(
                              'money',
                              style: TextStyles.RegularPrice,
                            ).plural(
                              int.parse(food.regularPrice),
                            ),
                            Text(
                              'money',
                              style: TextStyles.SalePrice,
                            ).plural(
                              int.parse(food.salePrice),
                            ),
                            Text(
                              food.calculateDiscount().toString() + '%',
                              style: TextStyles.DetailPrice,
                            ),
                          ],
                        );
                      } else {
                        return Column(
                          children: [
                            Text(
                              'money',
                              style: TextStyles.SalePrice,
                            ).plural(
                              int.parse(food.regularPrice),
                            ),
                          ],
                        );
                      }
                    }()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          child: Icon(
                            Icons.remove,
                            size: 24,
                            color: Colors.grey.shade700,
                          ),
                          onTap: () => removeFunction(),
                        ),
                        Utils.createSizedBox(width: 8),
                        Container(
                          color: Colors.grey.shade200,
                          padding: const EdgeInsets.only(
                              bottom: 2, right: 12, left: 12),
                          child: Text(
                            food.quantity.toString(),
                          ),
                        ),
                        Utils.createSizedBox(width: 8),
                        GestureDetector(
                          child: Icon(
                            Icons.add,
                            size: 24,
                            color: Colors.grey.shade700,
                          ),
                          onTap: () => addFunction(),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 4),
        child: Align(
          alignment: Alignment.topLeft,
          child: GestureDetector(
            onTap: () => removeItemFunction(),
            child: Container(
              width: 24,
              height: 24,
              alignment: Alignment.center,
              margin: EdgeInsets.only(right: 10, top: 8),
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: 20,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  color: ThemeColors.Red),
            ),
          ),
        ),
      )
    ]);
  }
}
