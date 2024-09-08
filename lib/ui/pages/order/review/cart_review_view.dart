/*
 
 */

import 'package:wahiddarbar/core/models/customer_models/customer_model.dart';
import 'package:wahiddarbar/core/models/order_models/order_food_item_model.dart';
import 'package:wahiddarbar/core/utilities/static_methods.dart';
import 'package:wahiddarbar/ui/helpers/colors.dart';
import 'package:wahiddarbar/ui/helpers/styles.dart';
import 'package:wahiddarbar/ui/helpers/utils.dart';
import 'package:wahiddarbar/ui/pages/order/review/cart_review_viewmodel.dart';
import 'package:wahiddarbar/ui/widgets/busy_overlay.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:easy_localization/easy_localization.dart';

class CartReviewView extends StatelessWidget {
  const CartReviewView({Key key, this.customer}) : super(key: key);

  final CustomerModel customer;

  @override
  Widget build(BuildContext context) {
    var screenSize = SM.getSize(context);
    return ViewModelBuilder<CartReviewViewModel>.reactive(
      builder: (context, viewModel, child) => Scaffold(
        resizeToAvoidBottomPadding: true,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text('submitOrder').tr(),
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
                      Container(
                        margin: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                        ),
                        child: Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(4),
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              ),
                              border: Border.all(
                                color: Colors.grey.shade200,
                              ),
                            ),
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  title: Text(
                                    customer.billing.firstName +
                                        ' ' +
                                        customer.billing.lastName,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                ),
                                ListTile(
                                  title: Text(
                                    'orderAddress',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700),
                                  ).tr(namedArgs: {
                                    'address': customer.billing.addressOne
                                  }),
                                ),
                                ListTile(
                                  title: Container(
                                    width: double.infinity,
                                    child: FlatButton(
                                      child: Text('editInformation').tr(),
                                      textColor: Colors.white,
                                      padding: EdgeInsets.all(16),
                                      onPressed: () =>
                                          viewModel.editAddress(context),
                                      color: ThemeColors.Fb,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Divider(),
                      GridView.builder(
                        shrinkWrap: true,
                        itemCount: viewModel.finalCart.length,
                        controller: viewModel.scrollController,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio:
                              (screenSize.width) / (screenSize.height * .74),
                        ),
                        itemBuilder: (context, index) {
                          var food = viewModel.finalCart[index];
                          return _FoodItem(
                            food: food,
                            screenSize: screenSize,
                          );
                        },
                      ),
                      ListTile(
                        leading: Text('finalPrice').tr(),
                        title: Text(
                          'money',
                          style: TextStyles.DetailSalePrice,
                        ).plural(int.parse(viewModel.totalPrice)),
                      ),
                      ListTile(
                        title: TextField(
                          controller: viewModel.customerNotes,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'orderNotes'.tr(),
                          ),
                          maxLines: 3,
                          onSubmitted: (val) =>
                              FocusScope.of(context).requestFocus(FocusNode()),
                        ),
                      ),
                      ListTile(
                        title: Container(
                          width: double.infinity,
                          child: FlatButton(
                            child: Text('submitOrder').tr(),
                            textColor: Colors.white,
                            padding: EdgeInsets.all(16),
                            onPressed: () => viewModel.submit(context),
                            color: ThemeColors.Fb,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => CartReviewViewModel(customerModel: customer),
      onModelReady: (viewModel) => viewModel.initialize(),
    );
  }
}

class _FoodItem extends StatelessWidget {
  const _FoodItem({
    Key key,
    @required this.food,
    @required this.screenSize,
  }) : super(key: key);

  final OrderFoodItemModel food;
  final Size screenSize;

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
            SizedBox(
              height: 150,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Utils.createCachedImage(imageUrl: food.images[0].src),
              ),
            ),
            Container(
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
                  Utils.createSizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}
