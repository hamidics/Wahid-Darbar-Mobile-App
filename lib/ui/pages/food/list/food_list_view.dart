/*
 
 */

import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:wahiddarbar/core/models/food_models/food_category_model.dart';
import 'package:wahiddarbar/core/models/food_models/food_model.dart';
import 'package:wahiddarbar/core/models/food_models/food_search_model.dart';
import 'package:wahiddarbar/core/utilities/static_methods.dart';
import 'package:wahiddarbar/ui/helpers/borders.dart';
import 'package:wahiddarbar/ui/helpers/colors.dart';
import 'package:wahiddarbar/ui/helpers/styles.dart';
import 'package:wahiddarbar/ui/helpers/utils.dart';
import 'package:wahiddarbar/ui/pages/food/list/food_list_viewmodel.dart';

class FoodListView extends StatelessWidget {
  FoodListView({
    Key key,
    this.mode,
    this.model,
    this.title,
    this.categoryModel,
  }) : super(key: key);

  final String mode;
  final FoodSearchModel model;
  final String title;
  final FoodCategoryModel categoryModel;
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final FocusNode _focusNode = FocusNode();
    var screenSize = SM.getSize(context);
    return ViewModelBuilder<FoodListViewModel>.reactive(
      builder: (context, viewModel, child) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: TextField(
            focusNode: _focusNode,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              enabledBorder: ThemeBorders.enabledBorder,
              focusedBorder: ThemeBorders.focusBorder,
              contentPadding: const EdgeInsets.all(10),
              hintText: 'search'.tr(),
            ),
            onTap: () => viewModel.goToSearchPage(context, _focusNode),
          ),
        ),
        body: SafeArea(
          child: Stack(
            fit: StackFit.expand,
            children: [
              (viewModel.foods.length == 0)
                  ? _Loading(
                      screenSize: screenSize, loading: viewModel.itemsLoaded)
                  : SingleChildScrollView(
                      physics: NeverScrollableScrollPhysics(),
                      child: ListBody(
                        children: [
                          ConstrainedBox(
                            constraints: BoxConstraints(
                                maxHeight: screenSize.height * .8),
                            child: GridView.builder(
                              controller: _scrollController,
                              itemCount: viewModel.foods.length + 1,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                              ),
                              itemBuilder: (context, index) {
                                return (index == viewModel.foods.length)
                                    // ? _NoFoodItem()
                                    ? _FoodItemLoading(
                                        loading: viewModel.itemsLoaded)
                                    : _FoodItem(
                                        food: viewModel.foods[index],
                                        screenSize: screenSize,
                                        callBack: () => viewModel
                                            .addToCart(viewModel.foods[index]),
                                      );
                              },
                            ),
                          ),
                          Utils.createSizedBox(height: screenSize.height * .1),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => FoodListViewModel(
        mode: mode,
        model: model,
        categoryModel: categoryModel,
        scrollController: _scrollController,
      ),
    );
  }
}

class _FoodItem extends StatelessWidget {
  const _FoodItem({
    Key key,
    @required this.food,
    @required this.screenSize,
    @required this.callBack,
  }) : super(key: key);

  final FoodModel food;
  final Size screenSize;
  final Function callBack;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => callBack(),
      child: Container(
        margin: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(
            width: 1.0,
            color: Colors.grey[200],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: FittedBox(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: (food.images.length > 0 && food.images != null)
                      ? Utils.createCachedImage(imageUrl: food.images[0].src)
                      : Utils.createAssetImage(
                          imageUrl: 'asset/images/no-image.png'),
                ),
              ),
            ),
            Utils.createSizedBox(height: 8),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: food.salePrice != '',
                  child: Container(
                    width: 48,
                    height: 24,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 4, top: 4),
                    child: Text(
                      food.calculateDiscount().toString() + '%',
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        color: ThemeColors.Fb),
                  ),
                ),
                Utils.createSizedBox(height: 8),
                (() {
                  if (food.salePrice != '') {
                    return Padding(
                      padding: EdgeInsets.only(
                          right: screenSize.width * 0.02,
                          left: screenSize.width * 0.02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          ).plural(int.parse(food.salePrice))
                        ],
                      ),
                    );
                  } else {
                    return Text(
                      'money',
                      style: TextStyles.SalePrice,
                    ).plural(
                      int.parse(food.regularPrice),
                    );
                  }
                }()),
                Utils.createSizedBox(height: 8),
                IconButton(
                  icon: Icon(
                    MdiIcons.plusBox,
                    color: ThemeColors.Fb,
                  ),
                  onPressed: () => callBack(),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _NoFoodItem extends StatelessWidget {
  const _NoFoodItem({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
          width: 1.0,
          color: Colors.grey[200],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child:
                  Utils.createAssetImage(imageUrl: 'asset/images/no-image.png'),
            ),
          ),
          Utils.createSizedBox(height: 8),
          FittedBox(
            child: Text(
              'notFound',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ).tr(),
          ),
          Utils.createSizedBox(height: 8),
        ],
      ),
    );
  }
}

// ignore: unused_element
class _RatingStars extends StatelessWidget {
  final int rating;

  _RatingStars(this.rating);

  @override
  Widget build(BuildContext context) {
    String stars = '';
    for (int i = 0; i < rating; i++) {
      stars += '⭐  ';
    }
    stars.trim();
    return Text(
      stars,
      style: TextStyle(
        fontSize: 18.0,
      ),
    );
  }
}

class _Loading extends StatefulWidget {
  _Loading({
    Key key,
    this.screenSize,
    this.loading,
  }) : super(key: key);

  final Size screenSize;
  final bool loading;

  @override
  __LoadingState createState() => __LoadingState();
}

class __LoadingState extends State<_Loading> {
  Widget _widget;

  Timer _timer;

  @override
  void initState() {
    super.initState();

    _widget = AnimatedPositioned(
      child: Image.asset(
        'asset/images/loader.gif',
        height: widget.screenSize.height * .15,
      ),
      duration: Duration(milliseconds: 0),
      bottom: widget.screenSize.height * .4,
      left: widget.screenSize.width * -1,
    );
    Timer(Duration(seconds: 1), () {
      setState(() {
        _widget = AnimatedPositioned(
            child: Image.asset(
              'asset/images/loader.gif',
              height: widget.screenSize.height * .15,
            ),
            duration: Duration(milliseconds: 1000),
            bottom: widget.screenSize.height * .4,
            left: widget.screenSize.width * .4);
      });
    });
  }

  __LoadingState() {
    _timer = Timer(Duration(seconds: 20), () {
      if (widget.loading) {
        setState(() {
          // _widget = Text('notFound').tr();
          _widget = _NoFoodItem();
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return _widget;
  }
}

class _FoodItemLoading extends StatefulWidget {
  _FoodItemLoading({Key key, this.loading}) : super(key: key);

  final bool loading;

  @override
  __FoodItemLoading createState() => __FoodItemLoading();
}

class __FoodItemLoading extends State<_FoodItemLoading> {
  Widget _widget;

  Timer _timer;

  @override
  void initState() {
    super.initState();

    _widget = SpinKitRing(
      color: ThemeColors.Fb,
    );
  }

  __FoodItemLoading() {
    _timer = Timer(Duration(seconds: 20), () {
      if (widget.loading) {
        setState(() {
          _widget = _NoFoodItem();
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return _widget;
  }
}
