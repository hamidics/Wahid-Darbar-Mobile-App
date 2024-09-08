/*
 
 */

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wahiddarbar/core/models/common_models/result_model.dart';
import 'package:wahiddarbar/core/models/user_models/user_authenticate_model.dart';
import 'package:wahiddarbar/core/services/global_service.dart';
import 'package:wahiddarbar/core/services/user_service.dart';

import 'global_service_controller.dart';

class UserServiceController implements UserService {
  @override
  GlobalService globalService = GlobalServiceController();

  @override
  Future<ResultModel<DigitsResponseModel>> sendOtp(
      DigitsRequestModel model) async {
    var result = ResultModel<DigitsResponseModel>();
    result.isSuccess = true;
    result.message = 'Success';
    result.result = DigitsResponseModel();

    var url =
        globalService.authenticationUrl + 'send_otp' + model.sendOtpQuery();

    print(url);

    var response = await http.get(
      url,
    );

    if (response.statusCode != 200) {
      result.isSuccess = false;
      result.message = response.body;
      return result;
    }

    var data = json.decode(response.body);

    result.result = DigitsResponseModel.fromJson(data);

    return result;
  }

  @override
  Future<ResultModel<DigitsResponseModel>> verifyOtp(
      DigitsRequestModel model) async {
    var result = ResultModel<DigitsResponseModel>();
    result.isSuccess = true;
    result.message = 'Success';
    result.result = DigitsResponseModel();

    var url =
        globalService.authenticationUrl + 'verify_otp' + model.verifyOtpQuery();

    print(url);

    var response = await http.get(
      url,
    );

    if (response.statusCode != 200) {
      result.isSuccess = false;
      result.message = response.body;
      return result;
    }

    var data = json.decode(response.body);

    result.result = DigitsResponseModel.fromJson(data);

    return result;
  }

  @override
  Future<ResultModel<DigitsResponseModel>> oneClick(
      DigitsRequestModel model) async {
    var result = ResultModel<DigitsResponseModel>();
    result.isSuccess = true;
    result.message = 'Success';
    result.result = DigitsResponseModel();

    var url = globalService.authenticationUrl + 'one_click';

    print(url);

    var response = await http.get(
      url + model.oneClickQuery(),
    );

    if (response.statusCode != 200) {
      result.isSuccess = false;
      result.message = response.body;
      return result;
    }

    var data = json.decode(response.body);

    result.result = DigitsResponseModel.fromJson(data);

    await SharedPreferences.getInstance()
        .then((value) => value.setString('userId', result.result.data.userId));

    return result;
  }

  @override
  Future<ResultModel<List<String>>> loadSliders() async {
    var result = ResultModel<List<String>>();
    result.isSuccess = true;
    result.message = 'Success';
    result.result = List<String>();

    var firstUrl = globalService.wpUrl + 'posts/324';
    var secondUrl = globalService.wpUrl + 'posts/332';

    print(firstUrl);
    print(secondUrl);

    var firstRequest = await http.get(
      firstUrl,
    );

    var secondRequest = await http.get(
      secondUrl,
    );

    if (firstRequest.statusCode != 200) {
      result.isSuccess = false;
      result.message = firstRequest.body;
      return result;
    }

    if (secondRequest.statusCode != 200) {
      result.isSuccess = false;
      result.message = secondRequest.body;
      return result;
    }

    var firstResponse = json.decode(firstRequest.body);
    var secondResponse = json.decode(secondRequest.body);

    print(firstResponse["_links"]["wp:featuredmedia"][0]["href"]);
    print(secondResponse["_links"]["wp:featuredmedia"][0]["href"]);

    var thirdRequest =
        await http.get(firstResponse["_links"]["wp:featuredmedia"][0]["href"]);

    var fourthRequest =
        await http.get(secondResponse["_links"]["wp:featuredmedia"][0]["href"]);

    if (thirdRequest.statusCode != 200) {
      result.isSuccess = false;
      result.message = thirdRequest.body;
      return result;
    }
    if (fourthRequest.statusCode != 200) {
      result.isSuccess = false;
      result.message = fourthRequest.body;
      return result;
    }

    var thirdResponse = json.decode(thirdRequest.body);
    var fourthResponse = json.decode(fourthRequest.body);

    result.result.add(thirdResponse["guid"]["rendered"]);
    result.result.add(fourthResponse["guid"]["rendered"]);

    return result;
  }

  @override
  Future<ResultModel<bool>> checkAvailablity() async {
    var result = ResultModel<bool>();
    result.isSuccess = true;
    result.message = 'Success';
    result.result = false;

    var url = globalService.wpUrl + 'posts/401';

    print(url);

    var response = await http.get(
      url,
    );

    if (response.statusCode != 200) {
      result.isSuccess = false;
      result.message = response.body;
      return result;
    }

    var data = json.decode(response.body);

    if (data['title']['rendered'] == 'open' ||
        data['title']['rendered'] == 'Open') {
      result.result = true;
    }

    return result;
  }
}
