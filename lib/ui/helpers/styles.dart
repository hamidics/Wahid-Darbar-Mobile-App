/*
 
 */

import 'package:wahiddarbar/ui/helpers/colors.dart';
import 'package:flutter/material.dart';

class TextStyles {
  static const OrangeText = TextStyle(
    color: ThemeColors.Fb,
  );
  static const SalePrice = TextStyle(
    color: ThemeColors.Fb,
    fontWeight: FontWeight.w700,
    fontSize: 17,
  );
  static const RegularPrice = TextStyle(
    decoration: TextDecoration.lineThrough,
    decorationThickness: 1.5,
    decorationColor: ThemeColors.Grey700,
    decorationStyle: TextDecorationStyle.solid,
    fontSize: 17,
  );
  static const BottomNav = TextStyle(
    fontSize: 17,
  );
  static const FoodHomeTitle = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.bold,
  );

  static const DetailSalePrice = TextStyle(
    color: ThemeColors.Fb,
    fontWeight: FontWeight.w700,
    fontSize: 17,
  );
  static const DetailPrice = TextStyle(
    color: ThemeColors.Grey700,
    fontWeight: FontWeight.w700,
    fontSize: 17,
  );
  static const DetailRegularPrice = TextStyle(
    decoration: TextDecoration.lineThrough,
    decorationThickness: 1.5,
    decorationColor: ThemeColors.Grey700,
    decorationStyle: TextDecorationStyle.solid,
    fontSize: 17,
  );

  static const DetailBottomSalePrice = TextStyle(
    color: ThemeColors.Grey700,
    fontWeight: FontWeight.w700,
    fontSize: 17,
  );
  static const DetailBottomPrice = TextStyle(
    color: ThemeColors.Grey700,
    fontWeight: FontWeight.w700,
    fontSize: 17,
  );
  static const DetailBottomRegularPrice = TextStyle(
    decoration: TextDecoration.lineThrough,
    decorationThickness: 1.5,
    decorationColor: ThemeColors.Grey700,
    decorationStyle: TextDecorationStyle.solid,
    fontSize: 17,
  );
}
