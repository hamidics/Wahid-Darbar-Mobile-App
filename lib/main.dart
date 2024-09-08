

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/common/connection_service.dart';
import 'core/common/navigation_service.dart';
import 'core/utilities/router.dart' as router;
import 'core/utilities/service_locator.dart';
import 'ui/helpers/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupServices();
  ConnectionService.getInstance().initialize();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) => runApp(
      EasyLocalization(
        child: WahidDarbarApp(),
        supportedLocales: [
          Locale('en', 'US'),
          Locale('ps', 'AF'),
        ],
        path: 'asset/resources',
        fallbackLocale: Locale('ps', 'AF'),
        startLocale: Locale('ps', 'AF'),
      ),
    ),
  );
}

class WahidDarbarApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wahid Darbar',
      debugShowCheckedModeBanner: false,
      navigatorKey: locator<NavigationService>().navigationKey,
      theme: ThemeData(
        fontFamily:
            EasyLocalization.of(context).locale.toLanguageTag() == 'ps-AF'
                ? 'IRANSans'
                : 'GillSans',
        scaffoldBackgroundColor: Colors.grey[50],
        primaryColor: ThemeColors.Yellow,
        backgroundColor: Colors.grey[50],
      ),
      initialRoute: 'splash',
      onGenerateRoute: router.Router.generateRoute,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
    );
  }
}
