/*
 
 */

import 'package:wahiddarbar/core/utilities/base_logic_viewmodel.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoViewModel extends BaseLogicViewModel {
  void telegramChannel() {
    _launch('https://t.me/wahiddarbar1');
  }

  void telegramOrder() {
    _launch('https://t.me/wahiddarbaar1');
  }

  void facebook() {
    _launch('https://fb.com/wahiddarbar1');
  }

  void whatsapp() {
    _launch('https://wa.me/93790696369');
  }

  void _launch(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
