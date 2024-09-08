/*
 
 */

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shape_of_view/shape_of_view.dart';
import 'package:wahiddarbar/core/models/user_models/user_authenticate_model.dart';
import 'package:wahiddarbar/core/utilities/base_logic_viewmodel.dart';
import 'package:wahiddarbar/ui/helpers/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:wahiddarbar/ui/helpers/utils.dart';

class AuthenticationViewModel extends BaseLogicViewModel {
  TextEditingController phoneController = TextEditingController();
  TextEditingController code = TextEditingController();

  var languages = ['ps_AF', 'en_US'];

  var currentLang;

  initialize(BuildContext context) {
    currentLang = EasyLocalization.of(context).locale;
    print(currentLang.toString());
  }

  void setLanguage(BuildContext context, String language) {
    if (language == 'en_US') {
      context.locale = EasyLocalization.of(context).supportedLocales[0];
      currentLang = EasyLocalization.of(context).supportedLocales[0];
    } else {
      context.locale = EasyLocalization.of(context).supportedLocales[1];
      currentLang = EasyLocalization.of(context).supportedLocales[1];
    }
    // Navigator.pop(context);
    notifyListeners();
  }

  String validateNumber(String phone) {
    var regEx = RegExp(r'^(?:[+0]9)?[0-9]{10}$');
    if (!regEx.hasMatch(phone)) {
      return 'enterMobile'.tr();
    } else
      return null;
  }

  void sendOtp(BuildContext context) async {
    if (phoneController.text.trim().length <= 9) {
      showError('enterCorrectMobile'.tr());
      return;
    }

    setBusy(true);
    String phone = phoneController.text.trim();
    var sendOtpModel =
        DigitsRequestModel.set(mobileNo: phone, type: 'register');
    var result = await userService.sendOtp(sendOtpModel);
    if (result.isSuccess == false) {
      showError(result.message);
      print(result.message);
      setBusy(false);
      notifyListeners();
      return;
    }

    if (result.result.code == -1 &&
        result.result.message == 'Mobile Number already in use!') {
      sendOtpModel.type = 'login';
      result = await userService.sendOtp(sendOtpModel);
    }

    await firebaseMethod(context, phone, sendOtpModel.type);

    notifyListeners();
  }

  Future<void> firebaseMethod(
      BuildContext context, String phone, String type) async {
    auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

    await _auth.verifyPhoneNumber(
      phoneNumber: '+93' + phone,
      timeout: Duration(seconds: 120),
      verificationCompleted: (auth.PhoneAuthCredential credential) {},
      verificationFailed: (auth.FirebaseAuthException exception) {
        print(exception);
      },
      codeSent: (String verificationId, [int forceResendingToken]) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                title: Text("enterCode").tr(),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      controller: code,
                      keyboardType: TextInputType.phone,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      textInputAction: TextInputAction.done,
                      onSubmitted: (val) async {
                        await verifyLogin(
                            context, verificationId, _auth, phone, type);
                      },
                    ),
                  ],
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text("confirm").tr(),
                    textColor: Colors.white,
                    color: ThemeColors.Fb,
                    onPressed: () async {
                      await verifyLogin(
                          context, verificationId, _auth, phone, type);
                    },
                  )
                ],
              );
            });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print(verificationId);
      },
    );
  }

  Future verifyLogin(BuildContext context, String verificationId,
      auth.FirebaseAuth _auth, String phone, String type) async {
    Navigator.pop(context);
    final _code = code.text.trim();
    auth.PhoneAuthCredential credential = auth.PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: _code);

    var authResult = await _auth.signInWithCredential(credential);

    var firebaseUser = authResult.user;

    if (firebaseUser != null) {
      var ftoken = await firebaseUser.getIdToken();
      var verifyOtpModel = DigitsRequestModel.set(
        mobileNo: phone,
        otp: _code,
        type: type,
        ftoken: ftoken,
      );
      var verifyResult = await userService.verifyOtp(verifyOtpModel);

      if (verifyResult.result.code == 1) {
        var oneClickModel = DigitsRequestModel.set(
          mobileNo: phone,
          otp: _code,
          ftoken: ftoken,
        );
        var loginResult = await userService.oneClick(oneClickModel);
        if (loginResult.result.success) {
          navigationService.pushNamedAndRemoveUntil('home');
          setBusy(false);
        }
      }
    } else {
      print("Error");
    }
  }

  openChangeLanguageDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                'changeLanguage',
                style: TextStyle(color: ThemeColors.Fb),
              ).tr(),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => setLanguage(context, 'en_US'),
                    child: ShapeOfView(
                      shape: CircleShape(
                        borderColor: getColor('us'),
                        borderWidth: 2,
                      ),
                      child: Utils.createSingleAssetImageBox(
                          height: 64, width: 64, image: 'asset/images/us.png'),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => setLanguage(context, 'ps_AF'),
                    child: ShapeOfView(
                      shape: CircleShape(
                        borderColor: getColor('af'),
                        borderWidth: 2,
                      ),
                      child: Utils.createSingleAssetImageBox(
                          height: 64, width: 64, image: 'asset/images/af.png'),
                    ),
                  ),
                ],
              ),
            ));
  }

  Color getColor(String lang) {
    if (currentLang == Locale('en', 'US') && lang == 'us') {
      return ThemeColors.Red;
    } else if (currentLang == Locale('ps', 'AF') && lang == 'af') {
      return ThemeColors.Red;
    } else {
      return Colors.transparent;
    }
  }

  double getSize(String lang) {
    if (currentLang == Locale('en', 'US') && lang == 'us') {
      return 4;
    } else if (currentLang == Locale('ps', 'AF') && lang == 'af') {
      return 4;
    } else {
      return 1;
    }
  }
}
