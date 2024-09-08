/*
 
 */

import 'package:wahiddarbar/core/models/common_models/image_model.dart';

class OrderFoodItemModel {
  String name;
  int foodId;
  int quantity;
  String salePrice;
  String regularPrice;
  List<ImageModel> images;
  String total;

  OrderFoodItemModel();

  OrderFoodItemModel.create({
    this.name,
    this.foodId,
    this.quantity,
    this.salePrice,
    this.regularPrice,
    this.images,
  });

  calculateDiscount() {
    var regPrice = double.parse(regularPrice);
    var sale = salePrice != '' ? double.parse(salePrice) : regPrice;
    var discount = regPrice - sale;
    var discountPercent = (discount / regPrice) * 100;
    return discountPercent.round();
  }

  calculateTotal() =>
      quantity *
      (salePrice != '' ? int.parse(salePrice) : int.parse(regularPrice));
}
