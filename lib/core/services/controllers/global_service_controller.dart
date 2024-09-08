/*
 
 */

import 'dart:convert';

import 'package:wahiddarbar/core/services/global_service.dart';
import 'package:wahiddarbar/ui/pages/food/list/food_list_viewmodel.dart';
import 'package:wahiddarbar/ui/pages/main/home/home_viewmodel.dart';

class GlobalServiceController implements GlobalService {
  @override
  String apiUrl = 'https://www.wahiddarbar.com/wp-json/wc/v3/';

  @override
  String consumerKey = 'ck_eb4beeaf9c32584a93e62bd81baf18ce39eac42c';

  @override
  String secretCode = 'cs_a3d47acaac4d18740aff0facd66cc0cabd26b073';

  @override
  String authenticationUrl = 'https://www.wahiddarbar.com/wp-json/digits/v1/';

  @override
  String wpUrl = 'https://www.wahiddarbar.com/wp-json/wp/v2/';

  @override
  HomeViewModel homeViewModel;

  @override
  FoodListViewModel foodListViewModel;

  @override
  String generateUrl(String endPoint) {
    var url = apiUrl +
        endPoint +
        '?consumer_key=' +
        consumerKey +
        '&consumer_secret=' +
        secretCode;
    return url;
  }

  @override
  String addKeys(String url) {
    url =
        url + 'consumer_key=' + consumerKey + '&consumer_secret=' + secretCode;
    return url;
  }

  @override
  String addLanguage(String url, String language) {
    var lang = '';
    if (language == 'ps-AF') {
      lang = 'fa';
    } else if (language == 'en-US') {
      lang = 'en';
    }
    url = url + '&lang=' + lang;
    return url;
  }

  @override
  String authorizationHeader() =>
      'Basic ' + base64Encode(utf8.encode('$consumerKey:$secretCode'));
}
