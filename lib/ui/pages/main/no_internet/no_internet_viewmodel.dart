/*
 
 */

import 'package:wahiddarbar/core/utilities/base_logic_viewmodel.dart';
import 'package:url_launcher/url_launcher.dart';

class NoInternetViewModel extends BaseLogicViewModel {
  call(String s) {
    _launch('tel:+93$s');
  }

  void _launch(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
