/*
 
 */

class DigitsRequestModel {
  String countryCode = '+93';
  String mobileNo;
  String otp;
  String ftoken;
  String type;

  DigitsRequestModel();

  DigitsRequestModel.set({
    this.countryCode = '+93',
    this.mobileNo,
    this.otp,
    this.ftoken,
    this.type,
  });

  String sendOtpQuery() =>
      '?countrycode=$countryCode&mobileNo=$mobileNo&type=$type';

  String verifyOtpQuery() =>
      '?countrycode=$countryCode&mobileNo=$mobileNo&type=$type&otp=$otp&ftoken=$ftoken';

  String oneClickQuery() =>
      '?countrycode=$countryCode&mobileNo=$mobileNo&otp=$otp&ftoken=$ftoken';

  Map<String, dynamic> oneClick() => {
        'countrycode': countryCode,
        'mobileNo': mobileNo,
        'otp': otp,
        'ftoken': ftoken,
      };
}

class DigitsResponseModel {
  bool success;
  String message;
  int code;
  int firebase;
  DigitsResponseDataModel data;

  DigitsResponseModel();

  DigitsResponseModel.set({
    this.success,
    this.message,
    this.code,
    this.firebase,
    this.data,
  });

  factory DigitsResponseModel.fromJson(Map<String, dynamic> json) =>
      DigitsResponseModel.set(
        success: json['success'],
        message: json['message'],
        code: json['code'],
        firebase: json['firebase'],
        data: json['data'] != null
            ? DigitsResponseDataModel.fromJson(json['data'])
            : null,
      );
}

class DigitsResponseDataModel {
  String userId;
  String accessToken;
  String tokenType;
  int code;
  String msg;
  int level;

  DigitsResponseDataModel();

  DigitsResponseDataModel.set({
    this.userId,
    this.accessToken,
    this.tokenType,
    this.code,
    this.msg,
    this.level,
  });

  factory DigitsResponseDataModel.fromJson(Map<String, dynamic> json) =>
      DigitsResponseDataModel.set(
        userId: json['user_id'],
        accessToken: json['access_token'],
        tokenType: json['token_type'],
        code: json['code'],
        msg: json['msg'],
        level: json['level'],
      );
}
