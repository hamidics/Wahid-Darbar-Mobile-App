/*
 
 */

import 'package:wahiddarbar/ui/pages/food/list/food_list_viewmodel.dart';
import 'package:wahiddarbar/ui/pages/main/home/home_viewmodel.dart';

abstract class GlobalService {
  String apiUrl;
  String consumerKey;
  String secretCode;
  String authenticationUrl;
  String wpUrl;

  HomeViewModel homeViewModel;

  FoodListViewModel foodListViewModel;

  String generateUrl(String endPoint);

  String addKeys(String url);

  String addLanguage(String url, String language);

  String authorizationHeader();
}
