/*
 
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:stacked/stacked.dart';
import 'package:wahiddarbar/core/models/food_models/food_category_model.dart';
import 'package:wahiddarbar/core/models/food_models/food_search_model.dart';
import 'package:wahiddarbar/core/utilities/service_locator.dart';
import 'package:wahiddarbar/core/utilities/static_methods.dart';
import 'package:wahiddarbar/ui/helpers/borders.dart';
import 'package:wahiddarbar/ui/helpers/utils.dart';
import 'package:wahiddarbar/ui/pages/food/list/food_list_view.dart';
import 'package:wahiddarbar/ui/widgets/busy_overlay.dart';

import 'food_home_viewmodel.dart';

class FoodHomeView extends StatelessWidget {
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    var screenSize = SM.getSize(context);
    return ViewModelBuilder<FoodHomeViewModel>.reactive(
      disposeViewModel: false,
      initialiseSpecialViewModelsOnce: true,
      builder: (context, viewModel, child) => Scaffold(
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
          child: BusyOverlay(
            show: viewModel.isBusy,
            child: Stack(
              fit: StackFit.expand,
              children: [
                SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: ListBody(
                    children: [
                      _Slider(
                        screenSize: screenSize,
                        images: viewModel.sliderImages,
                      ),
                      _Categories(
                        screenSize: screenSize,
                        categories: viewModel.categories,
                      ),
                      Utils.createSizedBox(height: screenSize.height * .1),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => locator<FoodHomeViewModel>(),
    );
  }
}

class _Slider extends StatelessWidget {
  const _Slider({
    Key key,
    @required this.screenSize,
    @required this.images,
  }) : super(key: key);

  final Size screenSize;
  final List<CachedNetworkImage> images;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenSize.width * 0.9,
      height: screenSize.width * 0.4,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white54,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: (images.length > 0)
            ? Carousel(
                images: images,
                autoplay: true,
                showIndicator: false,
                borderRadius: true,
                radius: Radius.circular(8.0),
              )
            : Container(),
      ),
    );
  }
}

class _Categories extends StatelessWidget {
  const _Categories({
    Key key,
    @required this.screenSize,
    @required this.categories,
  }) : super(key: key);

  final Size screenSize;
  final List<FoodCategoryModel> categories;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: screenSize.height * 0.54),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  var category = categories[index];
                  return _CategoryItem(
                    category: category,
                    screenSize: screenSize,
                  );
                },
                itemCount: categories.length,
              ),
            ),
            Utils.createSizedBox(height: screenSize.height * .1)
          ],
        ),
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  const _CategoryItem({
    Key key,
    @required this.category,
    @required this.screenSize,
  }) : super(key: key);

  final FoodCategoryModel category;
  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        pushNewScreen(
          context,
          screen: FoodListView(
            mode: FoodSearchModel.Category,
            model: FoodSearchModel.category(
              category: category.id.toString(),
            ),
            title: category.name,
            categoryModel: category,
          ),
          withNavBar: true,
          pageTransitionAnimation: PageTransitionAnimation.fade,
        );
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Column(
                children: [
                  Container(
                    child:
                        Utils.createCachedImage(imageUrl: category.image.src),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                  ),
                  // Utils.createSizedBox(height: 8),
                  // Text(
                  //   category.name,
                  //   overflow: TextOverflow.ellipsis,
                  //   textWidthBasis: TextWidthBasis.parent,
                  //   softWrap: true,
                  //   textAlign: TextAlign.center,
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
