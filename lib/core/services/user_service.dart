/*
 
 */

import 'package:wahiddarbar/core/models/common_models/result_model.dart';
import 'package:wahiddarbar/core/models/user_models/user_authenticate_model.dart';
import 'package:wahiddarbar/core/services/global_service.dart';

abstract class UserService {
  GlobalService globalService;

  Future<ResultModel<DigitsResponseModel>> sendOtp(DigitsRequestModel model);

  Future<ResultModel<DigitsResponseModel>> verifyOtp(DigitsRequestModel model);

  Future<ResultModel<DigitsResponseModel>> oneClick(DigitsRequestModel model);

  Future<ResultModel<List<String>>> loadSliders();

  Future<ResultModel<bool>> checkAvailablity();
}
